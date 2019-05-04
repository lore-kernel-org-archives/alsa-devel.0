From: Nariman <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5645.c: Remove buffer and snprintf calls
Date: Sat,  4 May 2019 17:16:50 +0200
Message-ID: <20190504151652.5213-2-user@elitebook-localhost>
References: <20190504151652.5213-1-user@elitebook-localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504151652.5213-1-user@elitebook-localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, Damian van Soelen <dj.vsoelen@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Damian van Soelen <dj.vsoelen@gmail.com>

The snprintf calls filling cht_rt5645_cpu_dai_name / cht_rt5645_codec_aif_name
always fill them with the same string ("ssp0-port" resp "rt5645-aif2") so
instead of keeping these buffers around and making the cpu_dai_name /
codec_aif_name point to this, simply update the foo_dai_name and foo_aif_name pointers to
directly point to a string constant containing the desired string.

Signed-off-by: Damian van Soelen <dj.vsoelen@gmail.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 26 ++++---------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index cbc2d458483f..b15459e56665 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -506,8 +506,6 @@ static struct cht_acpi_card snd_soc_cards[] = {
 };
 
 static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
-static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
-static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static bool is_valleyview(void)
 {
@@ -641,28 +639,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup codec aif name */
-		snprintf(cht_rt5645_codec_aif_name,
-			sizeof(cht_rt5645_codec_aif_name),
-			"%s", "rt5645-aif2");
-
-		cht_dailink[dai_index].codec_dai_name =
-			cht_rt5645_codec_aif_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup cpu dai name name */
-		snprintf(cht_rt5645_cpu_dai_name,
-			sizeof(cht_rt5645_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		cht_dailink[dai_index].cpu_dai_name =
-			cht_rt5645_cpu_dai_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].cpu_dai_name = "ssp0-port";
 
 	/* override plaform name, if required */
 	platform_name = mach->mach_params.platform;
-- 
2.20.1
