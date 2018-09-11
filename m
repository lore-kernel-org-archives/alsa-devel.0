From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: skl-topology: Use kmemdup to replace
	kzalloc + memcpy" to the asoc tree
Date: Tue, 11 Sep 2018 12:13:04 +0100 (BST)
Message-ID: <20180911111304.909341121AF8@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC8B6267795
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2018 13:13:06 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: skl-topology: Use kmemdup to replace kzalloc + memcpy

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

>From ca92cc4636fdedf0d7ee88a5e50cd2b85c246a3b Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Sat, 8 Sep 2018 16:36:20 +0800
Subject: [PATCH] ASoC: skl-topology: Use kmemdup to replace kzalloc + memcpy

kmemdup has implemented the function that kzalloc() + memcpy() will
do. and we prefer to kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2620d77729c5..52a9915da0f5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -898,11 +898,10 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
 			if (bc->set_params == SKL_PARAM_BIND) {
-				params = kzalloc(bc->max, GFP_KERNEL);
+				params = kmemdup(bc->params, bc->max, GFP_KERNEL);
 				if (!params)
 					return -ENOMEM;
 
-				memcpy(params, bc->params, bc->max);
 				skl_fill_sink_instance_id(ctx, params, bc->max,
 								mconfig);
 
-- 
2.19.0.rc2
