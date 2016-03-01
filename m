From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: remove unused variable" to the
	asoc tree
Date: Tue, 01 Mar 2016 12:26:49 +0900
Message-ID: <E1aaaxV-0008DQ-Nf@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23FBD2661AE
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:27:00 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: remove unused variable

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

>From dbc77eed6553362e08c1874ff30df640c96eca92 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 29 Feb 2016 22:53:46 +0530
Subject: [PATCH] ASoC: intel: remove unused variable

The variable cmd_id is only assigned some value and is never used.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 3dc7358828b3..8afa6fe7b0b0 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -318,7 +318,6 @@ void sst_process_reply_mrfld(struct intel_sst_drv *sst_drv_ctx,
 	union ipc_header_high msg_high;
 	u32 msg_low;
 	struct ipc_dsp_hdr *dsp_hdr;
-	unsigned int cmd_id;
 
 	msg_high = msg->mrfld_header.p.header_high;
 	msg_low = msg->mrfld_header.p.header_low_payload;
@@ -357,7 +356,6 @@ void sst_process_reply_mrfld(struct intel_sst_drv *sst_drv_ctx,
 			return;
 		/* Copy command id so that we can use to put sst to reset */
 		dsp_hdr = (struct ipc_dsp_hdr *)data;
-		cmd_id = dsp_hdr->cmd_id;
 		dev_dbg(sst_drv_ctx->dev, "cmd_id %d\n", dsp_hdr->cmd_id);
 		if (sst_wake_up_block(sst_drv_ctx, msg_high.part.result,
 				msg_high.part.drv_id,
-- 
2.7.0
