From: Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: intel: byt: Introduce new custom IN2
	map" to the asoc tree
Date: Sat, 21 Oct 2017 11:13:31 +0100 (BST)
Message-ID: <20171021101331.4CA1D440057@finisterre.ee.mobilebroadband>
References: <20171018164957.2270-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0C1266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:13:34 +0200 (CEST)
In-Reply-To: <20171018164957.2270-1-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

The patch

   SoC: intel: byt: Introduce new custom IN2 map

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

>From 39712db878a499542651eb6c2f5ceec4eacc72d1 Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Wed, 18 Oct 2017 17:49:57 +0100
Subject: [PATCH] SoC: intel: byt: Introduce new custom IN2 map

Introduce a new custom dapm routes map to quirk platforms with the
internal mic connected to IN2P.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3076bfc0db5e..1dad5c98c9ef 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -37,6 +37,7 @@
 enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
+	BYT_RT5651_IN2_MAP,
 };
 
 #define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
@@ -58,6 +59,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk DMIC_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
 		dev_info(dev, "quirk IN1_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
+		dev_info(dev, "quirk IN2_MAP enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -143,7 +146,6 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"ssp2 Rx", NULL, "AIF1 Capture"},
 
 	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5651 */
-	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Speaker", NULL, "LOUTL"},
@@ -151,15 +153,23 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
 	{"DMIC L1", NULL, "Internal Mic"},
 	{"DMIC R1", NULL, "Internal Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
+	{"IN2P", NULL, "Headset Mic"},
 	{"IN1P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN2P", NULL, "Internal Mic"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -246,6 +256,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
+	case BYT_RT5651_IN2_MAP:
+		custom_map = byt_rt5651_intmic_in2_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
+		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
-- 
2.14.1
