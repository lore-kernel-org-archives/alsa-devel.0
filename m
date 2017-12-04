From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix descriptions for
	exported function args" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:13 +0000
Message-ID: <E1eLvnl-0000PP-Nd@debutante>
References: <20171204050012.21498-2-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E0390267602
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:18 +0100 (CET)
In-Reply-To: <20171204050012.21498-2-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix descriptions for exported function args

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

>From 446c4724cc7174429ce381e5948e58da07274944 Mon Sep 17 00:00:00 2001
From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Date: Mon, 4 Dec 2017 10:30:12 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix descriptions for exported function
 args

Fix a few incorrect descriptions for arguments in exported functions.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 369ef7ce981c..746df24bfd82 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -178,7 +178,8 @@ static inline int skl_pvtid_128(struct uuid_module *module)
  * skl_get_pvt_id: generate a private id for use as module id
  *
  * @ctx: driver context
- * @mconfig: module configuration data
+ * @uuid_mod: module's uuid
+ * @instance_id: module's instance id
  *
  * This generates a 128 bit private unique id for a module TYPE so that
  * module instance is unique
@@ -208,7 +209,8 @@ EXPORT_SYMBOL_GPL(skl_get_pvt_id);
  * skl_put_pvt_id: free up the private id allocated
  *
  * @ctx: driver context
- * @mconfig: module configuration data
+ * @uuid_mod: module's uuid
+ * @pvt_id: module pvt id
  *
  * This frees a 128 bit private unique id previously generated
  */
-- 
2.15.0
