From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Use MCLK instead of BLCK as the
	sysclock for RT5514 codec on kabylake platform" to the asoc tree
Date: Fri, 28 Jul 2017 13:43:49 +0100
Message-ID: <E1db4cP-0005hc-CX@finisterre>
References: <1501102065-11083-3-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0378A267685
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 14:43:58 +0200 (CEST)
In-Reply-To: <1501102065-11083-3-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Use MCLK instead of BLCK as the sysclock for RT5514 codec on kabylake platform

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

>From 6512dd4dcf640412637ece8a412e83c3a0046d2f Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Thu, 27 Jul 2017 17:41:26 -0700
Subject: [PATCH] ASoC: Intel: Use MCLK instead of BLCK as the sysclock for
 RT5514 codec on kabylake platform

This patch fixes the pop noise in dmic recording using rt5514 on kabylake platform.
This patch enables the rt5514 to use MCLK instead of BLCK as the sysclock which fixes
the pop noise.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index cfde894d250f..cfd89ca6a18d 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -351,19 +351,10 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 			}
 
-			ret = snd_soc_dai_set_pll(codec_dai, 0,
-				RT5514_PLL1_S_BCLK, RT5514_AIF1_BCLK_FREQ,
-						RT5514_AIF1_SYSCLK_FREQ);
-			if (ret < 0) {
-				dev_err(rtd->dev, "set bclk err: %d\n", ret);
-				return ret;
-			}
-
 			ret = snd_soc_dai_set_sysclk(codec_dai,
-				RT5514_SCLK_S_PLL1, RT5514_AIF1_SYSCLK_FREQ,
-							SND_SOC_CLOCK_IN);
+				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set sclk err: %d\n", ret);
+				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
 				return ret;
 			}
 		}
-- 
2.13.2
