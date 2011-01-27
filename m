From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: omap: rx51: Add earphone support
Date: Thu, 27 Jan 2011 16:47:12 +0200
Message-ID: <1296139632-17457-2-git-send-email-jhnikula@gmail.com>
References: <1296139632-17457-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ADA38103B08
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 15:46:05 +0100 (CET)
Received: by gxk21 with SMTP id 21so735516gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 06:46:02 -0800 (PST)
In-Reply-To: <1296139632-17457-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Earphone in Nokia RX-51/N900 is connected to left HP output of B part of the
TLV320AIC34 dual codec. In RX-51 the codec A is used as a traditional codec
and the codec B as an auxiliary device.

Audio from codec A goes via the codec B to earphone:
MONO_LOUT of A -> LINE2R of B (B interconnects) -> HPLOUT of B -> Earphone.

Take earphone into use by utilizing the recent ASoC auxiliary and
cross-device support.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
This is not the most optimal way to handle but anyway the N900 is a nice
test and development environment for ASoC cross-device etc. stuff so take
the codec B part into use.
---
 sound/soc/omap/rx51.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 251afbe..5f8e69b 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -55,6 +55,7 @@ enum {
 static int rx51_spk_func;
 static int rx51_dmic_func;
 static int rx51_jack_func;
+static int rx51_ear_func;
 
 static void rx51_ext_control(struct snd_soc_codec *codec)
 {
@@ -224,6 +225,34 @@ static int rx51_set_jack(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static int rx51_get_ear(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_ear_func;
+
+	return 0;
+}
+
+static int rx51_set_ear(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	if (rx51_ear_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_ear_func = ucontrol->value.integer.value[0];
+	if (rx51_ear_func)
+		snd_soc_dapm_enable_pin(dapm, "Earphone");
+	else
+		snd_soc_dapm_disable_pin(dapm, "Earphone");
+
+	snd_soc_dapm_sync(dapm);
+
+	return 1;
+}
+
 static struct snd_soc_jack rx51_av_jack;
 
 static struct snd_soc_jack_gpio rx51_av_jack_gpios[] = {
@@ -242,6 +271,10 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
 };
 
+static const struct snd_soc_dapm_widget aic34_dapm_widgetsb[] = {
+	SND_SOC_DAPM_SPK("Earphone", NULL),
+};
+
 static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPLOUT"},
 	{"Ext Spk", NULL, "HPROUT"},
@@ -252,14 +285,21 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Mic Bias 2V", NULL, "DMic"},
 };
 
+static const struct snd_soc_dapm_route audio_mapb[] = {
+	{"b LINE2R", NULL, "MONO_LOUT"},
+	{"Earphone", NULL, "b HPLOUT"},
+};
+
 static const char *spk_function[] = {"Off", "On"};
 static const char *input_function[] = {"ADC", "Digital Mic"};
 static const char *jack_function[] = {"Off", "TV-OUT", "Headphone"};
+static const char *ear_function[] = {"Off", "On"};
 
 static const struct soc_enum rx51_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(input_function), input_function),
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(ear_function), ear_function),
 };
 
 static const struct snd_kcontrol_new aic34_rx51_controls[] = {
@@ -271,6 +311,11 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 		     rx51_get_jack, rx51_set_jack),
 };
 
+static const struct snd_kcontrol_new aic34_rx51_controlsb[] = {
+	 SOC_ENUM_EXT("Earphone Function",  rx51_enum[3],
+		      rx51_get_ear, rx51_set_ear),
+};
+
 static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -314,6 +359,26 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+static int rx51_aic34b_init(struct snd_soc_dapm_context *dapm)
+{
+	int err;
+
+	err = snd_soc_add_controls(dapm->codec, aic34_rx51_controlsb,
+				   ARRAY_SIZE(aic34_rx51_controlsb));
+	if (err < 0)
+		return err;
+
+	err = snd_soc_dapm_new_controls(dapm, aic34_dapm_widgetsb,
+					ARRAY_SIZE(aic34_dapm_widgetsb));
+	if (err < 0)
+		return 0;
+
+	snd_soc_dapm_disable_pin(dapm, "Earphone");
+
+	return snd_soc_dapm_add_routes(dapm, audio_mapb,
+				       ARRAY_SIZE(audio_mapb));
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -328,11 +393,30 @@ static struct snd_soc_dai_link rx51_dai[] = {
 	},
 };
 
+struct snd_soc_aux_dev rx51_aux_dev[] = {
+	{
+		.name = "TLV320AIC34b",
+		.codec_name = "tlv320aic3x-codec.2-0019",
+		.init = rx51_aic34b_init,
+	},
+};
+
+static struct snd_soc_codec_conf rx51_codec_conf[] = {
+	{
+		.dev_name = "tlv320aic3x-codec.2-0019",
+		.name_prefix = "b",
+	},
+};
+
 /* Audio card */
 static struct snd_soc_card rx51_sound_card = {
 	.name = "RX-51",
 	.dai_link = rx51_dai,
 	.num_links = ARRAY_SIZE(rx51_dai),
+	.aux_dev = rx51_aux_dev,
+	.num_aux_devs = ARRAY_SIZE(rx51_aux_dev),
+	.codec_conf = rx51_codec_conf,
+	.num_configs = ARRAY_SIZE(rx51_codec_conf),
 };
 
 static struct platform_device *rx51_snd_device;
-- 
1.7.2.3
