From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add additional args to
	module parsing" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:16 +0100
Message-ID: <E1bUGgO-0006OA-Cx@debutante>
References: <1469536610-27606-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FE612660B4
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:23 +0200 (CEST)
In-Reply-To: <1469536610-27606-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add additional args to module parsing

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

>From 11aa041a775ea5b2ec866298df9656e9ebf67322 Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Tue, 26 Jul 2016 18:06:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: add additional args to module parsing

For additional library parsing, we need to pass firmware to be
loaded and not use the pointer in context. Also, Library module
IDs are combination of library index and module ID in manifest.

So add the additional arguments of firmware and library offset to
snd_skl_parse_uuids().

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c       | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h   | 3 ++-
 sound/soc/intel/skylake/skl-sst-utils.c | 9 +++++----
 sound/soc/intel/skylake/skl-sst.c       | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index eb68258b653d..d6bf32405b3b 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -175,7 +175,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	if (ctx->fw == NULL)
 		goto sst_load_base_firmware_failed;
 
-	ret = snd_skl_parse_uuids(ctx, BXT_ADSP_FW_BIN_HDR_OFFSET);
+	ret = snd_skl_parse_uuids(ctx, ctx->fw, BXT_ADSP_FW_BIN_HDR_OFFSET, 0);
 	if (ret < 0)
 		goto sst_load_base_firmware_failed;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 7e994688d8a0..5bc77e1941a5 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -210,7 +210,8 @@ void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx);
 
 int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
 		struct skl_dfw_module *dfw_config);
-int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset);
+int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
+		unsigned int offset, int index);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 25fcb796bd86..d94ff958d7e5 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -140,7 +140,8 @@ EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
  * Parse the firmware binary to get the UUID, module id
  * and loadable flags
  */
-int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
+int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
+			unsigned int offset, int index)
 {
 	struct adsp_fw_hdr *adsp_hdr;
 	struct adsp_module_entry *mod_entry;
@@ -153,8 +154,8 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
 	unsigned int safe_file;
 
 	/* Get the FW pointer to derive ADSP header */
-	stripped_fw.data = ctx->fw->data;
-	stripped_fw.size = ctx->fw->size;
+	stripped_fw.data = fw->data;
+	stripped_fw.size = fw->size;
 
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
@@ -205,7 +206,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
 		uuid_bin = (uuid_le *)mod_entry->uuid.id;
 		memcpy(&module->uuid, uuid_bin, sizeof(module->uuid));
 
-		module->id = i;
+		module->id = (i | (index << 12));
 		module->is_loadable = mod_entry->type.load_type;
 
 		list_add_tail(&module->list, &skl->uuid_list);
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 6de4c027a65b..6e9c634cf84f 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -88,7 +88,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		}
 	}
 
-	ret = snd_skl_parse_uuids(ctx, SKL_ADSP_FW_BIN_HDR_OFFSET);
+	ret = snd_skl_parse_uuids(ctx, ctx->fw, SKL_ADSP_FW_BIN_HDR_OFFSET, 0);
 	if (ret < 0) {
 		dev_err(ctx->dev,
 				"UUID parsing err: %d\n", ret);
-- 
2.8.1
