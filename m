From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add IN2 input
	mapping" to the asoc tree
Date: Thu, 19 Jul 2018 17:57:03 +0100
Message-ID: <E1fgCEh-0005Pl-Ju@debutante>
References: <20180718205542.12364-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EF95267749
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:09 +0200 (CEST)
In-Reply-To: <20180718205542.12364-5-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Add IN2 input mapping

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

>From ac275ee5aa67abe9b65d66071ee333c6b0905b93 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Jul 2018 22:55:40 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add IN2 input mapping

During the recent cleanup series 3 of the 6 input mappings where removed
from the bytcr_rt5651 machine driver because testing showed that none of
them were used.

However some devices do actually have their internal mic on IN2 (and
only IN2, not IN1 and IN2), this did not show during previous tests
due to a bug in the userspace UCM input device switching code.

This commit re-adds the IN2 mapping for devices with the internal mic.
on IN2 and the headser mic on IN3 and enables this mapping on devices
with their internal mic on IN2.

This commit also changes the default internal mic input to IN2, because
all my 7 test devices have their mic there.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 53ac97c15fc6..d85530b1cc8e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -44,6 +44,7 @@
 enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
+	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
 };
 
@@ -93,9 +94,9 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
-/* Default: jack-detect on JD1_1, internal mic on in1, headsetmic on in3 */
+/* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP;
+					BYT_RT5651_IN2_MAP;
 
 static void log_quirks(struct device *dev)
 {
@@ -103,6 +104,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk DMIC_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
 		dev_info(dev, "quirk IN1_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
+		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_IN2_MAP)
 		dev_info(dev, "quirk IN1_IN2_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
@@ -270,6 +273,12 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN2P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
 	{"IN1P", NULL, "Internal Mic"},
@@ -364,7 +373,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_IN2_MAP |
 					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
@@ -375,7 +384,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_MAP |
+					BYT_RT5651_IN2_MAP |
 					BYT_RT5651_HP_LR_SWAPPED),
 	},
 	{
@@ -468,6 +477,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
+	case BYT_RT5651_IN2_MAP:
+		custom_map = byt_rt5651_intmic_in2_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
+		break;
 	case BYT_RT5651_IN1_IN2_MAP:
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
@@ -825,7 +838,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	const char * const mic_name[] = { "dmic", "in1", "in12" };
+	const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	struct device *codec_dev;
-- 
2.18.0
