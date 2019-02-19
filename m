From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add Geminilake Dialog Maxim
	machine driver" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:11 +0000 (GMT)
Message-ID: <20190219155011.DC6B311284B5@debutante.sirena.org.uk>
References: <1550099333-12229-2-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39375F80795
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:44 +0100 (CET)
In-Reply-To: <1550099333-12229-2-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add Geminilake Dialog Maxim machine driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c011245a197017f8e9e9d140b658bdb2b702a0c5 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Wed, 13 Feb 2019 17:08:52 -0600
Subject: [PATCH] ASoC: Intel: Add Geminilake Dialog Maxim machine driver

This patch enables support for GeminiLake with the DA7219 codec and
MAX98357A amplifier. To avoid duplicating code, the existing machine
driver for ApolloLake is reused with only changes in hardware
connectivity (SSP2 for DA7219 and SSP1 for MAX98357A).

The dailinks are directly modified in this patch. Using a helper would
be nicer, but it'll be done in a follow-up step with validation done
across multiple machine drivers.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 79 ++++++++++++++++---
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 30311b81a543..407b0cfc5167 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <asm/cpu_device_id.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -104,7 +105,7 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
 			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
 };
 
-static const struct snd_soc_dapm_route broxton_map[] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{"Headphone Jack", NULL, "HPL"},
 	{"Headphone Jack", NULL, "HPR"},
@@ -119,15 +120,6 @@ static const struct snd_soc_dapm_route broxton_map[] = {
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
@@ -147,6 +139,28 @@ static const struct snd_soc_dapm_route broxton_map[] = {
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
@@ -539,6 +553,11 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	},
 };
 
+static const struct x86_cpu_id glk_ids[] = {
+	{ X86_VENDOR_INTEL, 6, 0x7A }, /* Geminilake CPU_ID */
+	{}
+};
+
 #define NAME_SIZE	32
 static int bxt_card_late_probe(struct snd_soc_card *card)
 {
@@ -548,6 +567,13 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 	int err, i = 0;
 	char jack_name[NAME_SIZE];
 
+	if (x86_match_cpu(glk_ids))
+		snd_soc_dapm_add_routes(&card->dapm, gemini_map,
+					ARRAY_SIZE(gemini_map));
+	else
+		snd_soc_dapm_add_routes(&card->dapm, broxton_map,
+					ARRAY_SIZE(broxton_map));
+
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
@@ -583,8 +609,8 @@ static struct snd_soc_card broxton_audio_card = {
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
@@ -604,6 +630,26 @@ static int broxton_audio_probe(struct platform_device *pdev)
 
 	broxton_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
+	if (x86_match_cpu(glk_ids)) {
+		unsigned int i;
+
+		broxton_audio_card.name = "glkda7219max";
+		/* Fixup the SSP entries for geminilake */
+		for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
+			/* MAXIM_CODEC is connected to SSP1. */
+			if (!strcmp(broxton_dais[i].codec_dai_name,
+				    BXT_MAXIM_CODEC_DAI)) {
+				broxton_dais[i].name = "SSP1-Codec";
+				broxton_dais[i].cpu_dai_name = "SSP1 Pin";
+			}
+			/* DIALOG_CODE is connected to SSP2 */
+			else if (!strcmp(broxton_dais[i].codec_dai_name,
+					 BXT_DIALOG_CODEC_DAI)) {
+				broxton_dais[i].name = "SSP2-Codec";
+				broxton_dais[i].cpu_dai_name = "SSP2 Pin";
+			}
+		}
+	}
 
 	/* override plaform name, if required */
 	mach = (&pdev->dev)->platform_data;
@@ -617,12 +663,19 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &broxton_audio_card);
 }
 
+static const struct platform_device_id bxt_board_ids[] = {
+	{ .name = "bxt_da7219_max98357a" },
+	{ .name = "glk_da7219_max98357a" },
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
 
@@ -632,5 +685,7 @@ MODULE_AUTHOR("Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
+MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:bxt_da7219_max98357a");
+MODULE_ALIAS("platform:glk_da7219_max98357a");
-- 
2.20.1
