From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5651: add quirk for IN3P
	which may also be used" to the asoc tree
Date: Mon, 08 Jan 2018 16:23:05 +0000
Message-ID: <E1eYaCX-0002Dt-Aj@debutante>
References: <20180105192023.11229-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1937726759B
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 17:23:11 +0100 (CET)
In-Reply-To: <20180105192023.11229-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr-rt5651: add quirk for IN3P which may also be used

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

>From 60e3b52e9354550c28090237b083b20bbabed598 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 5 Jan 2018 13:20:18 -0600
Subject: [PATCH] ASoC: Intel: bytcr-rt5651: add quirk for IN3P which may also
 be used

On Minnowboard Max with Realtek rt5651 eval board, the IN3P is
connected to Headset Mic.

Here add and select it for Minnowboard Max.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index de064f0f7b08..a958ed37569f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -39,6 +39,7 @@ enum {
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
+	BYT_RT5651_IN3_MAP,
 };
 
 #define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
@@ -63,6 +64,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN1_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
 		dev_info(dev, "quirk IN2_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
+		dev_info(dev, "quirk IN3_MAP enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -179,6 +182,12 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in3_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN3P", NULL, "Headset Mic"},
+	{"IN1P", NULL, "Internal Mic"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -255,8 +264,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_DMIC_MAP |
-					BYT_RT5651_DMIC_EN),
+		.driver_data = (void *)(BYT_RT5651_IN3_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -294,6 +302,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
 		break;
+	case BYT_RT5651_IN3_MAP:
+		custom_map = byt_rt5651_intmic_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in3_map);
+		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
-- 
2.15.1
