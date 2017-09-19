From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: simplify MCLK
	quirk tests" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:57 +0100
Message-ID: <E1duIqb-00089I-Ra@debutante>
References: <20170822203239.19891-12-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC532671DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:59 +0200 (CEST)
In-Reply-To: <20170822203239.19891-12-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests

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

>From 60f5cbae49abef438611a16ae60eff5906486b3f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 12:43:56 -0500
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: simplify MCLK quirk tests

remove redundant tests to check MCLK (align with other
machine drivers). some checks remain since when the MCLK is
disabled we fall back to using the bclk as PLL reference

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 15b1e292b0c3..7cee09d08ad7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -178,7 +178,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk) {
+		if (priv->mclk) {
 			ret = clk_prepare_enable(priv->mclk);
 			if (ret < 0) {
 				dev_err(card->dev,
@@ -199,7 +199,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
-			if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk)
+			if (priv->mclk)
 				clk_disable_unprepare(priv->mclk);
 		}
 	}
@@ -549,7 +549,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
-	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk) {
+	if (priv->mclk) {
 		/*
 		 * The firmware might enable the clock at
 		 * boot (this information may or may not
-- 
2.14.1
