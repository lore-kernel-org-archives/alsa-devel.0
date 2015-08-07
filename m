From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 30/31] sound/atom: use kmemdup rather than duplicating its
 implementation
Date: Fri, 07 Aug 2015 09:59:36 +0200
Message-ID: <1438934377-4922-31-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 sound/soc/intel/atom/sst/sst_ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 5a27861..3dc7358 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -352,10 +352,9 @@ void sst_process_reply_mrfld(struct intel_sst_drv *sst_drv_ctx,
 	 * copy from mailbox
 	 **/
 	if (msg_high.part.large) {
-		data = kzalloc(msg_low, GFP_KERNEL);
+		data = kmemdup((void *)msg->mailbox_data, msg_low, GFP_KERNEL);
 		if (!data)
 			return;
-		memcpy(data, (void *) msg->mailbox_data, msg_low);
 		/* Copy command id so that we can use to put sst to reset */
 		dsp_hdr = (struct ipc_dsp_hdr *)data;
 		cmd_id = dsp_hdr->cmd_id;
-- 
1.9.1
