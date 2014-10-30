From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add jack detection for Broadwell
Date: Thu, 30 Oct 2014 21:16:23 +0800
Message-ID: <1414674983-7459-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 25194265191
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 14:16:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Add jack dectection and event reporting for Broadwell. It use combo
jack on BDW platform, which including Mic Jack pin and Headphone
jack pin.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/broadwell.c | 49 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 0e550f1..52cb764 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -19,6 +19,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include <sound/pcm_params.h>
 
 #include "sst-dsp.h"
@@ -26,8 +27,26 @@
 
 #include "../codecs/rt286.h"
 
+static struct snd_soc_jack broadwell_headset;
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin broadwell_headset_pins[] = {
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new broadwell_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+};
+
 static const struct snd_soc_dapm_widget broadwell_widgets[] = {
-	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 	SND_SOC_DAPM_MIC("DMIC1", NULL),
@@ -42,7 +61,7 @@ static const struct snd_soc_dapm_route broadwell_rt286_map[] = {
 	{"Speaker", NULL, "SPOL"},
 
 	/* HP jack connectors - unknown if we have jack deteck */
-	{"Headphones", NULL, "HPO Pin"},
+	{"Headphone Jack", NULL, "HPO Pin"},
 
 	/* other jacks */
 	{"MIC1", NULL, "Mic Jack"},
@@ -57,6 +76,27 @@ static const struct snd_soc_dapm_route broadwell_rt286_map[] = {
 	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
 };
 
+static int broadwell_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret = 0;
+	ret = snd_soc_jack_new(codec, "Headset",
+		SND_JACK_HEADSET | SND_JACK_BTN_0, &broadwell_headset);
+
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&broadwell_headset,
+		ARRAY_SIZE(broadwell_headset_pins),
+		broadwell_headset_pins);
+	if (ret)
+		return ret;
+
+	rt286_mic_detect(codec, &broadwell_headset);
+	return 0;
+}
+
+
 static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -116,7 +156,7 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* always connected - check HP for jack detect */
-	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_enable_pin(dapm, "Line Jack");
@@ -196,6 +236,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.no_pcm = 1,
 		.codec_name = "i2c-INT343A:00",
 		.codec_dai_name = "rt286-aif1",
+		.init = broadwell_rt286_codec_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_suspend = 1,
@@ -213,6 +254,8 @@ static struct snd_soc_card broadwell_rt286 = {
 	.owner = THIS_MODULE,
 	.dai_link = broadwell_rt286_dais,
 	.num_links = ARRAY_SIZE(broadwell_rt286_dais),
+	.controls = broadwell_controls,
+	.num_controls = ARRAY_SIZE(broadwell_controls),
 	.dapm_widgets = broadwell_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(broadwell_widgets),
 	.dapm_routes = broadwell_rt286_map,
-- 
1.9.1
