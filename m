From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: don't use codec
	anymore" to the asoc tree
Date: Wed, 28 Mar 2018 03:20:41 +0100 (BST)
Message-ID: <20180328022041.BD9F244007A@finisterre.ee.mobilebroadband>
References: <87zi2t3rap.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C3C1267194
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 04:20:46 +0200 (CEST)
In-Reply-To: <87zi2t3rap.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: don't use codec anymore

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

>From 2759ba9bf811f81c31d14e32f8cff022d54dce1f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 01:49:36 +0000
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: don't use codec anymore

commit aeec6cc08215 ("ASoC: Intel: bytcr_rt5651: Configure PLL1 before
using it") is using codec->dev, but codec is replaced to component.
Let's use component

Fixes: aeec6cc08215 ("ASoC: Intel: bytcr_rt5651: Configure PLL1 before using it")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 53ce313024f1..1b1997f1d60c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -147,14 +147,14 @@ static int byt_rt5651_prepare_and_enable_pll1(struct snd_soc_dai *codec_dai,
 	}
 	ret = snd_soc_dai_set_pll(codec_dai, 0, clk_id, clk_freq, rate * 512);
 	if (ret < 0) {
-		dev_err(codec_dai->codec->dev, "can't set pll: %d\n", ret);
+		dev_err(codec_dai->component->dev, "can't set pll: %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
 				     rate * 512, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(codec_dai->codec->dev, "can't set clock %d\n", ret);
+		dev_err(codec_dai->component->dev, "can't set clock %d\n", ret);
 		return ret;
 	}
 
-- 
2.16.2
