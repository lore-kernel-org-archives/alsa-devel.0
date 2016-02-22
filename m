From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove bogus comparison
	of an array with NULL" to the asoc tree
Date: Mon, 22 Feb 2016 13:58:06 +0900
Message-ID: <E1aXiZS-0000n9-TP@finisterre>
References: <1455862354-6455-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D71312606C3
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 05:58:27 +0100 (CET)
In-Reply-To: <1455862354-6455-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: remove bogus comparison of an array with NULL

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

>From edd7ea2d5486c12978fdc71c6efd493cbabeea60 Mon Sep 17 00:00:00 2001
From: Alan Cox <alan@linux.intel.com>
Date: Mon, 22 Feb 2016 09:37:27 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove bogus comparison of an array
 with NULL

dfw_ac->params is an array not a pointer. It will never be NULL. The check
on ac->max appears sufficient.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ba0d02d..c95bbce 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1657,8 +1657,7 @@ static int skl_init_algo_data(struct device *dev, struct soc_bytes_ext *be,
 		if (!ac->params)
 			return -ENOMEM;
 
-		if (dfw_ac->params)
-			memcpy(ac->params, dfw_ac->params, ac->max);
+		memcpy(ac->params, dfw_ac->params, ac->max);
 	}
 
 	be->dobj.private  = ac;
-- 
2.7.0
