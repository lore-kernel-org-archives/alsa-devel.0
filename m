From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix to cleanup if
	skl_sst_dsp_init fails" to the asoc tree
Date: Mon, 02 Nov 2015 10:39:44 +0000
Message-ID: <E1ZtCWe-0006Dq-G4@finisterre>
References: <1446217461-2106-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E27AC2608B4
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:39:55 +0100 (CET)
In-Reply-To: <1446217461-2106-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix to cleanup if skl_sst_dsp_init fails

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

>From 44b69590a64f1f2694fd0dd38cd3efbe751f9a8a Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Fri, 30 Oct 2015 20:34:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix to cleanup if skl_sst_dsp_init
 fails

This patch fixes the below warning reported by Dan by invoking
skl_sst_dsp_cleanup() in cleanup path on error and not bailing out

	sound/soc/intel/skylake/skl-sst.c:270 skl_sst_dsp_init()
	info: ignoring unreachable code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 3b83dc9..5c5a244 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -259,15 +259,16 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 	ret = sst->fw_ops.load_fw(sst);
 	if (ret < 0) {
 		dev_err(dev, "Load base fw failed : %d", ret);
-		return ret;
+		goto cleanup;
 	}
 
 	if (dsp)
 		*dsp = skl;
 
-	return 0;
+	return ret;
 
-	skl_ipc_free(&skl->ipc);
+cleanup:
+	skl_sst_dsp_cleanup(dev, skl);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
-- 
2.6.1
