From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix uninitialized
	return" to the asoc tree
Date: Wed, 23 Aug 2017 16:54:19 +0100
Message-ID: <E1dkXz1-0005Py-83@debutante>
References: <1503497232-21345-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5398B266B38
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 17:54:30 +0200 (CEST)
In-Reply-To: <1503497232-21345-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, kbuild test robot <fengguang.wu@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix uninitialized return

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

>From 9149916f1e8c912c585ddebf12a98e99bd81aafe Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Wed, 23 Aug 2017 19:37:12 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix uninitialized return

On failure to get dsp_ops, dsp_init returns error without assigning ret. ret
is assigned in code path which will never be executed. Fix it.

Fixes: f77d443c4c29 ("ASoC: Intel: Skylake: Fix to free resources for dsp_init failure"
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index f0f11f597b21..697d07bc1b5a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -278,8 +278,8 @@ int skl_init_dsp(struct skl *skl)
 
 	ops = skl_get_dsp_ops(skl->pci->device);
 	if (!ops) {
-		goto unmap_mmio;
 		ret = -EIO;
+		goto unmap_mmio;
 	}
 
 	loader_ops = ops->loader_ops();
-- 
2.14.1
