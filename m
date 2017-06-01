From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 13/27] ALSA: sh: Convert to the new PCM ops
Date: Thu,  1 Jun 2017 22:58:36 +0200
Message-ID: <20170601205850.24993-14-tiwai@suse.de>
References: <20170601205850.24993-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170601205850.24993-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Replace the copy and the silence ops with the new PCM ops.
Fixed also the user-space buffer copy with the proper
copy_from_user*() variant.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/sh/sh_dac_audio.c | 54 +++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 461b310c7872..c1e00ed715ee 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -184,23 +184,36 @@ static int snd_sh_dac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
-static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream, int channel,
-	snd_pcm_uframes_t pos, void __user *src, snd_pcm_uframes_t count)
+static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
+			       int channel, unsigned long pos,
+			       void __user *src, unsigned long count)
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	ssize_t b_count = frames_to_bytes(runtime , count);
-	ssize_t b_pos = frames_to_bytes(runtime , pos);
 
-	if (count < 0)
-		return -EINVAL;
+	if (copy_from_user_toio(chip->data_buffer + pos, src, count))
+		return -EFAULT;
+	chip->buffer_end = chip->data_buffer + pos + count;
 
-	if (!count)
-		return 0;
+	if (chip->empty) {
+		chip->empty = 0;
+		dac_audio_start_timer(chip);
+	}
+
+	return 0;
+}
 
-	memcpy_toio(chip->data_buffer + b_pos, src, b_count);
-	chip->buffer_end = chip->data_buffer + b_pos + b_count;
+static int snd_sh_dac_pcm_copy_kernel(struct snd_pcm_substream *substream,
+				      int channel, unsigned long pos,
+				      void *src, unsigned long count)
+{
+	/* channel is not used (interleaved data) */
+	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	memcpy_toio(chip->data_buffer + pos, src, count);
+	chip->buffer_end = chip->data_buffer + pos + count;
 
 	if (chip->empty) {
 		chip->empty = 0;
@@ -211,23 +224,15 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream, int channel,
 }
 
 static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
-				  int channel, snd_pcm_uframes_t pos,
-				  snd_pcm_uframes_t count)
+				  int channel, unsigned long pos,
+				  unsigned long count)
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	ssize_t b_count = frames_to_bytes(runtime , count);
-	ssize_t b_pos = frames_to_bytes(runtime , pos);
-
-	if (count < 0)
-		return -EINVAL;
-
-	if (!count)
-		return 0;
 
-	memset_io(chip->data_buffer + b_pos, 0, b_count);
-	chip->buffer_end = chip->data_buffer + b_pos + b_count;
+	memset_io(chip->data_buffer + pos, 0, count);
+	chip->buffer_end = chip->data_buffer + pos + count;
 
 	if (chip->empty) {
 		chip->empty = 0;
@@ -256,8 +261,9 @@ static struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.prepare	= snd_sh_dac_pcm_prepare,
 	.trigger	= snd_sh_dac_pcm_trigger,
 	.pointer	= snd_sh_dac_pcm_pointer,
-	.copy		= snd_sh_dac_pcm_copy,
-	.silence	= snd_sh_dac_pcm_silence,
+	.copy_user	= snd_sh_dac_pcm_copy,
+	.copy_kernel	= snd_sh_dac_pcm_copy_kernel,
+	.fill_silence	= snd_sh_dac_pcm_silence,
 	.mmap		= snd_pcm_lib_mmap_iomem,
 };
 
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
