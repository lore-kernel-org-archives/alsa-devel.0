From: "Ambrose, Martin" <martin@ti.com>
Subject: [PATCH 1/1] Add AIC3106 support.
Date: Wed, 13 May 2009 10:28:23 -0500
Message-ID: <A24693684029E5489D1D202277BE89443E39393F@dlee02.ent.ti.com>
References: <200905091720.n49HKTSx020571@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 28EF41038BB
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 17:28:31 +0200 (CEST)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4DFSPj1026328
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:28:30 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4DFSPAR018732
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:28:25 -0500 (CDT)
In-Reply-To: <200905091720.n49HKTSx020571@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Steve Chen <schen@mvista.com>
Signed-off-by: Martin Ambrose <martin@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c |  185 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic3x.h |   11 ++-
 2 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index ab099f4..5720cad 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -57,13 +57,17 @@ struct aic3x_priv {
 	int master;
 };
 
+static u8 pg0_end = AIC3X_GEN_PG0_END;
+static u8 pg1_end = AIC3X_GEN_PG1_END;
+static enum aic3x_codec_variant codec_variant;
+
 /*
  * AIC3X register cache
  * We can't read the AIC3X register space when we are
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
+static const u8 aic3x_reg[] = {
 	0x00, 0x00, 0x00, 0x10,	/* 0 */
 	0x04, 0x00, 0x00, 0x00,	/* 4 */
 	0x00, 0x00, 0x00, 0x01,	/* 8 */
@@ -90,6 +94,35 @@ static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 	0x00, 0x00, 0x00, 0x00,	/* 92 */
 	0x00, 0x00, 0x00, 0x00,	/* 96 */
 	0x00, 0x00, 0x02,	/* 100 */
+
+	0x00, 0x00, 0x00, 0x00, /* 103-127 unused */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00,
+
+	0x00, 0x6b, 0xe3, 0x96, /* 0 */
+	0x66, 0x67, 0x5d, 0x6b, /* 4 */
+	0xe3, 0x96, 0x66, 0x67, /* 8 */
+	0x5d, 0x7d, 0x83, 0x84, /* 12 */
+	0xee, 0x7d, 0x83, 0x84, /* 16 */
+	0xee, 0x39, 0x55, 0xf3, /* 20 */
+	0x2d, 0x53, 0x7e, 0x6b, /* 24 */
+	0xe3, 0x96, 0x66, 0x67, /* 28 */
+	0x5d, 0x6b, 0xe3, 0x96, /* 32 */
+	0x66, 0x67, 0x5d, 0x7d, /* 36 */
+	0x83, 0x84, 0xee, 0x7d, /* 40 */
+	0x83, 0x84, 0xee, 0x39, /* 44 */
+	0x55, 0xf3, 0x2d, 0x53, /* 48 */
+	0x7e, 0x7f, 0xff, 0x00, /* 52 */
+	0x00, 0x00, 0x00, 0x00, /* 56 */
+	0x00, 0x00, 0x00, 0x00, /* 60 */
+	0x00, 0x39, 0x55, 0xf3, /* 64 */
+	0x2d, 0x53, 0x7e, 0x39, /* 68 */
+	0x55, 0xf3, 0x2d, 0x53, /* 72 */
+	0x7e,			/* 76 */
 };
 
 /*
@@ -99,7 +132,8 @@ static inline unsigned int aic3x_read_reg_cache(struct snd_soc_codec *codec,
 						unsigned int reg)
 {
 	u8 *cache = codec->reg_cache;
-	if (reg >= AIC3X_CACHEREGNUM)
+	if ((reg >= pg1_end) ||
+		((reg >= pg0_end) && (reg < AIC3X_GEN_PG1_BEG)))
 		return -1;
 	return cache[reg];
 }
@@ -111,7 +145,8 @@ static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
 					 u8 reg, u8 value)
 {
 	u8 *cache = codec->reg_cache;
-	if (reg >= AIC3X_CACHEREGNUM)
+	if ((reg >= pg1_end) ||
+		((reg >= pg0_end) && (reg < AIC3X_GEN_PG1_BEG)))
 		return;
 	cache[reg] = value;
 }
@@ -119,8 +154,8 @@ static inline void aic3x_write_reg_cache(struct snd_soc_codec *codec,
 /*
  * write to the aic3x register space
  */
-static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
-		       unsigned int value)
+static int _aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
+			unsigned int value)
 {
 	u8 data[2];
 
@@ -132,12 +167,41 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0xff;
 
 	aic3x_write_reg_cache(codec, data[0], data[1]);
+
+	/* adjust for page 1 before updating hardware if necessary */
+	if (data[0] >= AIC3X_GEN_PG1_BEG)
+		data[0] -= AIC3X_GEN_PG1_BEG;
+
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
 		return -EIO;
 }
 
+static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+	u8 cur_pg;
+	u8 reg_pg;
+	int ret = 0;
+
+	cur_pg = aic3x_read_reg_cache(codec, 0);
+	if (reg < pg0_end)
+		reg_pg = 0;
+	else if ((reg >= AIC3X_GEN_PG1_BEG) && (reg < pg1_end))
+		reg_pg = 1;
+	else
+		return -EIO;
+
+	if (cur_pg != reg_pg)
+		ret = _aic3x_write(codec, 0, reg_pg);
+
+	if (ret == 0)
+		ret = _aic3x_write(codec, reg, value);
+
+	return ret;
+}
+
 /*
  * read from the aic3x register space
  */
@@ -218,6 +282,65 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static int tlv320aic3x_dual_reg_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xffff;
+	return 0;
+}
+
+static int tlv320aic3x_dual_reg_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int reg_msb = kcontrol->private_value & 0xff;
+	int reg_lsb = (kcontrol->private_value >> 8) & 0xff;
+	int val = aic3x_read_reg_cache(codec, reg_msb) << 8;
+
+	val |= aic3x_read_reg_cache(codec, reg_lsb);
+
+	/* convert 2's complement to unsigned int */
+	val ^= 0x8000;
+
+	ucontrol->value.integer.value[0] = val;
+
+	return 0;
+}
+
+static int tlv320aic3x_dual_reg_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	int err;
+	int reg_msb = kcontrol->private_value & 0xff;
+	int reg_lsb = (kcontrol->private_value >> 8) & 0xff;
+	int val_msb, val_lsb;
+
+	val_msb = (ucontrol->value.integer.value[0] >> 8) & 0xff;
+	val_lsb = ucontrol->value.integer.value[0] & 0xff;
+
+	/* convert unsigned int to 2's complement */
+	val_msb ^= 0x80;
+
+	err = snd_soc_update_bits(codec, reg_msb, 0xff, val_msb);
+	if (err < 0)
+		return err;
+	err = snd_soc_update_bits(codec, reg_lsb, 0xff, val_lsb);
+	return err;
+}
+
+#define TLV320AIC3X_DUAL_R(xname, page, reg_msb, reg_lsb) \
+{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = tlv320aic3x_dual_reg_info, \
+	.get = tlv320aic3x_dual_reg_get, .put = tlv320aic3x_dual_reg_put, \
+	.private_value = ((reg_msb) + page) | (((reg_lsb) + page) << 8) }
+
+#define TLV320AIC3X_PG1_DUAL_R(xname, reg_msb, reg_lsb) \
+	TLV320AIC3X_DUAL_R(xname, AIC3X_GEN_PG1_BEG, reg_msb, reg_lsb)
+
 static const char *aic3x_left_dac_mux[] = { "DAC_L1", "DAC_L3", "DAC_L2" };
 static const char *aic3x_right_dac_mux[] = { "DAC_R1", "DAC_R3", "DAC_R2" };
 static const char *aic3x_left_hpcom_mux[] =
@@ -344,6 +467,36 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
 	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N0", 1, 2),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N1", 3, 4),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N2", 5, 6),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N3", 7, 8),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N4", 9, 10),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient N5", 11, 12),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient D1", 13, 14),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient D2", 15, 16),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient D4", 17, 18),
+	TLV320AIC3X_PG1_DUAL_R("Left Effects Coefficient D5", 19, 20),
+	TLV320AIC3X_PG1_DUAL_R("Left De-Emphasis Coefficient N0", 21, 22),
+	TLV320AIC3X_PG1_DUAL_R("Left De-Emphasis Coefficient N1", 23, 24),
+	TLV320AIC3X_PG1_DUAL_R("Left De-Emphasis Coefficient D1", 25, 26),
+
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N0", 27, 28),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N1", 29, 30),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N2", 31, 32),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N3", 33, 34),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N4", 35, 36),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient N5", 37, 38),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient D1", 39, 40),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient D2", 41, 42),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient D4", 43, 44),
+	TLV320AIC3X_PG1_DUAL_R("Right Effects Coefficient D5", 45, 46),
+	TLV320AIC3X_PG1_DUAL_R("Right De-Emphasis Coefficient N0", 47, 48),
+	TLV320AIC3X_PG1_DUAL_R("Right De-Emphasis Coefficient N1", 49, 50),
+	TLV320AIC3X_PG1_DUAL_R("Right De-Emphasis Coefficient D1", 51, 52),
+
+	TLV320AIC3X_PG1_DUAL_R("3-D Attenuation Coefficient", 53, 54),
 };
 
 /* Left DAC Mux */
@@ -454,6 +607,18 @@ static const struct snd_kcontrol_new aic3x_right_line2_bp_mixer_controls[] = {
 	SOC_DAPM_SINGLE("HPRCOM Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
 };
 
+static const struct snd_kcontrol_new aic3106_snd_controls[] = {
+	TLV320AIC3X_PG1_DUAL_R("Left Capture High Pass Coefficient N0", 65, 66),
+	TLV320AIC3X_PG1_DUAL_R("Left Capture High Pass Coefficient N1", 67, 68),
+	TLV320AIC3X_PG1_DUAL_R("Left Capture High Pass Coefficient D1", 69, 70),
+	TLV320AIC3X_PG1_DUAL_R("Right Capture High Pass Coefficient N0",
+			     71, 72),
+	TLV320AIC3X_PG1_DUAL_R("Right Capture High Pass Coefficient N1",
+			     73, 74),
+	TLV320AIC3X_PG1_DUAL_R("Right Capture High Pass Coefficient D1",
+			     75, 76),
+};
+
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	/* Left DAC to Left Outputs */
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0),
@@ -1165,6 +1330,10 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	/* setup register cache sizes */
+	if (codec_variant == AIC3106_CODEC)
+		pg1_end = AIC3106_PG1_END;
+
 	aic3x_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
 	aic3x_write(codec, AIC3X_RESET, SOFT_RESET);
 
@@ -1247,6 +1416,11 @@ static int aic3x_init(struct snd_soc_device *socdev)
 
 	snd_soc_add_controls(codec, aic3x_snd_controls,
 				ARRAY_SIZE(aic3x_snd_controls));
+
+	if (codec_variant == AIC3106_CODEC)
+		snd_soc_add_controls(codec, aic3106_snd_controls,
+				ARRAY_SIZE(aic3106_snd_controls));
+
 	aic3x_add_widgets(codec);
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
@@ -1374,6 +1548,7 @@ static int aic3x_probe(struct platform_device *pdev)
 	printk(KERN_INFO "AIC3X Audio Codec %s\n", AIC3X_VERSION);
 
 	setup = socdev->codec_data;
+	codec_variant = setup->variant;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index ac827e5..ee40e9c 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -13,7 +13,10 @@
 #define _AIC3X_H
 
 /* AIC3X register space */
-#define AIC3X_CACHEREGNUM		103
+#define AIC3X_GEN_PG0_END		103
+#define AIC3X_GEN_PG1_BEG		128
+#define AIC3X_GEN_PG1_END		183
+#define AIC3106_PG1_END 		205
 
 /* Page select register */
 #define AIC3X_PAGE_SELECT		0
@@ -199,6 +202,11 @@
 /* Default input volume */
 #define DEFAULT_GAIN    0x20
 
+enum aic3x_codec_variant {
+	AIC3X_GENERIC_CODEC,
+	AIC3106_CODEC,
+};
+
 /* GPIO API */
 enum {
 	AIC3X_GPIO1_FUNC_DISABLED		= 0,
@@ -284,6 +292,7 @@ int aic3x_button_pressed(struct snd_soc_codec *codec);
 struct aic3x_setup_data {
 	int i2c_bus;
 	unsigned short i2c_address;
+	enum aic3x_codec_variant variant;
 	unsigned int gpio_func[2];
 };
 
-- 
1.6.0.6
