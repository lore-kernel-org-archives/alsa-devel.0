From: vedang.patel@intel.com
Subject: [PATCH v2 3/3] ASoC: Intel: Skylake: Increase loglevel
	of debug messages.
Date: Tue, 26 Apr 2016 16:03:10 -0700
Message-ID: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
 <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A9EFC265A72
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 01:03:24 +0200 (CEST)
In-Reply-To: <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
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
compile-time. Change it to print_hex_dump_debug for logging consistency.

For consistency with other log statements, change dev_info to dev_dbg
for a kernel print which is frequently printed by the driver.

Change-Id: Ib3f29a02e79eabbd7a4452279841514277a471c4
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index e3d149c..b208f56 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -730,7 +730,7 @@ static int skl_set_module_format(struct skl_sst *ctx,
 
 	dev_dbg(ctx->dev, "Module type=%d config size: %d bytes\n",
 			module_config->id.module_id, param_size);
-	print_hex_dump(KERN_DEBUG, "Module params:", DUMP_PREFIX_OFFSET, 8, 4,
+	print_hex_dump_debug("Module params:", DUMP_PREFIX_OFFSET, 8, 4,
 			*param_data, param_size, false);
 	return 0;
 }
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 5434602..c141f24 100644
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
@@ -692,7 +692,7 @@ int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 	 /* param_block_size must be in dwords */
 	u16 param_block_size = msg->param_data_size / sizeof(u32);
 
-	print_hex_dump(KERN_DEBUG, NULL, DUMP_PREFIX_NONE,
+	print_hex_dump_debug(NULL, DUMP_PREFIX_NONE,
 		16, 4, buffer, param_block_size, false);
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
-- 
2.1.2
