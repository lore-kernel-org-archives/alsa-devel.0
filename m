From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytct_rt5640: change default
	capture settings" to the asoc tree
Date: Sun, 13 Nov 2016 09:26:32 +0000
Message-ID: <E1c5r3Y-0006ay-QL@finisterre>
References: <1478995666-3866-4-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F40E82667C9
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 10:26:52 +0100 (CET)
In-Reply-To: <1478995666-3866-4-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: bytct_rt5640: change default capture settings

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

>From bf46241bee7bc3ec28703796f4fbd56085055fca Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sat, 12 Nov 2016 18:07:46 -0600
Subject: [PATCH] ASoC: Intel: bytct_rt5640: change default capture settings

Most Baytrail-CR devices use analog differential microphones,
modify capture default to avoid DMI quirks. Keep digital mics
for all other configurations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 32aeffc352ee..f9d73b55d2f7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -57,9 +57,7 @@ struct byt_rt5640_private {
 	struct clk *mclk;
 };
 
-static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
-					BYT_RT5640_DMIC_EN |
-					BYT_RT5640_MCLK_EN;
+static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 
 static void log_quirks(struct device *dev)
 {
@@ -787,6 +785,13 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			/* no BIOS indications, assume SSP0-AIF2 connection */
 			byt_rt5640_quirk |= BYT_RT5640_SSP0_AIF2;
 		}
+
+		/* change defaults for Baytrail-CR capture */
+		byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
+	} else {
+		byt_rt5640_quirk |= (BYT_RT5640_DMIC1_MAP |
+				BYT_RT5640_DMIC_EN);
 	}
 
 	/* check quirks before creating card */
-- 
2.10.2
