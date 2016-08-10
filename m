From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove module id query
	at runtime" to the asoc tree
Date: Wed, 10 Aug 2016 21:04:01 +0100
Message-ID: <E1bXZjN-0000Sx-Ef@debutante>
References: <1470802250-9232-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 002BF26691F
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 22:04:08 +0200 (CEST)
In-Reply-To: <1470802250-9232-4-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: remove module id query at runtime

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

>From a657ae7e5c0c9fd8858e5498e6de65c222d206d1 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 10 Aug 2016 09:40:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove module id query at runtime

Now that we have balanced loading of the topology file and split of init
and fw_init and fill module data during asoc probe.

So remove it from runtime, but keep error check in case things fall apart.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c09e2c7608a3..4bc8f9c269db 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -475,12 +475,10 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 
 		/* check if module ids are populated */
 		if (mconfig->id.module_id < 0) {
-			ret = snd_skl_get_module_info(skl->skl_sst, mconfig);
-			if (ret < 0) {
-				dev_err(skl->skl_sst->dev,
-					"query module info failed: %d\n", ret);
-				return ret;
-			}
+			dev_err(skl->skl_sst->dev,
+					"module %pUL id not populated\n",
+					(uuid_le *)mconfig->guid);
+			return -EIO;
 		}
 
 		/* check resource available */
-- 
2.8.1
