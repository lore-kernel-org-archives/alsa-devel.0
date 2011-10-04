From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 03/12] ASoC: Consolidate use of controls with
	custom get/put function
Date: Tue,  4 Oct 2011 14:39:40 +0300
Message-ID: <1317728389-22062-4-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 9FA9724609
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:04 +0200 (CEST)
Received: by mail-bw0-f48.google.com with SMTP id zu5so730046bkb.21
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:03 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Use the macros for controls require custom get/put function.
This is to make sure that the soc_mixer_control is used
consistently among the drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arun KS <arunks@mistralsolutions.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
---
 sound/soc/codecs/tlv320aic23.c |   14 ++---------
 sound/soc/codecs/twl4030.c     |   48 ++++++++++------------------------------
 sound/soc/codecs/twl6040.c     |   37 +++++-------------------------
 sound/soc/codecs/wm8350.c      |   39 ++++++++++++--------------------
 sound/soc/codecs/wm8580.c      |   36 ++++++++++--------------------
 sound/soc/codecs/wm_hubs.c     |   18 ++++----------
 6 files changed, 53 insertions(+), 139 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 33bb52f..c3a4bb2 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -159,15 +159,6 @@ static int snd_soc_tlv320aic23_get_volsw(struct snd_kcontrol *kcontrol,
 
 }
 
-#define SOC_TLV320AIC23_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, .get = snd_soc_tlv320aic23_get_volsw,\
-	.put = snd_soc_tlv320aic23_put_volsw, \
-	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-
 static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Digital Playback Volume", TLV320AIC23_LCHNVOL,
 			 TLV320AIC23_RCHNVOL, 0, 127, 0, out_gain_tlv),
@@ -178,8 +169,9 @@ static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
 			 TLV320AIC23_RINVOL, 0, 31, 0, input_gain_tlv),
 	SOC_SINGLE("Mic Input Switch", TLV320AIC23_ANLG, 1, 1, 1),
 	SOC_SINGLE("Mic Booster Switch", TLV320AIC23_ANLG, 0, 1, 0),
-	SOC_TLV320AIC23_SINGLE_TLV("Sidetone Volume", TLV320AIC23_ANLG,
-				  6, 4, 0, sidetone_vol_tlv),
+	SOC_SINGLE_EXT_TLV("Sidetone Volume", TLV320AIC23_ANLG, 6, 4, 0,
+			   snd_soc_tlv320aic23_get_volsw,
+			   snd_soc_tlv320aic23_put_volsw, sidetone_vol_tlv),
 	SOC_ENUM("Playback De-emphasis", tlv320aic23_deemph),
 };
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 71674be..7c244cd 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -863,34 +863,6 @@ static int digimic_event(struct snd_soc_dapm_widget *w,
  * Inverting not going to help with these.
  * Custom volsw and volsw_2r get/put functions to handle these gain bits.
  */
-#define SOC_DOUBLE_TLV_TWL4030(xname, xreg, shift_left, shift_right, xmax,\
-			       xinvert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_twl4030, \
-	.put = snd_soc_put_volsw_twl4030, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
-		 .max = xmax, .invert = xinvert} }
-#define SOC_DOUBLE_R_TLV_TWL4030(xname, reg_left, reg_right, xshift, xmax,\
-				 xinvert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
-	.get = snd_soc_get_volsw_r2_twl4030,\
-	.put = snd_soc_put_volsw_r2_twl4030, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		 .rshift = xshift, .max = xmax, .invert = xinvert} }
-#define SOC_SINGLE_TLV_TWL4030(xname, xreg, xshift, xmax, xinvert, tlv_array) \
-	SOC_DOUBLE_TLV_TWL4030(xname, xreg, xshift, xshift, xmax, \
-			       xinvert, tlv_array)
-
 static int snd_soc_get_volsw_twl4030(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -1197,19 +1169,23 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		TWL4030_REG_VDL_APGA_CTL, 1, 1, 0),
 
 	/* Separate output gain controls */
-	SOC_DOUBLE_R_TLV_TWL4030("PreDriv Playback Volume",
+	SOC_DOUBLE_R_EXT_TLV("PreDriv Playback Volume",
 		TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
-		4, 3, 0, output_tvl),
+		4, 3, 0, snd_soc_get_volsw_r2_twl4030,
+		snd_soc_put_volsw_r2_twl4030, output_tvl),
 
-	SOC_DOUBLE_TLV_TWL4030("Headset Playback Volume",
-		TWL4030_REG_HS_GAIN_SET, 0, 2, 3, 0, output_tvl),
+	SOC_DOUBLE_EXT_TLV("Headset Playback Volume",
+		TWL4030_REG_HS_GAIN_SET, 0, 2, 3, 0, snd_soc_get_volsw_twl4030,
+		snd_soc_put_volsw_twl4030, output_tvl),
 
-	SOC_DOUBLE_R_TLV_TWL4030("Carkit Playback Volume",
+	SOC_DOUBLE_R_EXT_TLV("Carkit Playback Volume",
 		TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
-		4, 3, 0, output_tvl),
+		4, 3, 0, snd_soc_get_volsw_r2_twl4030,
+		snd_soc_put_volsw_r2_twl4030, output_tvl),
 
-	SOC_SINGLE_TLV_TWL4030("Earpiece Playback Volume",
-		TWL4030_REG_EAR_CTL, 4, 3, 0, output_ear_tvl),
+	SOC_SINGLE_EXT_TLV("Earpiece Playback Volume",
+		TWL4030_REG_EAR_CTL, 4, 3, 0, snd_soc_get_volsw_twl4030,
+		snd_soc_put_volsw_twl4030, output_ear_tvl),
 
 	/* Common capture gain controls */
 	SOC_DOUBLE_R_TLV("TX1 Digital Capture Volume",
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index efcb28b..7e1c4c2 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -814,33 +814,6 @@ static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
 		return snd_soc_get_volsw(kcontrol, ucontrol);
 }
 
-/* double control with volume update */
-#define SOC_TWL6040_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax,\
-							xinvert, tlv_array)\
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw, .get = twl6040_get_volsw, \
-	.put = twl6040_put_volsw, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
-
-/* double control with volume update */
-#define SOC_TWL6040_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax,\
-				xinvert, tlv_array)\
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-		SNDRV_CTL_ELEM_ACCESS_READWRITE | \
-		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
-	.get = twl6040_get_volsw, .put = twl6040_put_volsw, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		 .rshift = xshift, .max = xmax, .invert = xinvert}, }
-
 static int twl6040_soc_dapm_put_vibra_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -1070,10 +1043,12 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 		TWL6040_REG_LINEGAIN, 0, 3, 7, 0, afm_amp_tlv),
 
 	/* Playback gains */
-	SOC_TWL6040_DOUBLE_TLV("Headset Playback Volume",
-		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
-	SOC_TWL6040_DOUBLE_R_TLV("Handsfree Playback Volume",
-		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1, hf_tlv),
+	SOC_DOUBLE_EXT_TLV("Headset Playback Volume",
+		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, twl6040_get_volsw,
+		twl6040_put_volsw, hs_tlv),
+	SOC_DOUBLE_R_EXT_TLV("Handsfree Playback Volume",
+		TWL6040_REG_HFLGAIN, TWL6040_REG_HFRGAIN, 0, 0x1D, 1,
+		twl6040_get_volsw, twl6040_put_volsw, hf_tlv),
 	SOC_SINGLE_TLV("Earphone Playback Volume",
 		TWL6040_REG_EARCTL, 1, 0xF, 1, ep_tlv),
 
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 6d6dc9e..50ea9d7 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -395,20 +395,6 @@ static int wm8350_get_volsw_2r(struct snd_kcontrol *kcontrol,
 	return snd_soc_get_volsw_2r(kcontrol, ucontrol);
 }
 
-/* double control with volume update */
-#define SOC_WM8350_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, \
-				xinvert, tlv_array) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-		SNDRV_CTL_ELEM_ACCESS_READWRITE | \
-		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
-	.get = wm8350_get_volsw_2r, .put = wm8350_put_volsw_2r_vu, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		 .rshift = xshift, .max = xmax, .invert = xinvert}, }
-
 static const char *wm8350_deemp[] = { "None", "32kHz", "44.1kHz", "48kHz" };
 static const char *wm8350_pol[] = { "Normal", "Inv R", "Inv L", "Inv L & R" };
 static const char *wm8350_dacmutem[] = { "Normal", "Soft" };
@@ -443,26 +429,29 @@ static const unsigned int capture_sd_tlv[] = {
 static const struct snd_kcontrol_new wm8350_snd_controls[] = {
 	SOC_ENUM("Playback Deemphasis", wm8350_enum[0]),
 	SOC_ENUM("Playback DAC Inversion", wm8350_enum[1]),
-	SOC_WM8350_DOUBLE_R_TLV("Playback PCM Volume",
+	SOC_DOUBLE_R_EXT_TLV("Playback PCM Volume",
 				WM8350_DAC_DIGITAL_VOLUME_L,
 				WM8350_DAC_DIGITAL_VOLUME_R,
-				0, 255, 0, dac_pcm_tlv),
+				0, 255, 0, wm8350_get_volsw_2r,
+				wm8350_put_volsw_2r_vu, dac_pcm_tlv),
 	SOC_ENUM("Playback PCM Mute Function", wm8350_enum[2]),
 	SOC_ENUM("Playback PCM Mute Speed", wm8350_enum[3]),
 	SOC_ENUM("Capture PCM Filter", wm8350_enum[4]),
 	SOC_ENUM("Capture PCM HP Filter", wm8350_enum[5]),
 	SOC_ENUM("Capture ADC Inversion", wm8350_enum[6]),
-	SOC_WM8350_DOUBLE_R_TLV("Capture PCM Volume",
+	SOC_DOUBLE_R_EXT_TLV("Capture PCM Volume",
 				WM8350_ADC_DIGITAL_VOLUME_L,
 				WM8350_ADC_DIGITAL_VOLUME_R,
-				0, 255, 0, adc_pcm_tlv),
+				0, 255, 0, wm8350_get_volsw_2r,
+				wm8350_put_volsw_2r_vu, adc_pcm_tlv),
 	SOC_DOUBLE_TLV("Capture Sidetone Volume",
 		       WM8350_ADC_DIVIDER,
 		       8, 4, 15, 1, capture_sd_tlv),
-	SOC_WM8350_DOUBLE_R_TLV("Capture Volume",
+	SOC_DOUBLE_R_EXT_TLV("Capture Volume",
 				WM8350_LEFT_INPUT_VOLUME,
 				WM8350_RIGHT_INPUT_VOLUME,
-				2, 63, 0, pre_amp_tlv),
+				2, 63, 0, wm8350_get_volsw_2r,
+				wm8350_put_volsw_2r_vu, pre_amp_tlv),
 	SOC_DOUBLE_R("Capture ZC Switch",
 		     WM8350_LEFT_INPUT_VOLUME,
 		     WM8350_RIGHT_INPUT_VOLUME, 13, 1, 0),
@@ -490,17 +479,19 @@ static const struct snd_kcontrol_new wm8350_snd_controls[] = {
 	SOC_SINGLE_TLV("Out4 Capture Volume",
 		       WM8350_INPUT_MIXER_VOLUME,
 		       1, 7, 0, out_mix_tlv),
-	SOC_WM8350_DOUBLE_R_TLV("Out1 Playback Volume",
+	SOC_DOUBLE_R_EXT_TLV("Out1 Playback Volume",
 				WM8350_LOUT1_VOLUME,
 				WM8350_ROUT1_VOLUME,
-				2, 63, 0, out_pga_tlv),
+				2, 63, 0, wm8350_get_volsw_2r,
+				wm8350_put_volsw_2r_vu, out_pga_tlv),
 	SOC_DOUBLE_R("Out1 Playback ZC Switch",
 		     WM8350_LOUT1_VOLUME,
 		     WM8350_ROUT1_VOLUME, 13, 1, 0),
-	SOC_WM8350_DOUBLE_R_TLV("Out2 Playback Volume",
+	SOC_DOUBLE_R_EXT_TLV("Out2 Playback Volume",
 				WM8350_LOUT2_VOLUME,
 				WM8350_ROUT2_VOLUME,
-				2, 63, 0, out_pga_tlv),
+				2, 63, 0, wm8350_get_volsw_2r,
+				wm8350_put_volsw_2r_vu, out_pga_tlv),
 	SOC_DOUBLE_R("Out2 Playback ZC Switch", WM8350_LOUT2_VOLUME,
 		     WM8350_ROUT2_VOLUME, 13, 1, 0),
 	SOC_SINGLE("Out2 Right Invert Switch", WM8350_ROUT2_VOLUME, 10, 1, 0),
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 4664c3a..02cbf13 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -224,31 +224,19 @@ static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define SOC_WM8580_OUT_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, \
-				    xinvert, tlv_array)			\
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		SNDRV_CTL_ELEM_ACCESS_READWRITE,  \
-	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_2r, \
-	.get = snd_soc_get_volsw_2r, .put = wm8580_out_vu, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .invert = xinvert} }
-
 static const struct snd_kcontrol_new wm8580_snd_controls[] = {
-SOC_WM8580_OUT_DOUBLE_R_TLV("DAC1 Playback Volume",
-			    WM8580_DIGITAL_ATTENUATION_DACL1,
-			    WM8580_DIGITAL_ATTENUATION_DACR1,
-			    0, 0xff, 0, dac_tlv),
-SOC_WM8580_OUT_DOUBLE_R_TLV("DAC2 Playback Volume",
-			    WM8580_DIGITAL_ATTENUATION_DACL2,
-			    WM8580_DIGITAL_ATTENUATION_DACR2,
-			    0, 0xff, 0, dac_tlv),
-SOC_WM8580_OUT_DOUBLE_R_TLV("DAC3 Playback Volume",
-			    WM8580_DIGITAL_ATTENUATION_DACL3,
-			    WM8580_DIGITAL_ATTENUATION_DACR3,
-			    0, 0xff, 0, dac_tlv),
+SOC_DOUBLE_R_EXT_TLV("DAC1 Playback Volume",
+		     WM8580_DIGITAL_ATTENUATION_DACL1,
+		     WM8580_DIGITAL_ATTENUATION_DACR1,
+		     0, 0xff, 0, snd_soc_get_volsw_2r, wm8580_out_vu, dac_tlv),
+SOC_DOUBLE_R_EXT_TLV("DAC2 Playback Volume",
+		     WM8580_DIGITAL_ATTENUATION_DACL2,
+		     WM8580_DIGITAL_ATTENUATION_DACR2,
+		     0, 0xff, 0, snd_soc_get_volsw_2r, wm8580_out_vu, dac_tlv),
+SOC_DOUBLE_R_EXT_TLV("DAC3 Playback Volume",
+		     WM8580_DIGITAL_ATTENUATION_DACL3,
+		     WM8580_DIGITAL_ATTENUATION_DACR3,
+		     0, 0xff, 0, snd_soc_get_volsw_2r, wm8580_out_vu, dac_tlv),
 
 SOC_SINGLE("DAC1 Deemphasis Switch", WM8580_DAC_CONTROL3, 0, 1, 0),
 SOC_SINGLE("DAC2 Deemphasis Switch", WM8580_DAC_CONTROL3, 1, 1, 0),
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index ca8ce03..f3583a5 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -362,19 +362,11 @@ SOC_DOUBLE_TLV("Speaker Boost Volume", WM8993_SPKOUT_BOOST, 3, 0, 7, 0,
 SOC_ENUM("Speaker Reference", speaker_ref),
 SOC_ENUM("Speaker Mode", speaker_mode),
 
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = "Headphone Volume",
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,
-	.tlv.p = outpga_tlv,
-	.info = snd_soc_info_volsw_2r,
-	.get = snd_soc_get_volsw_2r, .put = wm8993_put_dc_servo,
-	.private_value = (unsigned long)&(struct soc_mixer_control) {
-		.reg = WM8993_LEFT_OUTPUT_VOLUME,
-		.rreg = WM8993_RIGHT_OUTPUT_VOLUME,
-		.shift = 0, .max = 63
-	},
-},
+SOC_DOUBLE_R_EXT_TLV("Headphone Volume",
+		     WM8993_LEFT_OUTPUT_VOLUME, WM8993_RIGHT_OUTPUT_VOLUME,
+		     0, 63, 0, snd_soc_get_volsw_2r, wm8993_put_dc_servo,
+		     outpga_tlv),
+
 SOC_DOUBLE_R("Headphone Switch", WM8993_LEFT_OUTPUT_VOLUME,
 	     WM8993_RIGHT_OUTPUT_VOLUME, 6, 1, 0),
 SOC_DOUBLE_R("Headphone ZC Switch", WM8993_LEFT_OUTPUT_VOLUME,
-- 
1.7.7
