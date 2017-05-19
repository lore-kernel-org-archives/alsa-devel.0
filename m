From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs35l35: Add Boost Inductor Calculation" to the asoc tree
Date: Fri, 19 May 2017 18:03:56 +0100
Message-ID: <E1dBlJk-0003eq-RX@debutante>
References: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495121559-1063-1-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add Boost Inductor Calculation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b7c752d68aee9c066cb0bd2f24ee73aed64575e8 Mon Sep 17 00:00:00 2001
From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Date: Thu, 18 May 2017 16:32:36 +0100
Subject: [PATCH] ASoC: cs35l35: Add Boost Inductor Calculation

Add the Boost Inductor parameters based off the size of the inductor
on the HW setup

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/cs35l35.h    |  2 ++
 sound/soc/codecs/cs35l35.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l35.h |  6 ++++
 3 files changed, 90 insertions(+)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index 29da899e17e4..d69cd7847afd 100644
--- a/include/sound/cs35l35.h
+++ b/include/sound/cs35l35.h
@@ -99,6 +99,8 @@ struct cs35l35_platform_data {
 	bool shared_bst;
 	/* Specifies this amp is using an external boost supply */
 	bool ext_bst;
+	/* Inductor Value */
+	int boost_ind;
 	/* ClassH Algorithm */
 	struct classh_cfg classh_algo;
 	/* Monitor Config */
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index f8aef5869b03..c6eabb8610f0 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -756,6 +756,76 @@ static int cs35l35_codec_set_sysclk(struct snd_soc_codec *codec,
 	return ret;
 }
 
+static int cs35l35_boost_inductor(struct cs35l35_private *cs35l35,
+				  int inductor)
+{
+	struct regmap *regmap = cs35l35->regmap;
+	unsigned int bst_ipk = 0;
+
+	/*
+	 * Digital Boost Converter Configuration for feedback,
+	 * ramping, switching frequency, and estimation block seeding.
+	 */
+
+	regmap_update_bits(regmap, CS35L35_BST_CONV_SW_FREQ,
+			   CS35L35_BST_CONV_SWFREQ_MASK, 0x00);
+
+	regmap_read(regmap, CS35L35_BST_PEAK_I, &bst_ipk);
+	bst_ipk &= CS35L35_BST_IPK_MASK;
+
+	switch (inductor) {
+	case 1000: /* 1 uH */
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_1, 0x24);
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_2, 0x24);
+		regmap_update_bits(regmap, CS35L35_BST_CONV_SW_FREQ,
+				   CS35L35_BST_CONV_LBST_MASK, 0x00);
+
+		if (bst_ipk < 0x04)
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x1B);
+		else
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x4E);
+		break;
+	case 1200: /* 1.2 uH */
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_1, 0x20);
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_2, 0x20);
+		regmap_update_bits(regmap, CS35L35_BST_CONV_SW_FREQ,
+				   CS35L35_BST_CONV_LBST_MASK, 0x01);
+
+		if (bst_ipk < 0x04)
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x1B);
+		else
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x47);
+		break;
+	case 1500: /* 1.5uH */
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_1, 0x20);
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_2, 0x20);
+		regmap_update_bits(regmap, CS35L35_BST_CONV_SW_FREQ,
+				   CS35L35_BST_CONV_LBST_MASK, 0x02);
+
+		if (bst_ipk < 0x04)
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x1B);
+		else
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x3C);
+		break;
+	case 2200: /* 2.2uH */
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_1, 0x19);
+		regmap_write(regmap, CS35L35_BST_CONV_COEF_2, 0x25);
+		regmap_update_bits(regmap, CS35L35_BST_CONV_SW_FREQ,
+				   CS35L35_BST_CONV_LBST_MASK, 0x03);
+
+		if (bst_ipk < 0x04)
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x1B);
+		else
+			regmap_write(regmap, CS35L35_BST_CONV_SLOPE_COMP, 0x23);
+		break;
+	default:
+		dev_err(cs35l35->dev, "Invalid Inductor Value %d uH\n",
+			inductor);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 {
 	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
@@ -775,6 +845,10 @@ static int cs35l35_codec_probe(struct snd_soc_codec *codec)
 				cs35l35->pdata.bst_ipk <<
 				CS35L35_BST_IPK_SHIFT);
 
+	ret = cs35l35_boost_inductor(cs35l35, cs35l35->pdata.boost_ind);
+	if (ret)
+		return ret;
+
 	if (cs35l35->pdata.gain_zc)
 		regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
 				CS35L35_AMP_GAIN_ZC_MASK,
@@ -1198,6 +1272,14 @@ static int cs35l35_handle_of_data(struct i2c_client *i2c_client,
 		pdata->bst_ipk = (val32 - 1680) / 110;
 	}
 
+	ret = of_property_read_u32(np, "cirrus,boost-ind-nanohenry", &val32);
+	if (ret >= 0) {
+		pdata->boost_ind = val32;
+	} else {
+		dev_err(&i2c_client->dev, "Inductor not specified.\n");
+		return -EINVAL;
+	}
+
 	if (of_property_read_u32(np, "cirrus,sp-drv-strength", &val32) >= 0)
 		pdata->sp_drv_str = val32;
 	if (of_property_read_u32(np, "cirrus,sp-drv-unused", &val32) >= 0)
diff --git a/sound/soc/codecs/cs35l35.h b/sound/soc/codecs/cs35l35.h
index 5a6e43a87c4d..621bfef70d03 100644
--- a/sound/soc/codecs/cs35l35.h
+++ b/sound/soc/codecs/cs35l35.h
@@ -200,6 +200,12 @@
 #define CS35L35_SP_I2S_DRV_MASK		0x03
 #define CS35L35_SP_I2S_DRV_SHIFT	0
 
+/* Boost Converter Config */
+#define CS35L35_BST_CONV_COEFF_MASK	0xFF
+#define CS35L35_BST_CONV_SLOPE_MASK	0xFF
+#define CS35L35_BST_CONV_LBST_MASK	0x03
+#define CS35L35_BST_CONV_SWFREQ_MASK	0xF0
+
 /* Class H Algorithm Control */
 #define CS35L35_CH_STEREO_MASK		0x40
 #define CS35L35_CH_STEREO_SHIFT		6
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
