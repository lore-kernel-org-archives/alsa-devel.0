From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5651: fix capture
	routes" to the asoc tree
Date: Tue, 19 Sep 2017 14:46:00 +0100
Message-ID: <E1duIqe-0008A7-Rl@debutante>
References: <20170822203239.19891-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A63F92673C5
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:46:02 +0200 (CEST)
In-Reply-To: <20170822203239.19891-8-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr-rt5651: fix capture routes

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

>From 6356c78c682f3f0614b82bb27c7a5d33c7b0d8be Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 12:43:53 -0500
Subject: [PATCH] ASoC: Intel: bytcr-rt5651: fix capture routes

There is only one dmic path and the routes were not added.
Probably a copy-paste mistake when initially creating the
file

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 4a3516b38c2c..441f735a198f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -54,12 +54,9 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"Speaker", NULL, "LOUTR"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] = {
-	{"DMIC1", NULL, "Internal Mic"},
-};
-
-static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic2_map[] = {
-	{"DMIC2", NULL, "Internal Mic"},
+static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
+	{"DMIC L1", NULL, "Internal Mic"},
+	{"DMIC R1", NULL, "Internal Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
@@ -133,14 +130,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
-	case BYT_RT5651_DMIC2_MAP:
-		custom_map = byt_rt5651_intmic_dmic2_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic2_map);
-		break;
 	default:
-		custom_map = byt_rt5651_intmic_dmic1_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic1_map);
+		custom_map = byt_rt5651_intmic_dmic_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
 	}
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
 
 	ret = snd_soc_add_card_controls(card, byt_rt5651_controls,
 					ARRAY_SIZE(byt_rt5651_controls));
-- 
2.14.1
