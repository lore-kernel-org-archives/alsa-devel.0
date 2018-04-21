From: Jeffery Miller <jmiller@neverware.com>
Subject: [PATCH] ALSA: pcm: Return negative delays from
	SNDRV_PCM_IOCTL_DELAY.
Date: Fri, 20 Apr 2018 23:20:46 -0500
Message-ID: <20180421042046.33408-1-jmiller@neverware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 193262673D4
 for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2018 06:20:51 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id 186-v6so4825532itu.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 21:20:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jeffery Miller <jmiller@neverware.com>
List-Id: alsa-devel@alsa-project.org

The commit c2c86a97175f ("ALSA: pcm: Remove set_fs() in PCM core code")
changed SNDRV_PCM_IOCTL_DELAY to return an inconsistent error instead of a
negative delay.  Originally the call would succeed and return the negative
delay.  The Chromium OS Audio Server (CRAS) gets confused and hangs when
the error is returned instead of the negative delay.

Help CRAS avoid the issue by rolling back the behavior to return a
negative delay instead of an error.

Fixes: c2c86a97175f ("ALSA: pcm: Remove set_fs() in PCM core code")
Signed-off-by: Jeffery Miller <jmiller@neverware.com>
---

This patch changes the SNDRV_PCM_IOCTL_DELAY ioctl return behavior to
be similar to what it was in an earlier kernel.
I encountered this when upgrading from the 4.4 kernel to 4.14. Chrome
Audio Server (cras) does not handle the error return as gracefully
as it was handling the successful but negative delays.

The intent of this patch is to simply revert the behavior of the call
to match what it was previously.

It has been applied and tested with the 4.14 kernel. I did confirm this
is still an issue and is resolved with the patch on the tiwai/sound.git
master branch.

 sound/core/pcm_compat.c |  7 ++++---
 sound/core/pcm_native.c | 23 +++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 0be248543f1e..077008a8e1d5 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -27,10 +27,11 @@ static int snd_pcm_ioctl_delay_compat(struct snd_pcm_substream *substream,
 				      s32 __user *src)
 {
 	snd_pcm_sframes_t delay;
+	int err;
 
-	delay = snd_pcm_delay(substream);
-	if (delay < 0)
-		return delay;
+	err = snd_pcm_delay(substream, &delay);
+	if (err)
+		return err;
 	if (put_user(delay, src))
 		return -EFAULT;
 	return 0;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7585444352df..d2ba181c666e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2654,7 +2654,8 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	return err;
 }
 		
-static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
+static int snd_pcm_delay(struct snd_pcm_substream *substream,
+			 snd_pcm_sframes_t *delay)
 {
 	int err;
 	snd_pcm_sframes_t n = 0;
@@ -2664,7 +2665,9 @@ static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 	if (!err)
 		n = snd_pcm_calc_delay(substream);
 	snd_pcm_stream_unlock_irq(substream);
-	return err < 0 ? err : n;
+	if (!err)
+		*delay = n;
+	return err;
 }
 		
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
@@ -2866,11 +2869,13 @@ static int snd_pcm_common_ioctl(struct file *file,
 		return snd_pcm_hwsync(substream);
 	case SNDRV_PCM_IOCTL_DELAY:
 	{
-		snd_pcm_sframes_t delay = snd_pcm_delay(substream);
+		snd_pcm_sframes_t delay;
 		snd_pcm_sframes_t __user *res = arg;
+		int err;
 
-		if (delay < 0)
-			return delay;
+		err = snd_pcm_delay(substream, &delay);
+		if (err)
+			return err;
 		if (put_user(delay, res))
 			return -EFAULT;
 		return 0;
@@ -2958,13 +2963,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_IOCTL_DROP:
 		return snd_pcm_drop(substream);
 	case SNDRV_PCM_IOCTL_DELAY:
-	{
-		result = snd_pcm_delay(substream);
-		if (result < 0)
-			return result;
-		*frames = result;
-		return 0;
-	}
+		return snd_pcm_delay(substream, frames);
 	default:
 		return -EINVAL;
 	}
-- 
2.14.3
