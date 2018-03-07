From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Rename IN3_MAP to
	IN1_HS_IN3_MAP" to the asoc tree
Date: Wed, 07 Mar 2018 14:22:03 +0000
Message-ID: <E1etZxD-0002ke-1y@debutante>
References: <20180225104713.4745-28-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A46526742C
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:10 +0100 (CET)
In-Reply-To: <20180225104713.4745-28-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Rename IN3_MAP to IN1_HS_IN3_MAP

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

>From 7f2e2299cf169d8c517fbe2bcff3ca7bc8fa5f5c Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:05 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Rename IN3_MAP to IN1_HS_IN3_MAP

All the mappings are named for where the internal mic is routed and in that
sense the newly added in3_map really is the same as in1_map, what makes it
different is that it maps the headset mic at IN3 rather then at IN2.

Rename in3_map to in1_hs_in3_map to better reflect what it actually does.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 1c771930772d..7d5764d23c51 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -41,7 +41,7 @@ enum {
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
-	BYT_RT5651_IN3_MAP,
+	BYT_RT5651_IN1_HS_IN3_MAP,
 };
 
 enum {
@@ -91,8 +91,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN1_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
 		dev_info(dev, "quirk IN2_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
-		dev_info(dev, "quirk IN3_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_HS_IN3_MAP)
+		dev_info(dev, "quirk IN1_HS_IN3_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -235,8 +235,8 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
-	{"IN2P", NULL, "Headset Mic"},
 	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
@@ -252,10 +252,10 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_in3_map[] = {
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_hs_in3_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
-	{"IN3P", NULL, "Headset Mic"},
 	{"IN1P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
 };
 
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
@@ -300,7 +300,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN3_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -309,7 +309,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_IN3_MAP),
+					BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -382,9 +382,9 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
 		break;
-	case BYT_RT5651_IN3_MAP:
-		custom_map = byt_rt5651_intmic_in3_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in3_map);
+	case BYT_RT5651_IN1_HS_IN3_MAP:
+		custom_map = byt_rt5651_intmic_in1_hs_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_hs_in3_map);
 		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
-- 
2.16.2
