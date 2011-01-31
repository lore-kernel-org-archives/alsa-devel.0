From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCHv2] ASoC: omap: rx51: Add earphone support
Date: Mon, 31 Jan 2011 14:43:48 +0200
Message-ID: <1296477828-19434-1-git-send-email-jhnikula@gmail.com>
References: <20110127152718.GB9774@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F3D9D10388F
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:42:55 +0100 (CET)
Received: by bwz10 with SMTP id 10so5482537bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 04:42:55 -0800 (PST)
In-Reply-To: <20110127152718.GB9774@opensource.wolfsonmicro.com>
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
v2: Uses SOC_DAPM_PIN_SWITCH for implementing the "Earphone" widget and
kcontrol.
---
 sound/soc/omap/rx51.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 251afbe..2d7d411 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -242,6 +242,10 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
 };
 
+static const struct snd_soc_dapm_widget aic34_dapm_widgetsb[] = {
+	SND_SOC_DAPM_SPK("Earphone", NULL),
+};
+
 static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPLOUT"},
 	{"Ext Spk", NULL, "HPROUT"},
@@ -252,6 +256,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
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
@@ -271,6 +280,10 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 		     rx51_get_jack, rx51_set_jack),
 };
 
+static const struct snd_kcontrol_new aic34_rx51_controlsb[] = {
+	SOC_DAPM_PIN_SWITCH("Earphone"),
+};
+
 static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
@@ -314,6 +327,24 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
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
+	return snd_soc_dapm_add_routes(dapm, audio_mapb,
+				       ARRAY_SIZE(audio_mapb));
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -328,11 +359,30 @@ static struct snd_soc_dai_link rx51_dai[] = {
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
