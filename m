From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: Add custom SOC_SINGLE_TLV for
	tlv320aic23 codec
Date: Wed,  8 Oct 2008 10:37:53 +0100
Message-ID: <1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40A13244C2
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <20081008093611.GA9425@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

Replaces SOC_ENUM with custom SOC_SINGLE_TLV for Sidetone volume

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic23.c |   53 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c2d35e9..bb7cfb8 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -113,7 +113,6 @@ static int tlv320aic23_write(struct snd_soc_codec *codec, unsigned int reg,
 
 static const char *rec_src_text[] = { "Line", "Mic" };
 static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
-static const char *sidetone_text[] = {"-6db", "-9db", "-12db", "-18db", "0db"};
 
 static const struct soc_enum rec_src_enum =
 	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
@@ -125,11 +124,56 @@ static const struct soc_enum tlv320aic23_rec_src =
 	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
 static const struct soc_enum tlv320aic23_deemph =
 	SOC_ENUM_SINGLE(TLV320AIC23_DIGT, 1, 4, deemph_text);
-static const struct soc_enum tlv320aic23_sidetone =
-	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 6, 5, sidetone_text);
 
 static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -12100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(input_gain_tlv, -1725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(sidetone_vol_tlv, -1800, 300, 0);
+
+static int snd_soc_tlv320aic23_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 val, reg;
+
+	val = (ucontrol->value.integer.value[0] & 0x07);
+
+	/* linear conversion to userspace
+	* 000	=	-6db
+	* 001	=	-9db
+	* 010	=	-12db
+	* 011	=	-18db (Min)
+	* 100	=	0db (Max)
+	*/
+	val = (val >= 4) ? 4  : (3 - val);
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANLG) & (~0x1C0);
+	tlv320aic23_write(codec, TLV320AIC23_ANLG, reg | (val << 6));
+
+	return 0;
+}
+
+static int snd_soc_tlv320aic23_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 val;
+
+	val = tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANLG) & (0x1C0);
+	val = val >> 6;
+	val = (val >= 4) ? 4  : (3 -  val);
+	ucontrol->value.integer.value[0] = val;
+	return 0;
+
+}
+
+#define SOC_TLV320AIC23_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_tlv320aic23_get_volsw,\
+	.put = snd_soc_tlv320aic23_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
 
 static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", TLV320AIC23_LCHNVOL,
@@ -141,7 +185,8 @@ static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
 			 TLV320AIC23_RINVOL, 0, 31, 0, input_gain_tlv),
 	SOC_SINGLE("Mic Input Switch", TLV320AIC23_ANLG, 1, 1, 1),
 	SOC_SINGLE("Mic Booster Switch", TLV320AIC23_ANLG, 0, 1, 0),
-	SOC_ENUM("Sidetone Gain", tlv320aic23_sidetone),
+	SOC_TLV320AIC23_SINGLE_TLV("Sidetone Volume", TLV320AIC23_ANLG,
+				  6, 4, 0, sidetone_vol_tlv),
 	SOC_ENUM("Playback De-emphasis", tlv320aic23_deemph),
 };
 
-- 
1.5.6.5
