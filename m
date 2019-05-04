From: Nariman <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if statement and removed buffer
Date: Sat,  4 May 2019 17:16:49 +0200
Message-ID: <20190504151652.5213-1-user@elitebook-localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, Nariman Etemadi <narimantos@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Nariman Etemadi <narimantos@gmail.com>

in function snd_byt_rt5640_mc_probe and removed buffer yt_rt5640_codec_aif_name & byt_rt5640_cpu_dai_name

Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 940eb27158da..0d91642ca287 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1075,8 +1075,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 
 /* SoC card */
 static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
-static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
-static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
 
 static int byt_rt5640_suspend(struct snd_soc_card *card)
@@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
-		/* fixup codec aif name */
-		snprintf(byt_rt5640_codec_aif_name,
-			sizeof(byt_rt5640_codec_aif_name),
-			"%s", "rt5640-aif2");
-
-		byt_rt5640_dais[dai_index].codec_dai_name =
-			byt_rt5640_codec_aif_name;
-	}
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
+		byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
-	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
-		/* fixup cpu dai name name */
-		snprintf(byt_rt5640_cpu_dai_name,
-			sizeof(byt_rt5640_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		byt_rt5640_dais[dai_index].cpu_dai_name =
-			byt_rt5640_cpu_dai_name;
-	}
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
+		byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
 
 	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-- 
2.20.1
