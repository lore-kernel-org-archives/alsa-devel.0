From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/12] ASoC: Intel: Skylake: add additional
	args to module parsing
Date: Tue, 26 Jul 2016 18:06:44 +0530
Message-ID: <1469536610-27606-7-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 66EE32669C4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:30:17 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

For additional library parsing, we need to pass firmware to be
loaded and not use the pointer in context. Also, Library module
IDs are combination of library index and module ID in manifest.

So add the additional arguments of firmware and library offset to
snd_skl_parse_uuids().

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
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
index ddcb52a51854..fe36e0cf391c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -145,7 +145,8 @@ EXPORT_SYMBOL_GPL(snd_skl_get_module_info);
  * Parse the firmware binary to get the UUID, module id
  * and loadable flags
  */
-int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
+int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
+			unsigned int offset, int index)
 {
 	struct adsp_fw_hdr *adsp_hdr;
 	struct adsp_module_entry *mod_entry;
@@ -158,8 +159,8 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
 	unsigned int safe_file;
 
 	/* Get the FW pointer to derive ADSP header */
-	stripped_fw.data = ctx->fw->data;
-	stripped_fw.size = ctx->fw->size;
+	stripped_fw.data = fw->data;
+	stripped_fw.size = fw->size;
 
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
@@ -210,7 +211,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset)
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
1.9.1
