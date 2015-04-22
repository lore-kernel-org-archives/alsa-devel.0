From: yang.a.fang@intel.com
Subject: [PATCH v2] ASoC: Intel: Support rt5650 codec for
	Cherrytrail & Braswell
Date: Wed, 22 Apr 2015 14:56:04 -0700
Message-ID: <1429739764-89495-1-git-send-email-yang.a.fang@intel.com>
References: <1429659360-99360-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B952617C1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 23:56:43 +0200 (CEST)
In-Reply-To: <1429659360-99360-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

rt5650 and rt5645 are similar codec so reuse the cht_bsw_rt5645 driver

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/Kconfig                 |    5 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |   93 +++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ee03dbd..4ee37e8 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -112,12 +112,13 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
           If unsure select "N".
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
-	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645 codec"
+	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
 	depends on X86_INTEL_LPSS
+	select SND_SOC_INTEL_BAYTRAIL
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
 	help
 	  This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
-	  platforms with RT5645 audio codec.
+	  platforms with RT5645/5650 audio codec.
 	  If unsure select "N".
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 20a28b2..7d23ead 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
@@ -33,9 +34,16 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5645-aif1"
 
+struct cht_acpi_card {
+	char *codec_id;
+	int codec_type;
+	struct snd_soc_card *soc_card;
+};
+
 struct cht_mc_private {
 	struct snd_soc_jack hp_jack;
 	struct snd_soc_jack mic_jack;
+	struct cht_acpi_card *acpi_card;
 };
 
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
@@ -94,7 +102,7 @@ static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 			platform_clock_control, SND_SOC_DAPM_POST_PMD),
 };
 
-static const struct snd_soc_dapm_route cht_audio_map[] = {
+static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Int Mic"},
@@ -115,6 +123,27 @@ static const struct snd_soc_dapm_route cht_audio_map[] = {
 	{"Ext Spk", NULL, "Platform Clock"},
 };
 
+static const struct snd_soc_dapm_route cht_rt5650_audio_map[] = {
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+	{"DMIC L2", NULL, "Int Mic"},
+	{"DMIC R2", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOL"},
+	{"Ext Spk", NULL, "SPOR"},
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx" },
+	{"codec_in1", NULL, "ssp2 Rx" },
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+	{"Headphone", NULL, "Platform Clock"},
+	{"Headset Mic", NULL, "Platform Clock"},
+	{"Int Mic", NULL, "Platform Clock"},
+	{"Ext Spk", NULL, "Platform Clock"},
+};
+
 static const struct snd_kcontrol_new cht_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -239,7 +268,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
+		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
@@ -267,7 +296,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 					| SND_SOC_DAIFMT_CBS_CFS,
 		.init = cht_codec_init,
 		.be_hw_params_fixup = cht_codec_fixup,
-		.ignore_suspend = 1,
+		.nonatomic = true,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &cht_be_ssp2_ops,
@@ -275,43 +304,85 @@ static struct snd_soc_dai_link cht_dailink[] = {
 };
 
 /* SoC card */
-static struct snd_soc_card snd_soc_card_cht = {
+static struct snd_soc_card snd_soc_card_chtrt5645 = {
 	.name = "chtrt5645",
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
 	.dapm_widgets = cht_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(cht_dapm_widgets),
-	.dapm_routes = cht_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(cht_audio_map),
+	.dapm_routes = cht_rt5645_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cht_rt5645_audio_map),
 	.controls = cht_mc_controls,
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
+static struct snd_soc_card snd_soc_card_chtrt5650 = {
+	.name = "chtrt5650",
+	.dai_link = cht_dailink,
+	.num_links = ARRAY_SIZE(cht_dailink),
+	.dapm_widgets = cht_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cht_dapm_widgets),
+	.dapm_routes = cht_rt5650_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cht_rt5650_audio_map),
+	.controls = cht_mc_controls,
+	.num_controls = ARRAY_SIZE(cht_mc_controls),
+};
+
+static struct cht_acpi_card snd_soc_cards[] = {
+	{"10EC5645", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
+	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
+};
+
+static acpi_status snd_acpi_codec_match(acpi_handle handle, u32 level,
+				       void *context, void **ret)
+{
+	*(bool *)context = true;
+	return AE_OK;
+}
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
+	int i;
 	struct cht_mc_private *drv;
+	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
+	bool found = false;
+	char codec_name[16];
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
 		return -ENOMEM;
 
-	snd_soc_card_cht.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
+	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
+		if (ACPI_SUCCESS(acpi_get_devices(
+						snd_soc_cards[i].codec_id,
+						snd_acpi_codec_match,
+						&found, NULL)) && found) {
+			dev_dbg(&pdev->dev,
+				"found codec %s\n", snd_soc_cards[i].codec_id);
+			card = snd_soc_cards[i].soc_card;
+			drv->acpi_card = &snd_soc_cards[i];
+			break;
+		}
+	}
+	card->dev = &pdev->dev;
+	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
+	/* set correct codec name */
+	strcpy((char *)card->dai_link[2].codec_name, codec_name);
+	snd_soc_card_set_drvdata(card, drv);
+	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
 		dev_err(&pdev->dev,
 			"snd_soc_register_card failed %d\n", ret_val);
 		return ret_val;
 	}
-	platform_set_drvdata(pdev, &snd_soc_card_cht);
+	platform_set_drvdata(pdev, card);
 	return ret_val;
 }
 
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-rt5645",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_cht_mc_probe,
 };
-- 
1.7.9.5
