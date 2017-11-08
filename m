From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix uuid_module memory
	leak in failure case" to the asoc tree
Date: Wed, 08 Nov 2017 21:33:21 +0000
Message-ID: <E1eCXyL-0005YD-JM@debutante>
References: <20171107104626.25800-5-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA08D2676C4
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:36:54 +0100 (CET)
In-Reply-To: <20171107104626.25800-5-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix uuid_module memory leak in failure case

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

>From f8e066521192c7debe59127d90abbe2773577e25 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Tue, 7 Nov 2017 16:16:19 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix uuid_module memory leak in failure
 case

In the loop that adds the uuid_module to the uuid_list list, allocated
memory is not properly freed in the error path free uuid_list whenever
any of the memory allocation in the loop fails to avoid memory leak.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 369ef7ce981c..8ff89280d9fd 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -251,6 +251,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 	struct uuid_module *module;
 	struct firmware stripped_fw;
 	unsigned int safe_file;
+	int ret = 0;
 
 	/* Get the FW pointer to derive ADSP header */
 	stripped_fw.data = fw->data;
@@ -299,8 +300,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 
 	for (i = 0; i < num_entry; i++, mod_entry++) {
 		module = kzalloc(sizeof(*module), GFP_KERNEL);
-		if (!module)
-			return -ENOMEM;
+		if (!module) {
+			ret = -ENOMEM;
+			goto free_uuid_list;
+		}
 
 		uuid_bin = (uuid_le *)mod_entry->uuid.id;
 		memcpy(&module->uuid, uuid_bin, sizeof(module->uuid));
@@ -311,8 +314,8 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		size = sizeof(int) * mod_entry->instance_max_count;
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
-			kfree(module);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto free_uuid_list;
 		}
 
 		list_add_tail(&module->list, &skl->uuid_list);
@@ -323,6 +326,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 	}
 
 	return 0;
+
+free_uuid_list:
+	skl_freeup_uuid_list(skl);
+	return ret;
 }
 
 void skl_freeup_uuid_list(struct skl_sst *ctx)
-- 
2.15.0
