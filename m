From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: intel: remove unused variable
Date: Mon, 29 Feb 2016 22:53:46 +0530
Message-ID: <1456766626-20807-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

The variable cmd_id is only assigned some value and is never used.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 3dc7358..8afa6fe 100644
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
1.9.1
