From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2] ASoC: MAX9860: new driver
Date: Thu, 12 May 2016 23:52:06 +0200
Message-ID: <4e38e1c2-217a-ae97-90e6-440820d0ff0a@axentia.se>
References: <1463067301-6047-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0128.outbound.protection.outlook.com [104.47.0.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 8385A26047C
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 23:52:15 +0200 (CEST)
In-Reply-To: <1463067301-6047-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Misbah Ullah Khan <Misbahk@danlawinc.com>
List-Id: alsa-devel@alsa-project.org

[Dropping the DT crowd]

On 2016-05-12 17:35, Peter Rosin wrote:
> This is a driver for the MAX9860 Mono Audio Voice Codec.
> 
> https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
> 
> This driver does not support sidetone since the DVST register field is
> backwards with the mute near the maximum level instead of the minimum.

This is what I have (on top of v2). It kind of works, but as you can see,
the mute_value is needed in dapm_set_mixer_path_status which operates on
entries in path->sink->kcontrol_news[] which I believe is constant. That
kind of defeats the runtime TLV lookup thing storing the value, no?

So, I allow setting the mute_value manually instead. I could have created
new macros to help create the mixer control, but didn't. Perhaps I should
have?

I also noted that with this, an "on" sidetone will keep the system up.
Ideally the sidetone volsw should only have the power to turn on the DAC
and the left ADC when the DAC is "on" for other reasons. At the same
time the sidetone needs to turn on the left channel ADC when the DAC
is "on", so using DAPM seems like the right thing. Is this an old
problem that have been solves elsewhere? If so, how is that handled in
other codecs?

Cheers,
Peter

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a215fd75..79b6a2f2a3a9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1239,6 +1239,7 @@ struct soc_mixer_control {
 	unsigned int sign_bit;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
+	int mute_value;
 	struct snd_soc_dobj dobj;
 };
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c4464858bf01..765dfdfe0f4a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -732,6 +732,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 	unsigned int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int mute_value = mc->mute_value;
 	unsigned int val;
 
 	if (reg != SND_SOC_NOPM) {
@@ -739,7 +740,7 @@ static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
 		val = (val >> shift) & mask;
 		if (invert)
 			val = max - val;
-		p->connect = !!val;
+		p->connect = val != mute_value;
 	} else {
 		p->connect = 0;
 	}
@@ -3045,6 +3046,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int mute_value = mc->mute_value;
 	unsigned int val;
 	int connect, change, reg_change = 0;
 	struct snd_soc_dapm_update update;
@@ -3056,7 +3058,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			 kcontrol->id.name);
 
 	val = (ucontrol->value.integer.value[0] & mask);
-	connect = !!val;
+	connect = val != mute_value;
 
 	if (invert)
 		val = max - val;
diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index ee30832b0afb..075874be3877 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -3,9 +3,6 @@
  *
  * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
  *
- * The driver does not support sidetone since the DVST register field is
- * backwards with the mute near the maximum level instead of the minimum.
- *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
  *
@@ -135,6 +132,10 @@ const struct regmap_config max9860_regmap = {
 static const DECLARE_TLV_DB_SCALE(dva_tlv, -9100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(dvg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, -1200, 100, 0);
+/* The dvst field has its mute in the wrong end. Sigh. */
+static const DECLARE_TLV_DB_RANGE(dvst_tlv,
+	0, MAX9860_DVST_MIN - 1,            TLV_DB_SCALE_ITEM(-6000, 200, 0),
+	MAX9860_DVST_MIN, MAX9860_DVST_MIN, TLV_DB_SCALE_ITEM(0, 0, 1));
 static const DECLARE_TLV_DB_RANGE(pam_tlv,
 	0, MAX9860_PAM_MAX - 1,             TLV_DB_SCALE_ITEM(-2000, 2000, 1),
 	MAX9860_PAM_MAX, MAX9860_PAM_MAX,   TLV_DB_SCALE_ITEM(3000, 0, 0));
@@ -214,6 +215,21 @@ SOC_ENUM("ADC Filter", avflt_enum),
 SOC_ENUM("DAC Filter", dvflt_enum),
 };
 
+static const struct snd_kcontrol_new max9860_mixer_controls[] = {
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = "Sidetone Volume",
+	.info = snd_soc_info_volsw,
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ
+		| SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.tlv.p = dvst_tlv,
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw,
+	.private_value = ((unsigned long)&(struct soc_mixer_control) {
+		.reg = MAX9860_DACGAIN, .rreg = MAX9860_DACGAIN,
+		.shift = MAX9860_DVST_SHIFT, .rshift = MAX9860_DVST_SHIFT,
+		.max = MAX9860_DVST_MIN, .platform_max = MAX9860_DVST_MIN,
+		.invert = 1, .autodisable = 0, .mute_value = MAX9860_DVST_MIN
+	})},
+};
+
 static const struct snd_soc_dapm_widget max9860_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("MICL"),
 SND_SOC_DAPM_INPUT("MICR"),
@@ -224,6 +240,10 @@ SND_SOC_DAPM_ADC("ADCR", NULL, MAX9860_PWRMAN, MAX9860_ADCREN_SHIFT, 0),
 SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),
 
+SND_SOC_DAPM_MIXER("Mixer", SND_SOC_NOPM, 0, 0,
+		   max9860_mixer_controls,
+		   ARRAY_SIZE(max9860_mixer_controls)),
+
 SND_SOC_DAPM_AIF_IN("AIFINL", "Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIFINR", "Playback", 1, SND_SOC_NOPM, 0, 0),
 
@@ -244,8 +264,10 @@ static const struct snd_soc_dapm_route max9860_dapm_routes[] = {
 	{ "AIFOUTL", NULL, "ADCL" },
 	{ "AIFOUTR", NULL, "ADCR" },
 
-	{ "DAC", NULL, "AIFINL" },
-	{ "DAC", NULL, "AIFINR" },
+	{ "Mixer", NULL, "AIFINL" },
+	{ "Mixer", NULL, "AIFINR" },
+	{ "Mixer", "Sidetone Volume", "ADCL" },
+	{ "DAC", NULL, "Mixer" },
 	{ "OUT", NULL, "DAC" },
 
 	{ "Supply", NULL, "AVDD" },
