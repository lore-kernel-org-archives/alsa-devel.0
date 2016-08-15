From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: add IN3 map" to
	the asoc tree
Date: Mon, 15 Aug 2016 15:15:45 +0100
Message-ID: <E1bZIg5-0007JE-C3@debutante>
References: <1471037280-17433-12-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F16F226786B
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:15:52 +0200 (CEST)
In-Reply-To: <1471037280-17433-12-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: add IN3 map

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

>From 59e8b6520c6e2e867b35bc402d9a3f28aef3b2bc Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:54 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: add IN3 map

Some platforms have the analog mic connected to IN3,
add route accordingly

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index c4a3c5778b38..9b9d380d1cbb 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -39,6 +39,7 @@ enum {
 	BYT_RT5640_DMIC1_MAP,
 	BYT_RT5640_DMIC2_MAP,
 	BYT_RT5640_IN1_MAP,
+	BYT_RT5640_IN3_MAP,
 };
 
 #define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
@@ -79,6 +80,11 @@ static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
 	{"IN1P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5640_intmic_in3_map[] = {
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN3P", NULL, "Internal Mic"},
+};
+
 static const struct snd_soc_dapm_route byt_rt5640_ssp2_aif1_map[] = {
 	{"ssp2 Tx", NULL, "codec_out0"},
 	{"ssp2 Tx", NULL, "codec_out1"},
@@ -243,6 +249,10 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5640_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in1_map);
 		break;
+	case BYT_RT5640_IN3_MAP:
+		custom_map = byt_rt5640_intmic_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5640_intmic_in3_map);
+		break;
 	case BYT_RT5640_DMIC2_MAP:
 		custom_map = byt_rt5640_intmic_dmic2_map;
 		num_routes = ARRAY_SIZE(byt_rt5640_intmic_dmic2_map);
-- 
2.8.1
