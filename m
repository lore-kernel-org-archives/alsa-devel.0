From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: change quirk
	position" to the asoc tree
Date: Sat, 05 Mar 2016 21:25:02 +0900
Message-ID: <E1acBGY-0003JU-1m@finisterre>
References: <1457062599-10032-6-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5FE260831
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:25:05 +0100 (CET)
In-Reply-To: <1457062599-10032-6-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: change quirk position

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ab738e4e3040b0985ab45780a688705f334e609b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 3 Mar 2016 21:36:37 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: change quirk position

No added functionality

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 9a1752df45a9..a06cd1f99190 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -32,6 +32,18 @@
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-acpi.h"
 
+enum {
+	BYT_RT5640_DMIC1_MAP,
+	BYT_RT5640_DMIC2_MAP,
+	BYT_RT5640_IN1_MAP,
+};
+
+#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5640_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_DMIC_EN;
+
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
@@ -70,18 +82,6 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
-enum {
-	BYT_RT5640_DMIC1_MAP,
-	BYT_RT5640_DMIC2_MAP,
-	BYT_RT5640_IN1_MAP,
-};
-
-#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
-#define BYT_RT5640_DMIC_EN	BIT(16)
-
-static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
-					BYT_RT5640_DMIC_EN;
-
 static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -174,7 +174,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	dmi_check_system(byt_rt5640_quirk_table);
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_IN1_MAP:
 		custom_map = byt_rt5640_intmic_in1_map;
@@ -351,6 +350,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		 "%s%s%s", "i2c-", mach->id, ":00");
 	byt_rt5640_dais[MERR_DPCM_COMPR+1].codec_name = byt_rt5640_codec_name;
 
+	/* check quirks before creating card */
+	dmi_check_system(byt_rt5640_quirk_table);
+
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
 	if (ret_val) {
-- 
2.7.0
