From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 04/11] ASoC: Intel: Skylake: Fix uuid_module
	memory leak in failure case
Date: Tue,  7 Nov 2017 16:16:19 +0530
Message-ID: <20171107104626.25800-5-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 384D32673A6
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:16 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

In the loop that adds the uuid_module to the uuid_list list, allocated
memory is not properly freed in the error path free uuid_list whenever
any of the memory allocation in the loop fails to avoid memory leak.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
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
2.14.2
