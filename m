From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Increase loglevel of
	debug messages." to the asoc tree
Date: Mon, 27 Jun 2016 17:40:21 +0100
Message-ID: <E1bHZa9-0005Ci-D2@debutante>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C018266E77
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 18:40:26 +0200 (CEST)
In-Reply-To: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, marc.herbert@intel.com, Mark Brown <broonie@kernel.org>, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Increase loglevel of debug messages.

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

>From 91c1832579700891747820862633f9a8d0d81fa4 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Fri, 24 Jun 2016 17:37:11 -0700
Subject: [PATCH] ASoC: Intel: Skylake: Increase loglevel of debug messages.

There is log spam while doing playback, record or reloading the
audio firmware.

print_hex_dump uses printk(KERN_DEBUG,... which is different from
dev_dbg used elsewhere in the driver: it's always enabled at
compile-time. Change it to print_hex_dump_debug for logging consistency.

For consistency with other log statements, change dev_info to dev_dbg
for a kernel print which is frequently printed by the driver.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 804091aa6e64..6902020df946 100644
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
index 543460293b00..c141f24cae05 100644
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
2.8.1
