From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Subject: [PATCH v2 3/3] ASoC: Intel: board: Add Geminilake
	platform support
Date: Thu, 20 Jul 2017 11:40:57 +0530
Message-ID: <1500531057-4286-4-git-send-email-pradeep.d.tewani@intel.com>
References: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ADD962673B5
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 08:13:10 +0200 (CEST)
In-Reply-To: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Pradeep Tewani <pradeep.d.tewani@intel.com>
List-Id: alsa-devel@alsa-project.org

Geminilake also features rt298 codec, so use the same machine driver
as Broxton. Geminilake uses SSP2 instead of SSP5.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 84 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 1daf98e..a4b5bcb 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -114,7 +114,44 @@ static const struct snd_soc_dapm_route broxton_rt298_map[] = {
 	{ "iDisp2 Tx", NULL, "iDisp2_out"},
 	{ "hifi1", NULL, "iDisp1 Tx"},
 	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+};
+
+static const struct snd_soc_dapm_route geminilake_rt298_map[] = {
+	/* speaker */
+	{"Speaker", NULL, "SPOR"},
+	{"Speaker", NULL, "SPOL"},
+
+	/* HP jack connectors - unknown if we have jack detect */
+	{"Headphone Jack", NULL, "HPO Pin"},
+
+	/* other jacks */
+	{"MIC1", NULL, "Mic Jack"},
+
+	/* digital mics */
+	{"DMIC1 Pin", NULL, "DMIC2"},
+	{"DMic", NULL, "SoC DMIC"},
+
+	{"HDMI1", NULL, "hif5-0 Output"},
+	{"HDMI2", NULL, "hif6-0 Output"},
+	{"HDMI2", NULL, "hif7-0 Output"},
+
+	/* CODEC BE connections */
+	{ "AIF1 Playback", NULL, "ssp2 Tx"},
+	{ "ssp2 Tx", NULL, "codec0_out"},
+	{ "ssp2 Tx", NULL, "codec1_out"},
+
+	{ "codec0_in", NULL, "ssp2 Rx" },
+	{ "ssp2 Rx", NULL, "AIF1 Capture" },
 
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "DMIC01 Rx", NULL, "Capture" },
+
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
 };
 
 static int broxton_rt298_fe_init(struct snd_soc_pcm_runtime *rtd)
@@ -505,9 +542,41 @@ static struct snd_soc_card broxton_rt298 = {
 
 };
 
+static struct snd_soc_card geminilake_rt298 = {
+	.name = "geminilake-rt298",
+	.dai_link = broxton_rt298_dais,
+	.num_links = ARRAY_SIZE(broxton_rt298_dais),
+	.controls = broxton_controls,
+	.num_controls = ARRAY_SIZE(broxton_controls),
+	.dapm_widgets = broxton_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
+	.dapm_routes = geminilake_rt298_map,
+	.num_dapm_routes = ARRAY_SIZE(geminilake_rt298_map),
+	.fully_routed = true,
+	.late_probe = bxt_card_late_probe,
+};
+
 static int broxton_audio_probe(struct platform_device *pdev)
 {
 	struct bxt_rt286_private *ctx;
+	struct snd_soc_card *card =
+			(struct snd_soc_card *)pdev->id_entry->driver_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(broxton_rt298_dais); i++) {
+		if (!strncmp(card->dai_link[i].codec_name, "i2c-INT343A:00",
+						I2C_NAME_SIZE)) {
+			if (!strncmp(card->name, "broxton-rt298",
+						PLATFORM_NAME_SIZE)) {
+				card->dai_link[i].name = "SSP5-Codec";
+				card->dai_link[i].cpu_dai_name = "SSP5 Pin";
+			} else if (!strncmp(card->name, "geminilake-rt298",
+						PLATFORM_NAME_SIZE)) {
+				card->dai_link[i].name = "SSP2-Codec";
+				card->dai_link[i].cpu_dai_name = "SSP2 Pin";
+			}
+		}
+	}
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -515,18 +584,26 @@ static int broxton_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	broxton_rt298.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&broxton_rt298, ctx);
+	card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(card, ctx);
 
-	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
+static const struct platform_device_id bxt_board_ids[] = {
+	{ .name = "bxt_alc298s_i2s", .driver_data =
+				(unsigned long)&broxton_rt298 },
+	{ .name = "glk_alc298s_i2s", .driver_data =
+				(unsigned long)&geminilake_rt298 },
+};
+
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
 		.name = "bxt_alc298s_i2s",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = bxt_board_ids,
 };
 module_platform_driver(broxton_audio)
 
@@ -536,3 +613,4 @@ MODULE_AUTHOR("Senthilnathan Veppur <senthilnathanx.veppur@intel.com>");
 MODULE_DESCRIPTION("Intel SST Audio for Broxton");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:bxt_alc298s_i2s");
+MODULE_ALIAS("platform:glk_alc298s_i2s");
-- 
2.7.4
