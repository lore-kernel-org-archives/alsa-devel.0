From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove autosuspend
	delay" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:09 +0000
Message-ID: <E1aRIpV-0001Al-1B@debutante>
References: <1454502594-21700-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 012362617BB
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:17 +0100 (CET)
In-Reply-To: <1454502594-21700-12-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove autosuspend delay

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

>From 38c079e230f25969e7ce3501fa967b003a2abc39 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 3 Feb 2016 17:59:54 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove autosuspend delay

The driver used autosuspend delay to delay going to D3. But per
HW recommendation we should go to D3 soon, so remove the delay
from driver

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index c38bf99ced10..1d36b28d6489 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -558,8 +558,6 @@ static int skl_probe(struct pci_dev *pci,
 		goto out_unregister;
 
 	/*configure PM */
-	pm_runtime_set_autosuspend_delay(bus->dev, SKL_SUSPEND_DELAY);
-	pm_runtime_use_autosuspend(bus->dev);
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
 
-- 
2.7.0.rc3
