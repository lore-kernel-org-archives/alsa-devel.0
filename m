From: Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 5/9] ASoC: cygnus: Remove support for 8 bit audio and for mono
Date: Mon, 14 Aug 2017 15:06:53 -0700
Message-ID: <1502748417-26417-6-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

These modes of operation were not working properly. There is little to
be gained by enabling these modes and the changes required to
potentially fix these modes would complicate the driver.

Signed-off-by: Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 sound/soc/bcm/cygnus-ssp.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 4c476ce..5b6e345 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -547,23 +547,10 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		value = readl(aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 		value &= ~BIT(BF_SRC_CFGX_BUFFER_PAIR_ENABLE);
-		/* Configure channels as mono or stereo/TDM */
-		if (params_channels(params) == 1)
-			value |= BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
-		else
-			value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
+		value &= ~BIT(BF_SRC_CFGX_SAMPLE_CH_MODE);
 		writel(value, aio->cygaud->audio + aio->regs.bf_sourcech_cfg);
 
 		switch (params_format(params)) {
-		case SNDRV_PCM_FORMAT_S8:
-			if (aio->port_type == PORT_SPDIF) {
-				dev_err(aio->cygaud->dev,
-				"SPDIF does not support 8bit format\n");
-				return -EINVAL;
-			}
-			bitres = 8;
-			break;
-
 		case SNDRV_PCM_FORMAT_S16_LE:
 			bitres = 16;
 			break;
@@ -1008,19 +995,18 @@ static int cygnus_ssp_set_pll(struct snd_soc_dai *cpu_dai, int pll_id,
 #define INIT_CPU_DAI(num) { \
 	.name = "cygnus-ssp" #num, \
 	.playback = { \
-		.channels_min = 1, \
+		.channels_min = 2, \
 		.channels_max = 16, \
 		.rates = SNDRV_PCM_RATE_KNOT, \
-		.formats = SNDRV_PCM_FMTBIT_S8 | \
-				SNDRV_PCM_FMTBIT_S16_LE | \
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | \
 				SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.capture = { \
 		.channels_min = 2, \
 		.channels_max = 16, \
 		.rates = SNDRV_PCM_RATE_KNOT, \
-		.formats =  SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S32_LE, \
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.ops = &cygnus_ssp_dai_ops, \
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
