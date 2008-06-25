From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 3/3] ASoC: Add digital mic
	configuration to N810 machine driver
Date: Wed, 25 Jun 2008 14:58:47 +0300
Message-ID: <1214395127-7169-4-git-send-email-jarkko.nikula@nokia.com>
References: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B837924370
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 14:01:21 +0200 (CEST)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PC0x0Q000407
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 15:01:20 +0300
In-Reply-To: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index c168a64..767b39f 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -46,11 +46,13 @@ static struct clk *func96m_clk;
 
 static int n810_spk_func;
 static int n810_jack_func;
+static int n810_dmic_func;
 
 static void n810_ext_control(struct snd_soc_codec *codec)
 {
 	snd_soc_dapm_set_endpoint(codec, "Ext Spk", n810_spk_func);
 	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", n810_jack_func);
+	snd_soc_dapm_set_endpoint(codec, "DMic", n810_dmic_func);
 
 	snd_soc_dapm_sync_endpoints(codec);
 }
@@ -150,6 +152,28 @@ static int n810_set_jack(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static int n810_get_input(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = n810_dmic_func;
+
+	return 0;
+}
+
+static int n810_set_input(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (n810_dmic_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	n810_dmic_func = ucontrol->value.integer.value[0];
+	n810_ext_control(codec);
+
+	return 1;
+}
+
 static int n810_spk_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *k, int event)
 {
@@ -175,6 +199,7 @@ static int n810_jack_event(struct snd_soc_dapm_widget *w,
 static const struct snd_soc_dapm_widget aic33_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", n810_spk_event),
 	SND_SOC_DAPM_HP("Headphone Jack", n810_jack_event),
+	SND_SOC_DAPM_MIC("DMic", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -183,13 +208,18 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{"Ext Spk", NULL, "LLOUT"},
 	{"Ext Spk", NULL, "RLOUT"},
+
+	{"DMic Rate 64", NULL, "Mic Bias 2V"},
+	{"Mic Bias 2V", NULL, "DMic"},
 };
 
 static const char *spk_function[] = {"Off", "On"};
 static const char *jack_function[] = {"Off", "Headphone"};
+static const char *input_function[] = {"ADC", "Digital Mic"};
 static const struct soc_enum n810_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(input_function), input_function),
 };
 
 static const struct snd_kcontrol_new aic33_n810_controls[] = {
@@ -197,6 +227,8 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 		     n810_get_spk, n810_set_spk),
 	SOC_ENUM_EXT("Jack Function", n810_enum[1],
 		     n810_get_jack, n810_set_jack),
+	SOC_ENUM_EXT("Input Select",  n810_enum[2],
+		     n810_get_input, n810_set_input),
 };
 
 static int n810_aic33_init(struct snd_soc_codec *codec)
@@ -248,6 +280,8 @@ static struct snd_soc_machine snd_soc_machine_n810 = {
 /* Audio private data */
 static struct aic3x_setup_data n810_aic33_setup = {
 	.i2c_address = 0x18,
+	.gpio_func[0] = AIC3X_GPIO1_FUNC_DISABLED,
+	.gpio_func[1] = AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT,
 };
 
 /* Audio subsystem */
-- 
1.5.5.4
