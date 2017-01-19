From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Remove ignore_suspend
	for WoV streams" to the asoc tree
Date: Thu, 19 Jan 2017 18:03:44 +0000
Message-ID: <E1cUH3o-0004v3-68@debutante>
References: <1484198285-16805-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC53B2678E4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 19:03:59 +0100 (CET)
In-Reply-To: <1484198285-16805-1-git-send-email-yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@kernel.org, chintan.m.patel@intel.com, sathyanarayana.nujella@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: Remove ignore_suspend for WoV streams

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

>From 079a248b0e4c24432dc4838cad333b2e759813e0 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Wed, 11 Jan 2017 21:18:05 -0800
Subject: [PATCH] ASoC: Intel: boards: Remove ignore_suspend for WoV streams

When Ref capture is used during S0IX, only the DSP pipelines
are needed, thus remove the ignore_suspend for WoV streams so
that DMA can be suspended, but keep them for WoV endpoints.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 1b4330cd2739..02439ace3519 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -357,7 +357,6 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.platform_name = "0000:00:0e.0",
 		.init = NULL,
 		.dpcm_capture = 1,
-		.ignore_suspend = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
 		.ops = &broxton_refcap_ops,
-- 
2.11.0
