From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH,
	RFC 23/30] oss: msnd_pinnacle: avoid interruptible_sleep_on_timeout
Date: Thu,  2 Jan 2014 13:07:47 +0100
Message-ID: <1388664474-1710039-24-git-send-email-arnd@arndb.de>
References: <1388664474-1710039-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCB6261685
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 13:08:33 +0100 (CET)
In-Reply-To: <1388664474-1710039-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Veliath <andrewtv@usa.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

We want to remove all sleep_on variants from the kernel because they are
racy. In case of the pinnacle driver, we can replace
interruptible_sleep_on_timeout with wait_event_interruptible_timeout
by changing the meaning of a few flags used in the driver so they
are cleared at wakeup time, which is a somewhat more appropriate
way to do the same, although probably still racy.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Veliath <andrewtv@usa.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/oss/msnd_pinnacle.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/sound/oss/msnd_pinnacle.c b/sound/oss/msnd_pinnacle.c
index 11ff7c5..c23f9f9 100644
--- a/sound/oss/msnd_pinnacle.c
+++ b/sound/oss/msnd_pinnacle.c
@@ -664,12 +664,15 @@ static long dev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static void dsp_write_flush(void)
 {
+	int timeout = get_play_delay_jiffies(dev.DAPF.len);
+
 	if (!(dev.mode & FMODE_WRITE) || !test_bit(F_WRITING, &dev.flags))
 		return;
 	set_bit(F_WRITEFLUSH, &dev.flags);
-	interruptible_sleep_on_timeout(
-		&dev.writeflush,
-		get_play_delay_jiffies(dev.DAPF.len));
+	wait_event_interruptible_timeout(
+		dev.writeflush,
+		!test_bit(F_WRITEFLUSH, &dev.flags),
+		timeout);
 	clear_bit(F_WRITEFLUSH, &dev.flags);
 	if (!signal_pending(current)) {
 		current->state = TASK_INTERRUPTIBLE;
@@ -897,6 +900,7 @@ static int dsp_read(char __user *buf, size_t len)
 {
 	int count = len;
 	char *page = (char *)__get_free_page(GFP_KERNEL);
+	int timeout = get_rec_delay_jiffies(DAR_BUFF_SIZE);
 
 	if (!page)
 		return -ENOMEM;
@@ -936,11 +940,11 @@ static int dsp_read(char __user *buf, size_t len)
 
 		if (count > 0) {
 			set_bit(F_READBLOCK, &dev.flags);
-			if (!interruptible_sleep_on_timeout(
-				&dev.readblock,
-				get_rec_delay_jiffies(DAR_BUFF_SIZE)))
+			if (wait_event_interruptible_timeout(
+					dev.readblock,
+					test_bit(F_READBLOCK, &dev.flags),
+					timeout) <= 0)
 				clear_bit(F_READING, &dev.flags);
-			clear_bit(F_READBLOCK, &dev.flags);
 			if (signal_pending(current)) {
 				free_page((unsigned long)page);
 				return -EINTR;
@@ -955,6 +959,7 @@ static int dsp_write(const char __user *buf, size_t len)
 {
 	int count = len;
 	char *page = (char *)__get_free_page(GFP_KERNEL);
+	int timeout = get_play_delay_jiffies(DAP_BUFF_SIZE);
 
 	if (!page)
 		return -ENOMEM;
@@ -995,10 +1000,10 @@ static int dsp_write(const char __user *buf, size_t len)
 
 		if (count > 0) {
 			set_bit(F_WRITEBLOCK, &dev.flags);
-			interruptible_sleep_on_timeout(
-				&dev.writeblock,
-				get_play_delay_jiffies(DAP_BUFF_SIZE));
-			clear_bit(F_WRITEBLOCK, &dev.flags);
+			wait_event_interruptible_timeout(
+				dev.writeblock,
+				test_bit(F_WRITEBLOCK, &dev.flags),
+				timeout);
 			if (signal_pending(current)) {
 				free_page((unsigned long)page);
 				return -EINTR;
@@ -1044,7 +1049,7 @@ static __inline__ void eval_dsp_msg(register WORD wMessage)
 			clear_bit(F_WRITING, &dev.flags);
 		}
 
-		if (test_bit(F_WRITEBLOCK, &dev.flags))
+		if (test_and_clear_bit(F_WRITEBLOCK, &dev.flags))
 			wake_up_interruptible(&dev.writeblock);
 		break;
 
@@ -1055,7 +1060,7 @@ static __inline__ void eval_dsp_msg(register WORD wMessage)
 
 		pack_DARQ_to_DARF(dev.last_recbank);
 
-		if (test_bit(F_READBLOCK, &dev.flags))
+		if (test_and_clear_bit(F_READBLOCK, &dev.flags))
 			wake_up_interruptible(&dev.readblock);
 		break;
 
-- 
1.8.3.2
