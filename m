From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH] ALSA: pcm: Fix snd_pcm_hw_params struct copy in compat mode
Date: Mon, 18 Jan 2016 11:49:18 +0800
Message-ID: <1453088958-6214-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Nicolas Boichat <drinkcat@chromium.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Running a kernel with KASan enabled, we spotted that the following
read in sound/soc/soc-pcm.c:soc_pcm_hw_params() is out of bounds:

		/* copy params for each codec */
		codec_params = *params;

The problem comes from sound/core/pcm_compat.c,
snd_pcm_ioctl_hw_params_compat, where we're copying from a
struct snd_pcm_hw_params to a struct snd_pcm_hw_params32:

	/* only fifo_size is different, so just copy all */
	data = memdup_user(data32, sizeof(*data32));

It turns out that snd_pcm_hw_params is 4 bytes longer than
snd_pcm_hw_params32, that's why an out-of-bounds read happens.

We separate kmalloc and memory copy operations to make sure
data has the correct length.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/core/pcm_compat.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index b48b434..9630e9f 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -255,10 +255,15 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 	if (! (runtime = substream->runtime))
 		return -ENOTTY;
 
-	/* only fifo_size is different, so just copy all */
-	data = memdup_user(data32, sizeof(*data32));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* only fifo_size (RO from userspace) is different, so just copy all */
+	if (copy_from_user(data, data32, sizeof(*data32))) {
+		err = -EFAULT;
+		goto error;
+	}
 
 	if (refine)
 		err = snd_pcm_hw_refine(substream, data);
-- 
2.6.0.rc2.230.g3dd15c0
