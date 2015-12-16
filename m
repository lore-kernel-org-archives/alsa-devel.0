From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: pointer math issue" to
	the asoc tree
Date: Wed, 16 Dec 2015 19:24:22 +0000
Message-ID: <E1a9HgU-0006Q1-IS@debutante>
References: <20151208055321.GA5597@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECA642657F9
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 20:24:32 +0100 (CET)
In-Reply-To: <20151208055321.GA5597@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Vinod Koul <vinod.koul@intel.com>, Dharageswari R <dharageswari.r@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: pointer math issue

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

>From e8bc3c99fa982f616e74aec4445945400a9c56f3 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 8 Dec 2015 08:53:22 +0300
Subject: [PATCH] ASoC: Intel: Skylake: pointer math issue

"data" is a u32 pointer so this copies the information to wrong place
entirely.

Fixes: 140adfba5280 ('ASoC: Intel: Skylake: Add tlv byte kcontrols')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b824450edcb4..34f2f7351f66 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -919,9 +919,9 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
 	if (bc->params) {
 		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
 			return -EFAULT;
-		if (copy_to_user(data + sizeof(u32), &size, sizeof(u32)))
+		if (copy_to_user(data + 1, &size, sizeof(u32)))
 			return -EFAULT;
-		if (copy_to_user(data + 2 * sizeof(u32), bc->params, size))
+		if (copy_to_user(data + 2, bc->params, size))
 			return -EFAULT;
 	}
 
-- 
2.6.2
