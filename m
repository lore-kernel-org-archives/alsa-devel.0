Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 866332673F5
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 12:25:57 +0200 (CEST)
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 11 Apr 2018 15:55:01 +0530
Message-Id: <1523442303-12710-4-git-send-email-naveen.m@intel.com>
In-Reply-To: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
References: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
Subject: [alsa-devel] [PATCH v2 3/5] ASoC: Intel: Add Geminilake Dialog
	Maxim machine driver support
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-ID: <alsa-devel@alsa-project.org>

Patch adds required changes in bxt machine to use MAX98357A codec
as speaker on SSP1 & DA7219 codec as headset on SSP2 on GLK board.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 124 ++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 2eff1f0..6c23aaa 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <asm/cpu_device_id.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -33,6 +34,7 @@
 #define DUAL_CHANNEL		2
 #define QUAD_CHANNEL		4
 
+static struct snd_soc_card *audio_card;
 static struct snd_soc_jack broxton_headset;
 static struct snd_soc_jack broxton_hdmi[3];
 
@@ -103,7 +105,7 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
 			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
 };
 
-static const struct snd_soc_dapm_route broxton_map[] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{"Headphone Jack", NULL, "HPL"},
 	{"Headphone Jack", NULL, "HPR"},
@@ -118,15 +120,6 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 	{"DMic", NULL, "SoC DMIC"},
 
 	/* CODEC BE connections */
-	{"HiFi Playback", NULL, "ssp5 Tx"},
-	{"ssp5 Tx", NULL, "codec0_out"},
-
-	{"Playback", NULL, "ssp1 Tx"},
-	{"ssp1 Tx", NULL, "codec1_out"},
-
-	{"codec0_in", NULL, "ssp1 Rx"},
-	{"ssp1 Rx", NULL, "Capture"},
-
 	{"HDMI1", NULL, "hif5-0 Output"},
 	{"HDMI2", NULL, "hif6-0 Output"},
 	{"HDMI2", NULL, "hif7-0 Output"},
@@ -146,6 +139,28 @@ static const struct snd_soc_dapm_route broxton_map[] = {
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
+static const struct snd_soc_dapm_route broxton_map[] = {
+	{"HiFi Playback", NULL, "ssp5 Tx"},
+	{"ssp5 Tx", NULL, "codec0_out"},
+
+	{"Playback", NULL, "ssp1 Tx"},
+	{"ssp1 Tx", NULL, "codec1_out"},
+
+	{"codec0_in", NULL, "ssp1 Rx"},
+	{"ssp1 Rx", NULL, "Capture"},
+};
+
+static const struct snd_soc_dapm_route gemini_map[] = {
+	{"HiFi Playback", NULL, "ssp1 Tx"},
+	{"ssp1 Tx", NULL, "codec0_out"},
+
+	{"Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec1_out"},
+
+	{"codec0_in", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "Capture"},
+};
+
 static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -524,6 +539,18 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	},
 };
 
+static int is_geminilake(void)
+{
+	static const struct x86_cpu_id cpu_ids[] = {
+		{ X86_VENDOR_INTEL, 6, 0x7A },	/* Geminilake CPU_ID */
+		{}
+	};
+
+	if (x86_match_cpu(cpu_ids))
+		return true;
+	return false;
+}
+
 #define NAME_SIZE	32
 static int bxt_card_late_probe(struct snd_soc_card *card)
 {
@@ -533,6 +560,13 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
+	if (is_geminilake())
+		snd_soc_dapm_add_routes(&card->dapm, gemini_map,
+				ARRAY_SIZE(gemini_map));
+	else
+		snd_soc_dapm_add_routes(&card->dapm, broxton_map,
+				ARRAY_SIZE(broxton_map));
+
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
@@ -559,7 +593,7 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 }
 
 /* broxton audio machine driver for SPT + da7219 */
-static struct snd_soc_card broxton_audio_card = {
+static struct snd_soc_card bxt_audio_card_da7219_m98357a = {
 	.name = "bxtda7219max",
 	.owner = THIS_MODULE,
 	.dai_link = broxton_dais,
@@ -568,15 +602,35 @@ static struct snd_soc_card broxton_audio_card = {
 	.num_controls = ARRAY_SIZE(broxton_controls),
 	.dapm_widgets = broxton_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
-	.dapm_routes = broxton_map,
-	.num_dapm_routes = ARRAY_SIZE(broxton_map),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
 	.late_probe = bxt_card_late_probe,
 };
 
+/* geminilake audio machine driver for SPT + DA7219 */
+static struct snd_soc_card glk_audio_card_da7219_m98357a = {
+	.name = "glkda7219max",
+	.owner = THIS_MODULE,
+	.dai_link = broxton_dais,
+	.num_links = ARRAY_SIZE(broxton_dais),
+	.controls = broxton_controls,
+	.num_controls = ARRAY_SIZE(broxton_controls),
+	.dapm_widgets = broxton_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.fully_routed = true,
+	.late_probe = bxt_card_late_probe,
+};
+
+static char glk_spk_dai_name[10];
+static char glk_hs_dai_name[10];
+
 static int broxton_audio_probe(struct platform_device *pdev)
 {
 	struct bxt_card_private *ctx;
+	int dai_index = 8;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -584,18 +638,54 @@ static int broxton_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	broxton_audio_card.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
+	audio_card =
+		(struct snd_soc_card *)pdev->id_entry->driver_data;
+
+	audio_card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(audio_card, ctx);
+
+	if (is_geminilake()) {
+		/* fixup name & cpu_dai_name for SPK */
+		snprintf(glk_spk_dai_name,
+			sizeof(glk_spk_dai_name), "%s", "SSP1-Codec");
+		broxton_dais[dai_index].name = glk_spk_dai_name;
+		snprintf(glk_spk_dai_name,
+			sizeof(glk_spk_dai_name), "%s", "SSP1 Pin");
+		broxton_dais[dai_index].cpu_dai_name = glk_spk_dai_name;
+		/* fixup name & cpu_dai_name for HS*/
+		dai_index++;
+		snprintf(glk_hs_dai_name,
+			sizeof(glk_hs_dai_name), "%s", "SSP2-Codec");
+		broxton_dais[dai_index].name = glk_hs_dai_name;
+		snprintf(glk_hs_dai_name,
+			sizeof(glk_hs_dai_name), "%s", "SSP2 Pin");
+		broxton_dais[dai_index].cpu_dai_name = glk_hs_dai_name;
+	}
 
-	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
+	return devm_snd_soc_register_card(&pdev->dev, audio_card);
 }
 
+static const struct platform_device_id bxt_board_ids[] = {
+	{
+		.name = "bxt_da7219_max98357a",
+		.driver_data =
+			(kernel_ulong_t)&bxt_audio_card_da7219_m98357a,
+	},
+	{
+		.name = "glk_da7219_max98357a",
+		.driver_data =
+			(kernel_ulong_t)&glk_audio_card_da7219_m98357a,
+	},
+	{ }
+};
+
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
 		.name = "bxt_da7219_max98357a",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = bxt_board_ids,
 };
 module_platform_driver(broxton_audio)
 
@@ -605,5 +695,7 @@ MODULE_AUTHOR("Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
+MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:bxt_da7219_max98357a");
+MODULE_ALIAS("platform:glk_da7219_max98357a");
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
