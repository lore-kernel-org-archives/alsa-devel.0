From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: byt-rt5640: Add quirk for
	Asus T100
Date: Mon, 29 Sep 2014 16:58:16 +0300
Message-ID: <1411999096-1867-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1411999096-1867-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 83D2D260614
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 15:58:24 +0200 (CEST)
In-Reply-To: <1411999096-1867-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Asus T100 internal microphone is not digital but analogue connected to IN1P
pin of the RT564x codec with shared bias between internal and headset
microphones. Because of this there is need to have machine specific DAPM
routes in byt-rt5640.

Add handling for them with the help of DMI quirk that is used to add custom
routes in addition to common. Because "Internal Mic" connected to DMIC1 is
not common to all move it as a default custom route when there is no match
in quirk table.

Custom "Internal Mic" -> "IN1P" with MICBIAS1 route is added for Asus T100.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index d6d8b19c22dc..c323a101214e 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -36,7 +37,6 @@ static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"Headset Mic", NULL, "MICBIAS1"},
 	{"IN2P", NULL, "Headset Mic"},
-	{"DMIC1", NULL, "Internal Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Speaker", NULL, "SPOLP"},
@@ -45,6 +45,22 @@ static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"Speaker", NULL, "SPORN"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic1_map[] = {
+	{"DMIC1", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "Internal Mic"},
+};
+
+enum {
+	BYT_RT5640_DMIC1_MAP,
+	BYT_RT5640_IN1_MAP,
+};
+
+static unsigned long byt_rt5640_custom_map = BYT_RT5640_DMIC1_MAP;
+
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -76,12 +92,32 @@ static int byt_rt5640_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_rt5640_custom_map = (unsigned long)id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
+	},
+	{}
+};
+
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_card *card = runtime->card;
+	const struct snd_soc_dapm_route *custom_map;
+	int num_routes;
 
 	card->dapm.idle_bias_off = true;
 
@@ -92,6 +128,21 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
+	dmi_check_system(byt_rt5640_quirk_table);
+	switch (byt_rt5640_custom_map) {
+	case BYT_RT5640_IN1_MAP:
+		custom_map = byt_rt5640_intmic_in1_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
+		break;
+	default:
+		custom_map = byt_rt5640_intmic_dmic1_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic1_map);
+	};
+
+	ret = snd_soc_dapm_add_routes(dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
+
 	snd_soc_dapm_ignore_suspend(dapm, "HPOL");
 	snd_soc_dapm_ignore_suspend(dapm, "HPOR");
 
-- 
2.1.0
