From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 09/26] ALSA: pcm: Remove set_fs() in PCM
	core code
Date: Thu, 11 May 2017 23:09:08 +0200
Message-ID: <20170511210925.18208-10-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C06AF266FE0
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 846E6AEC4
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

PCM core code has a few usages of set_fs(), mostly for two purposes:
- The DELAY ioctl call from pcm_compat.c
- The ioctl wrapper in kernel context for PCM OSS and other

This patch removes the set_fs() usage in these places by a slight code
refactoring.  For the former point, snd_pcm_delay() is changed to
return the  value directly instead of putting the value to the given
address.  The each caller stores the result in an appropriate manner.

For fixing the latter, snd_pcm_lib_kernel_ioctl() is changed to call
the functions directly as well.  Now it accepts now only the limited
set of ioctls: primarily it's used by PCM OSS layer, and the only
other user is USB UAC1 gadget driver, where both drivers don't need
the full set of ioctls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_compat.c |  12 ++----
 sound/core/pcm_native.c | 102 ++++++++++++++++++++++++++++++------------------
 2 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 1f64ab0c2a95..8a0f8d51e95d 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -27,17 +27,13 @@ static int snd_pcm_ioctl_delay_compat(struct snd_pcm_substream *substream,
 				      s32 __user *src)
 {
 	snd_pcm_sframes_t delay;
-	mm_segment_t fs;
-	int err;
 
-	fs = snd_enter_user();
-	err = snd_pcm_delay(substream, &delay);
-	snd_leave_user(fs);
-	if (err < 0)
-		return err;
+	delay = snd_pcm_delay(substream);
+	if (delay < 0)
+		return delay;
 	if (put_user(delay, src))
 		return -EFAULT;
-	return err;
+	return 0;
 }
 
 static int snd_pcm_ioctl_rewind_compat(struct snd_pcm_substream *substream,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 13dec5ec93f2..f9bd56958cad 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -181,20 +181,6 @@ void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
 
-static inline mm_segment_t snd_enter_user(void)
-{
-	mm_segment_t fs = get_fs();
-	set_fs(get_ds());
-	return fs;
-}
-
-static inline void snd_leave_user(mm_segment_t fs)
-{
-	set_fs(fs);
-}
-
-
-
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 {
 	struct snd_pcm_runtime *runtime;
@@ -1081,6 +1067,7 @@ static const struct action_ops snd_pcm_action_start = {
  * @substream: the PCM substream instance
  *
  * Return: Zero if successful, or a negative error code.
+ * The stream lock must be acquired before calling this function.
  */
 int snd_pcm_start(struct snd_pcm_substream *substream)
 {
@@ -1088,6 +1075,13 @@ int snd_pcm_start(struct snd_pcm_substream *substream)
 			      SNDRV_PCM_STATE_RUNNING);
 }
 
+/* take the stream lock and start the streams */
+static int snd_pcm_start_lock_irq(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream,
+				       SNDRV_PCM_STATE_RUNNING);
+}
+
 /*
  * stop callbacks
  */
@@ -2655,8 +2649,7 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	return err;
 }
 		
-static int snd_pcm_delay(struct snd_pcm_substream *substream,
-			 snd_pcm_sframes_t __user *res)
+static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int err;
@@ -2690,10 +2683,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 		break;
 	}
 	snd_pcm_stream_unlock_irq(substream);
-	if (!err)
-		if (put_user(n, res))
-			err = -EFAULT;
-	return err;
+	return err < 0 ? err : n;
 }
 		
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
@@ -2781,7 +2771,7 @@ static int snd_pcm_common_ioctl1(struct file *file,
 	case SNDRV_PCM_IOCTL_RESET:
 		return snd_pcm_reset(substream);
 	case SNDRV_PCM_IOCTL_START:
-		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
+		return snd_pcm_start_lock_irq(substream);
 	case SNDRV_PCM_IOCTL_LINK:
 		return snd_pcm_link(substream, (int)(unsigned long) arg);
 	case SNDRV_PCM_IOCTL_UNLINK:
@@ -2793,7 +2783,16 @@ static int snd_pcm_common_ioctl1(struct file *file,
 	case SNDRV_PCM_IOCTL_HWSYNC:
 		return snd_pcm_hwsync(substream);
 	case SNDRV_PCM_IOCTL_DELAY:
-		return snd_pcm_delay(substream, arg);
+	{
+		snd_pcm_sframes_t delay = snd_pcm_delay(substream);
+		snd_pcm_sframes_t __user *res = arg;
+
+		if (delay < 0)
+			return delay;
+		if (put_user(delay, res))
+			return -EFAULT;
+		return 0;
+	}
 	case SNDRV_PCM_IOCTL_SYNC_PTR:
 		return snd_pcm_sync_ptr(substream, arg);
 #ifdef CONFIG_SND_SUPPORT_OLD_API
@@ -3007,30 +3006,55 @@ static long snd_pcm_capture_ioctl(struct file *file, unsigned int cmd,
 				      (void __user *)arg);
 }
 
+/**
+ * snd_pcm_kernel_ioctl - Execute PCM ioctl in the kernel-space
+ * @substream: PCM substream
+ * @cmd: IOCTL cmd
+ * @arg: IOCTL argument
+ *
+ * The function is provided primarily for OSS layer and USB gadget drivers,
+ * and it allows only the limited set of ioctls (hw_params, sw_params,
+ * prepare, start, drain, drop, forward).
+ */
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 			 unsigned int cmd, void *arg)
 {
-	mm_segment_t fs;
-	int result;
+	snd_pcm_uframes_t *frames = arg;
+	snd_pcm_sframes_t result;
 	
-	fs = snd_enter_user();
-	switch (substream->stream) {
-	case SNDRV_PCM_STREAM_PLAYBACK:
-		result = snd_pcm_playback_ioctl1(NULL, substream, cmd,
-						 (void __user *)arg);
-		break;
-	case SNDRV_PCM_STREAM_CAPTURE:
-		result = snd_pcm_capture_ioctl1(NULL, substream, cmd,
-						(void __user *)arg);
-		break;
+	switch (cmd) {
+	case SNDRV_PCM_IOCTL_FORWARD:
+	{
+		/* provided only for OSS; capture-only and no value returned */
+		if (substream->stream != SNDRV_PCM_STREAM_CAPTURE)
+			return -EINVAL;
+		result = snd_pcm_capture_forward(substream, *frames);
+		return result < 0 ? result : 0;
+	}
+	case SNDRV_PCM_IOCTL_HW_PARAMS:
+		return snd_pcm_hw_params(substream, arg);
+	case SNDRV_PCM_IOCTL_SW_PARAMS:
+		return snd_pcm_sw_params(substream, arg);
+	case SNDRV_PCM_IOCTL_PREPARE:
+		return snd_pcm_prepare(substream, NULL);
+	case SNDRV_PCM_IOCTL_START:
+		return snd_pcm_start_lock_irq(substream);
+	case SNDRV_PCM_IOCTL_DRAIN:
+		return snd_pcm_drain(substream, NULL);
+	case SNDRV_PCM_IOCTL_DROP:
+		return snd_pcm_drop(substream);
+	case SNDRV_PCM_IOCTL_DELAY:
+	{
+		result = snd_pcm_delay(substream);
+		if (result < 0)
+			return result;
+		*frames = result;
+		return 0;
+	}
 	default:
-		result = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	snd_leave_user(fs);
-	return result;
 }
-
 EXPORT_SYMBOL(snd_pcm_kernel_ioctl);
 
 static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
-- 
2.12.2
