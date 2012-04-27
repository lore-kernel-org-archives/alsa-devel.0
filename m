From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm_hubs: Enable class W for output
	mixer paths
Date: Fri, 27 Apr 2012 18:35:01 +0100
Message-ID: <1335548101-22693-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335548101-22693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71B032455F
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 19:35:06 +0200 (CEST)
In-Reply-To: <1335548101-22693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Class W can be used for any path where only data from the DAC is routed
to the headphones. Currently we only enable it when the direct DAC to
headphone path is used but it can also be enabled for paths that go via
the output mixer providing the DAC is the only input to the output mixer.
Implement support for this, including updates to the class W status when
the output mixer configuration is changed. This also allows us to enable
the DC servo optimisations for DAC to headphone paths where the output
mixer is used.

In general the direct DAC path is still preferred as this will offer
better performance on most wm_hubs devices but these additional paths
can simplify use case management.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   61 +++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 803b3b6..8a29843 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -122,7 +122,6 @@ static bool wm_hubs_dac_hp_direct(struct snd_soc_codec *codec)
 			return false;
 		} else {
 			dev_vdbg(codec->dev, "HPL connected to mixer\n");
-			return false;
 		}
 	} else {
 		dev_vdbg(codec->dev, "HPL connected to DAC\n");
@@ -136,7 +135,6 @@ static bool wm_hubs_dac_hp_direct(struct snd_soc_codec *codec)
 			return false;
 		} else {
 			dev_vdbg(codec->dev, "HPR connected to mixer\n");
-			return false;
 		}
 	} else {
 		dev_vdbg(codec->dev, "HPR connected to DAC\n");
@@ -584,15 +582,36 @@ void wm_hubs_update_class_w(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
 
+#define WM_HUBS_SINGLE_W(xname, reg, shift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = class_w_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+
+static int class_w_put_volsw(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
+	int ret;
+
+	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
+
+	wm_hubs_update_class_w(codec);
+
+	return ret;
+}
+
 #define WM_HUBS_ENUM_W(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_dapm_get_enum_double, \
-	.put = class_w_put, \
+	.put = class_w_put_double, \
 	.private_value = (unsigned long)&xenum }
 
-static int class_w_put(struct snd_kcontrol *kcontrol,
-		       struct snd_ctl_elem_value *ucontrol)
+static int class_w_put_double(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
@@ -656,25 +675,25 @@ SOC_DAPM_SINGLE("IN1R Switch", WM8993_INPUT_MIXER4, 5, 1, 0),
 };
 
 static const struct snd_kcontrol_new left_output_mixer[] = {
-SOC_DAPM_SINGLE("Right Input Switch", WM8993_OUTPUT_MIXER1, 7, 1, 0),
-SOC_DAPM_SINGLE("Left Input Switch", WM8993_OUTPUT_MIXER1, 6, 1, 0),
-SOC_DAPM_SINGLE("IN2RN Switch", WM8993_OUTPUT_MIXER1, 5, 1, 0),
-SOC_DAPM_SINGLE("IN2LN Switch", WM8993_OUTPUT_MIXER1, 4, 1, 0),
-SOC_DAPM_SINGLE("IN2LP Switch", WM8993_OUTPUT_MIXER1, 1, 1, 0),
-SOC_DAPM_SINGLE("IN1R Switch", WM8993_OUTPUT_MIXER1, 3, 1, 0),
-SOC_DAPM_SINGLE("IN1L Switch", WM8993_OUTPUT_MIXER1, 2, 1, 0),
-SOC_DAPM_SINGLE("DAC Switch", WM8993_OUTPUT_MIXER1, 0, 1, 0),
+WM_HUBS_SINGLE_W("Right Input Switch", WM8993_OUTPUT_MIXER1, 7, 1, 0),
+WM_HUBS_SINGLE_W("Left Input Switch", WM8993_OUTPUT_MIXER1, 6, 1, 0),
+WM_HUBS_SINGLE_W("IN2RN Switch", WM8993_OUTPUT_MIXER1, 5, 1, 0),
+WM_HUBS_SINGLE_W("IN2LN Switch", WM8993_OUTPUT_MIXER1, 4, 1, 0),
+WM_HUBS_SINGLE_W("IN2LP Switch", WM8993_OUTPUT_MIXER1, 1, 1, 0),
+WM_HUBS_SINGLE_W("IN1R Switch", WM8993_OUTPUT_MIXER1, 3, 1, 0),
+WM_HUBS_SINGLE_W("IN1L Switch", WM8993_OUTPUT_MIXER1, 2, 1, 0),
+WM_HUBS_SINGLE_W("DAC Switch", WM8993_OUTPUT_MIXER1, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new right_output_mixer[] = {
-SOC_DAPM_SINGLE("Left Input Switch", WM8993_OUTPUT_MIXER2, 7, 1, 0),
-SOC_DAPM_SINGLE("Right Input Switch", WM8993_OUTPUT_MIXER2, 6, 1, 0),
-SOC_DAPM_SINGLE("IN2LN Switch", WM8993_OUTPUT_MIXER2, 5, 1, 0),
-SOC_DAPM_SINGLE("IN2RN Switch", WM8993_OUTPUT_MIXER2, 4, 1, 0),
-SOC_DAPM_SINGLE("IN1L Switch", WM8993_OUTPUT_MIXER2, 3, 1, 0),
-SOC_DAPM_SINGLE("IN1R Switch", WM8993_OUTPUT_MIXER2, 2, 1, 0),
-SOC_DAPM_SINGLE("IN2RP Switch", WM8993_OUTPUT_MIXER2, 1, 1, 0),
-SOC_DAPM_SINGLE("DAC Switch", WM8993_OUTPUT_MIXER2, 0, 1, 0),
+WM_HUBS_SINGLE_W("Left Input Switch", WM8993_OUTPUT_MIXER2, 7, 1, 0),
+WM_HUBS_SINGLE_W("Right Input Switch", WM8993_OUTPUT_MIXER2, 6, 1, 0),
+WM_HUBS_SINGLE_W("IN2LN Switch", WM8993_OUTPUT_MIXER2, 5, 1, 0),
+WM_HUBS_SINGLE_W("IN2RN Switch", WM8993_OUTPUT_MIXER2, 4, 1, 0),
+WM_HUBS_SINGLE_W("IN1L Switch", WM8993_OUTPUT_MIXER2, 3, 1, 0),
+WM_HUBS_SINGLE_W("IN1R Switch", WM8993_OUTPUT_MIXER2, 2, 1, 0),
+WM_HUBS_SINGLE_W("IN2RP Switch", WM8993_OUTPUT_MIXER2, 1, 1, 0),
+WM_HUBS_SINGLE_W("DAC Switch", WM8993_OUTPUT_MIXER2, 0, 1, 0),
 };
 
 static const struct snd_kcontrol_new earpiece_mixer[] = {
-- 
1.7.10
