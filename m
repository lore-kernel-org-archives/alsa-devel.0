From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH,
	RFC 25/30] oss: vwsnd: avoid interruptible_sleep_on
Date: Thu,  2 Jan 2014 13:07:49 +0100
Message-ID: <1388664474-1710039-26-git-send-email-arnd@arndb.de>
References: <1388664474-1710039-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B412616C9
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 13:08:36 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Interruptible_sleep_on is racy and we want to remove it. This replaces
the use in the vwsnd driver with an open-coded prepare_to_wait
loop that fixes the race between concurrent open() and close() calls,
and also drops the global mutex while waiting here, which restores
the original behavior that was changed during the BKL removal.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/oss/vwsnd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/oss/vwsnd.c b/sound/oss/vwsnd.c
index 4bbcc0f..a077e9c 100644
--- a/sound/oss/vwsnd.c
+++ b/sound/oss/vwsnd.c
@@ -2921,6 +2921,7 @@ static int vwsnd_audio_open(struct inode *inode, struct file *file)
 	vwsnd_dev_t *devc;
 	int minor = iminor(inode);
 	int sw_samplefmt;
+	DEFINE_WAIT(wait);
 
 	DBGE("(inode=0x%p, file=0x%p)\n", inode, file);
 
@@ -2937,21 +2938,26 @@ static int vwsnd_audio_open(struct inode *inode, struct file *file)
 	}
 
 	mutex_lock(&devc->open_mutex);
-	while (devc->open_mode & file->f_mode) {
+	while (1) {
+		prepare_to_wait(&devc->open_wait, &wait, TASK_INTERRUPTIBLE);
+		if (!(devc->open_mode & file->f_mode))
+			break;
+
 		mutex_unlock(&devc->open_mutex);
+		mutex_unlock(&vwsnd_mutex);
 		if (file->f_flags & O_NONBLOCK) {
 			DEC_USE_COUNT;
-			mutex_unlock(&vwsnd_mutex);
 			return -EBUSY;
 		}
-		interruptible_sleep_on(&devc->open_wait);
+		schedule();
 		if (signal_pending(current)) {
 			DEC_USE_COUNT;
-			mutex_unlock(&vwsnd_mutex);
 			return -ERESTARTSYS;
 		}
+		mutex_lock(&vwsnd_mutex);
 		mutex_lock(&devc->open_mutex);
 	}
+	finish_wait(&devc->open_wait, &wait);
 	devc->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	mutex_unlock(&devc->open_mutex);
 
-- 
1.8.3.2
