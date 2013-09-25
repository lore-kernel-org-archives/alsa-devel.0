From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: tlv32aic32x4: Convert to direct
	regmap API usage
Date: Wed, 25 Sep 2013 11:45:54 +0100
Message-ID: <1380105954-16787-2-git-send-email-broonie@kernel.org>
References: <1380105954-16787-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 99714262607
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 12:47:13 +0200 (CEST)
In-Reply-To: <1380105954-16787-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This moves us towards being able to remove the duplicate register I/O
functionality in ASoC and saves some code.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 89 +++++++++++-----------------------------
 1 file changed, 23 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index cf70bf8..18cdcca 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -60,9 +60,8 @@ struct aic32x4_rate_divs {
 };
 
 struct aic32x4_priv {
+	struct regmap *regmap;
 	u32 sysclk;
-	u8 page_no;
-	void *control_data;
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
@@ -262,67 +261,25 @@ static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
 	{"Right ADC", NULL, "Right Input Mixer"},
 };
 
-static inline int aic32x4_change_page(struct snd_soc_codec *codec,
-					unsigned int new_page)
-{
-	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-	u8 data[2];
-	int ret;
-
-	data[0] = 0x00;
-	data[1] = new_page & 0xff;
-
-	ret = codec->hw_write(codec->control_data, data, 2);
-	if (ret == 2) {
-		aic32x4->page_no = new_page;
-		return 0;
-	} else {
-		return ret;
-	}
-}
-
-static int aic32x4_write(struct snd_soc_codec *codec, unsigned int reg,
-				unsigned int val)
-{
-	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-	unsigned int page = reg / 128;
-	unsigned int fixed_reg = reg % 128;
-	u8 data[2];
-	int ret;
-
-	/* A write to AIC32X4_PSEL is really a non-explicit page change */
-	if (reg == AIC32X4_PSEL)
-		return aic32x4_change_page(codec, val);
-
-	if (aic32x4->page_no != page) {
-		ret = aic32x4_change_page(codec, page);
-		if (ret != 0)
-			return ret;
-	}
+static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
+	{
+		.selector_reg = 0,
+		.selector_mask  = 0xff,
+		.window_start = 0,
+		.window_len = 128,
+		.range_min = AIC32X4_PAGE1,
+		.range_max = AIC32X4_PAGE1 + 127,
+	},
+};
 
-	data[0] = fixed_reg & 0xff;
-	data[1] = val & 0xff;
+static const struct regmap_config aic32x4_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
 
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-static unsigned int aic32x4_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
-	unsigned int page = reg / 128;
-	unsigned int fixed_reg = reg % 128;
-	int ret;
-
-	if (aic32x4->page_no != page) {
-		ret = aic32x4_change_page(codec, page);
-		if (ret != 0)
-			return ret;
-	}
-	return i2c_smbus_read_byte_data(codec->control_data, fixed_reg & 0xff);
-}
+	.max_register = AIC32X4_RMICPGAVOL,
+	.ranges = aic32x4_regmap_pages,
+	.num_ranges = ARRAY_SIZE(aic32x4_regmap_pages),
+};
 
 static inline int aic32x4_get_divs(int mclk, int rate)
 {
@@ -618,8 +575,7 @@ static int aic32x4_probe(struct snd_soc_codec *codec)
 	struct aic32x4_priv *aic32x4 = snd_soc_codec_get_drvdata(codec);
 	u32 tmp_reg;
 
-	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->control_data = aic32x4->control_data;
+	snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 
 	if (aic32x4->rstn_gpio >= 0) {
 		ndelay(10);
@@ -687,8 +643,6 @@ static int aic32x4_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
-	.read = aic32x4_read,
-	.write = aic32x4_write,
 	.probe = aic32x4_probe,
 	.remove = aic32x4_remove,
 	.suspend = aic32x4_suspend,
@@ -715,7 +669,10 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 	if (aic32x4 == NULL)
 		return -ENOMEM;
 
-	aic32x4->control_data = i2c;
+	aic32x4->regmap = devm_regmap_init_i2c(i2c, &aic32x4_regmap);
+	if (IS_ERR(aic32x4->regmap))
+		return PTR_ERR(aic32x4->regmap);
+
 	i2c_set_clientdata(i2c, aic32x4);
 
 	if (pdata) {
-- 
1.8.4.rc3
