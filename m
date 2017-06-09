From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: pcm: use helper functions to refer
	parameters as constants
Date: Fri,  9 Jun 2017 09:34:38 +0900
Message-ID: <20170609003440.4178-2-o-takashi@sakamocchi.jp>
References: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E6E3B2674B3
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 02:34:48 +0200 (CEST)
In-Reply-To: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To fixup some parameters, ALSA PCM core refers the other parameters as
constants. There're some macros for this purpose.

This commit replaces codes with them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 422ee4629698..87a507f12f2f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -444,8 +444,8 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_hardware *hw;
-	struct snd_interval *i = NULL;
-	struct snd_mask *m = NULL;
+	const struct snd_interval *i;
+	const struct snd_mask *m;
 	int err;
 
 	params->info = 0;
@@ -470,13 +470,13 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		return err;
 
 	if (!params->msbits) {
-		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 		if (snd_interval_single(i))
 			params->msbits = snd_interval_value(i);
 	}
 
 	if (!params->rate_den) {
-		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
 		if (snd_interval_single(i)) {
 			params->rate_num = snd_interval_value(i);
 			params->rate_den = 1;
@@ -492,8 +492,8 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 					  SNDRV_PCM_INFO_MMAP_VALID);
 	}
 	if (!params->fifo_size) {
-		m = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+		m = hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
+		i = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 		if (snd_mask_single(m) && snd_interval_single(i)) {
 			err = substream->ops->ioctl(substream,
 					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
-- 
2.11.0
