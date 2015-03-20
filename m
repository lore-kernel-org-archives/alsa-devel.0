From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] ASoC: max98925: Constify regmap config and other codec data
Date: Fri, 20 Mar 2015 12:35:45 +0100
Message-ID: <1426851345-24930-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Constify local structures (snd_soc_dai_ops, snd_soc_codec_driver,
regmap_config) and array (reg_defaults) which are not modified by the
driver and passed to core as pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/soc/codecs/max98925.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 1f8e80315749..0796dfaeb139 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -34,7 +34,7 @@ static const char *const hpf_text[] = {
 	"Disable", "DC Block", "100Hz",	"200Hz", "400Hz", "800Hz",
 };
 
-static struct reg_default max98925_reg[] = {
+static const struct reg_default max98925_reg[] = {
 	{ 0x0B, 0x00 }, /* IRQ Enable0 */
 	{ 0x0C, 0x00 }, /* IRQ Enable1 */
 	{ 0x0D, 0x00 }, /* IRQ Enable2 */
@@ -491,7 +491,7 @@ static int max98925_dai_set_sysclk(struct snd_soc_dai *dai,
 #define MAX98925_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops max98925_dai_ops = {
+static const struct snd_soc_dai_ops max98925_dai_ops = {
 	.set_sysclk = max98925_dai_set_sysclk,
 	.set_fmt = max98925_dai_set_fmt,
 	.hw_params = max98925_dai_hw_params,
@@ -541,7 +541,7 @@ static int max98925_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_max98925 = {
+static const struct snd_soc_codec_driver soc_codec_dev_max98925 = {
 	.probe            = max98925_probe,
 	.controls = max98925_snd_controls,
 	.num_controls = ARRAY_SIZE(max98925_snd_controls),
@@ -551,7 +551,7 @@ static struct snd_soc_codec_driver soc_codec_dev_max98925 = {
 	.num_dapm_widgets = ARRAY_SIZE(max98925_dapm_widgets),
 };
 
-static struct regmap_config max98925_regmap = {
+static const struct regmap_config max98925_regmap = {
 	.reg_bits         = 8,
 	.val_bits         = 8,
 	.max_register     = MAX98925_REV_VERSION,
-- 
1.9.1
