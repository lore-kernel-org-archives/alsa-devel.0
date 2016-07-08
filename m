From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht: fix uninit variable
	warning" to the asoc tree
Date: Fri, 08 Jul 2016 16:37:25 +0200
Message-ID: <E1bLWuD-0008TZ-1r@finisterre>
References: <1467982818-4528-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0569265B65
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 16:37:52 +0200 (CEST)
In-Reply-To: <1467982818-4528-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht: fix uninit variable warning

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

>From 5d554ea4f287665b839975ecb11bd29d49a5c9b5 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 8 Jul 2016 18:30:17 +0530
Subject: [PATCH] ASoC: Intel: cht: fix uninit variable warning

Kbuild bot reports that we might use dai_index uninitialized.

sound/soc/intel/boards/cht_bsw_rt5645.c:391:37: warning: 'dai_index' may be used uninitialized in this function [-Wmaybe-uninitialized]

Since it is theoretically possible, set it while initializing.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index f26c7b8545ae..56056ed7fcfd 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -357,7 +357,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	char codec_name[16];
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
-	int dai_index;
+	int dai_index = 0;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
-- 
2.8.1
