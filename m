From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 04/12] ASoC: msm8916-wcd-analog: constify snd_soc_dai_ops
 structure
Date: Thu, 13 Jul 2017 15:37:48 -0500
Message-ID: <d079cba8330b92b4b70bdcbc8c17f646c7391ef4.1499974826.git.garsilva@embeddedor.com>
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
 sound/soc/codecs/msm8916-wcd-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a788029..aec1e16 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -753,7 +753,7 @@ static void pm8916_wcd_analog_shutdown(struct snd_pcm_substream *substream,
 			    RST_CTL_DIG_SW_RST_N_MASK, 0);
 }
 
-static struct snd_soc_dai_ops pm8916_wcd_analog_dai_ops = {
+static const struct snd_soc_dai_ops pm8916_wcd_analog_dai_ops = {
 	.startup = pm8916_wcd_analog_startup,
 	.shutdown = pm8916_wcd_analog_shutdown,
 };
-- 
2.5.0
