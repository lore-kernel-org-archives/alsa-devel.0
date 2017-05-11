From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 22/26] ALSA: sh: Convert to copy_silence ops
Date: Thu, 11 May 2017 23:09:21 +0200
Message-ID: <20170511210925.18208-23-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFA8267016
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BAC3DAEE9
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

Replace the copy and the silence ops with the new merged ops.
A straightforward conversion with standard helper functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/sh_dac_audio.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 461b310c7872..a4014a4548d0 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -185,7 +185,8 @@ static int snd_sh_dac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 }
 
 static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream, int channel,
-	snd_pcm_uframes_t pos, void __user *src, snd_pcm_uframes_t count)
+			       snd_pcm_uframes_t pos, void __user *src,
+			       snd_pcm_uframes_t count, bool in_kernel)
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
@@ -199,34 +200,12 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream, int channel,
 	if (!count)
 		return 0;
 
-	memcpy_toio(chip->data_buffer + b_pos, src, b_count);
-	chip->buffer_end = chip->data_buffer + b_pos + b_count;
-
-	if (chip->empty) {
-		chip->empty = 0;
-		dac_audio_start_timer(chip);
-	}
-
-	return 0;
-}
-
-static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
-				  int channel, snd_pcm_uframes_t pos,
-				  snd_pcm_uframes_t count)
-{
-	/* channel is not used (interleaved data) */
-	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	ssize_t b_count = frames_to_bytes(runtime , count);
-	ssize_t b_pos = frames_to_bytes(runtime , pos);
-
-	if (count < 0)
-		return -EINVAL;
-
-	if (!count)
-		return 0;
-
-	memset_io(chip->data_buffer + b_pos, 0, b_count);
+	if (!src)
+		memset_io(chip->data_buffer + b_pos, 0, b_count);
+	else if (in_kernel)
+		memcpy_toio(chip->data_buffer + b_pos, (void *)src, b_count);
+	else if (copy_from_user_toio(chip->data_buffer + b_pos, src, b_count))
+		return -EFAULT;
 	chip->buffer_end = chip->data_buffer + b_pos + b_count;
 
 	if (chip->empty) {
@@ -256,8 +235,7 @@ static struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.prepare	= snd_sh_dac_pcm_prepare,
 	.trigger	= snd_sh_dac_pcm_trigger,
 	.pointer	= snd_sh_dac_pcm_pointer,
-	.copy		= snd_sh_dac_pcm_copy,
-	.silence	= snd_sh_dac_pcm_silence,
+	.copy_silence	= snd_sh_dac_pcm_copy,
 	.mmap		= snd_pcm_lib_mmap_iomem,
 };
 
-- 
2.12.2
