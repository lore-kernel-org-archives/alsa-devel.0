From: vedang.patel@intel.com
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Increase loglevel of
	debug messages.
Date: Tue, 12 Apr 2016 15:08:22 -0700
Message-ID: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D606265134
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 00:08:46 +0200 (CEST)
In-Reply-To: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
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
Cc: vinod.koul@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

There is log spam while doing playback, record or reloading the
audio firmware.

print_hex_dump uses printk(KERN_DEBUG,... which is different from
dev_dbg used elsewhere in the driver: it's always enabled at
compile-time. Add #ifdef DEBUG condition for logging consistency.

For consistency with other log statements, change dev_info to dev_dbg
for a kernel print which is frequently printed by the driver.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 ++
 sound/soc/intel/skylake/skl-sst-ipc.c  | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e3d149c..da2dbb2 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -730,8 +730,10 @@ static int skl_set_module_format(struct skl_sst *ctx,
 
 	dev_dbg(ctx->dev, "Module type=%d config size: %d bytes\n",
 			module_config->id.module_id, param_size);
+#ifdef DEBUG
 	print_hex_dump(KERN_DEBUG, "Module params:", DUMP_PREFIX_OFFSET, 8, 4,
 			*param_data, param_size, false);
+#endif
 	return 0;
 }
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 5434602..5ee1420 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -363,7 +363,7 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	/* first process the header */
 	switch (reply) {
 	case IPC_GLB_REPLY_SUCCESS:
-		dev_info(ipc->dev, "ipc FW reply %x: success\n", header.primary);
+		dev_dbg(ipc->dev, "ipc FW reply %x: success\n", header.primary);
 		/* copy the rx data from the mailbox */
 		sst_dsp_inbox_read(ipc->dsp, msg->rx_data, msg->rx_size);
 		break;
@@ -688,12 +688,15 @@ int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 	struct skl_ipc_header header = {0};
 	u64 *ipc_header = (u64 *)(&header);
 	int ret;
-	u32 *buffer = (u32 *)param_data;
 	 /* param_block_size must be in dwords */
 	u16 param_block_size = msg->param_data_size / sizeof(u32);
 
+#ifdef DEBUG
+	u32 *buffer = (u32 *)param_data;
+
 	print_hex_dump(KERN_DEBUG, NULL, DUMP_PREFIX_NONE,
 		16, 4, buffer, param_block_size, false);
+#endif
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
 	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
-- 
2.1.2
