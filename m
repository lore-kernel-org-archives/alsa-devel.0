From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: fix incorrect timeout after microcode
	upload
Date: Mon, 12 Jan 2009 17:54:16 +0100
Message-ID: <20090112175416.482cdc60.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 927FA1037EC
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 17:51:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Theodore Allen <allen@hws.edu>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

A comment states that one should wait up to 5 secs
while a waiting loop waits only 5 system ticks.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Ted tested that patch and it allowed him uploading
a microcode into the Soundscape Elite. However,
midi does not work for him yet.

 sound/isa/sscape.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index bc44916..347a880 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -393,19 +393,19 @@ static int sscape_wait_dma_unsafe(unsigned io_base, enum GA_REG reg, unsigned ti
  */
 static int obp_startup_ack(struct soundscape *s, unsigned timeout)
 {
-	while (timeout != 0) {
+	unsigned long end_time = jiffies + msecs_to_jiffies(timeout);
+
+	while (time_before(jiffies, end_time)) {
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout_uninterruptible(1);
-
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
 		spin_unlock_irqrestore(&s->lock, flags);
 		if ((x & 0xfe) == 0xfe)
 			return 1;
 
-		--timeout;
+		msleep(10);
 	} /* while */
 
 	return 0;
@@ -420,19 +420,19 @@ static int obp_startup_ack(struct soundscape *s, unsigned timeout)
  */
 static int host_startup_ack(struct soundscape *s, unsigned timeout)
 {
-	while (timeout != 0) {
+	unsigned long end_time = jiffies + msecs_to_jiffies(timeout);
+
+	while (time_before(jiffies, end_time)) {
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout_uninterruptible(1);
-
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
 		spin_unlock_irqrestore(&s->lock, flags);
 		if (x == 0xfe)
 			return 1;
 
-		--timeout;
+		msleep(10);
 	} /* while */
 
 	return 0;
@@ -529,10 +529,10 @@ static int upload_dma_data(struct soundscape *s,
 	 * give it 5 seconds (max) ...
 	 */
 	ret = 0;
-	if (!obp_startup_ack(s, 5)) {
+	if (!obp_startup_ack(s, 5000)) {
 		snd_printk(KERN_ERR "sscape: No response from on-board processor after upload\n");
 		ret = -EAGAIN;
-	} else if (!host_startup_ack(s, 5)) {
+	} else if (!host_startup_ack(s, 5000)) {
 		snd_printk(KERN_ERR "sscape: SoundScape failed to initialise\n");
 		ret = -EAGAIN;
 	}
-- 
1.5.2.2


-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019
