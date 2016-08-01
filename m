From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Check list empty while
	getting module info" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:30 +0100
Message-ID: <E1bUGgc-0006SX-WB@debutante>
References: <1469536610-27606-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CF6B266158
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:37 +0200 (CEST)
In-Reply-To: <1469536610-27606-2-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Check list empty while getting module info

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

>From 2392f7fd695246df4fb5f0b5fb88ce37cdb01764 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 26 Jul 2016 18:06:39 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Check list empty while getting module
 info

Module list can be NULL so check if the list is empty before
accessing the list.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 25fcb796bd86..ddcb52a51854 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -123,6 +123,11 @@ int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
 
 	uuid_mod = (uuid_le *)uuid;
 
+	if (list_empty(&ctx->uuid_list)) {
+		dev_err(ctx->dev, "Module list is empty\n");
+		return -EINVAL;
+	}
+
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 			dfw_config->module_id = module->id;
-- 
2.8.1
