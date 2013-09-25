From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: sn95031: Convert to regmap
Date: Wed, 25 Sep 2013 19:23:43 +0100
Message-ID: <1380133423-18706-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AF057265562
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 20:23:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This moves us towards being able to remove the duplicated register I/O
functionality in ASoC.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/sn95031.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index dba26e63..13045f2 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -164,30 +164,28 @@ static unsigned int sn95031_get_mic_bias(struct snd_soc_codec *codec)
 }
 /*end - adc helper functions */
 
-static inline unsigned int sn95031_read(struct snd_soc_codec *codec,
-			unsigned int reg)
+static int sn95031_read(void *ctx, unsigned int reg, unsigned int *val)
 {
 	u8 value = 0;
 	int ret;
 
 	ret = intel_scu_ipc_ioread8(reg, &value);
-	if (ret)
-		pr_err("read of %x failed, err %d\n", reg, ret);
-	return value;
+	if (ret == 0)
+		*val = value;
 
+	return ret;
 }
 
-static inline int sn95031_write(struct snd_soc_codec *codec,
-			unsigned int reg, unsigned int value)
+static int sn95031_write(void *ctx, unsigned int reg, unsigned int value)
 {
-	int ret;
-
-	ret = intel_scu_ipc_iowrite8(reg, value);
-	if (ret)
-		pr_err("write of %x failed, err %d\n", reg, ret);
-	return ret;
+	return intel_scu_ipc_iowrite8(reg, value);
 }
 
+static const struct regmap_config sn95031_regmap = {
+	.reg_read = sn95031_read,
+	.reg_write = sn95031_write,
+};
+
 static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 		enum snd_soc_bias_level level)
 {
@@ -827,6 +825,8 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
 	pr_debug("codec_probe called\n");
 
+	snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+
 	/* PCM interface config
 	 * This sets the pcm rx slot conguration to max 6 slots
 	 * for max 4 dais (2 stereo and 2 mono)
@@ -886,8 +886,6 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver sn95031_codec = {
 	.probe		= sn95031_codec_probe,
 	.remove		= sn95031_codec_remove,
-	.read		= sn95031_read,
-	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
 	.idle_bias_off	= true,
 	.dapm_widgets	= sn95031_dapm_widgets,
@@ -898,7 +896,14 @@ static struct snd_soc_codec_driver sn95031_codec = {
 
 static int sn95031_device_probe(struct platform_device *pdev)
 {
+	struct regmap *regmap;
+
 	pr_debug("codec device probe called for %s\n", dev_name(&pdev->dev));
+
+	regmap = devm_regmap_init(&pdev->dev, NULL, NULL, &sn95031_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	return snd_soc_register_codec(&pdev->dev, &sn95031_codec,
 			sn95031_dais, ARRAY_SIZE(sn95031_dais));
 }
-- 
1.8.4.rc3
