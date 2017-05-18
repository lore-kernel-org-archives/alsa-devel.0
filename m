From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: cs35l35: Add Boost Inductor
	Calculation
Date: Thu, 18 May 2017 16:32:36 +0100
Message-ID: <1495121559-1063-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E70F2671DF
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 17:31:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, brian.austin@cirrus.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Brian Austin <brian.austin@cirrus.com>

Add the Boost Inductor parameters based off the size of the inductor
on the HW setup

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/cs35l35.h    |  2 ++
 sound/soc/codecs/cs35l35.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l35.h |  6 ++++
 3 files changed, 90 insertions(+)

diff --git a/include/sound/cs35l35.h b/include/sound/cs35l35.h
index 29da899..d69cd78 100644
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
index f8aef58..c6eabb8 100644
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
index 5a6e43a..621bfef 100644
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
2.1.4
