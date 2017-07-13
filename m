From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 07/12] ASoC: codecs: msm8916-wcd-digital: constify
 snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 15:38:14 -0500
Message-ID: <f41455c6c14bb0a662e4fdcce03138974072d12c.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1499974826.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442..7e3794f 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -788,7 +788,7 @@ static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK, 0);
 }
 
-static struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
+static const struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
 	.startup = msm8916_wcd_digital_startup,
 	.shutdown = msm8916_wcd_digital_shutdown,
 	.hw_params = msm8916_wcd_digital_hw_params,
-- 
2.5.0
