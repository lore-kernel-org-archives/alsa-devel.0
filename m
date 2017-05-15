From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: Fix IPC rx_list
	corruption
Date: Mon, 15 May 2017 19:44:29 +0530
Message-ID: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C0505266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 16:28:27 +0200 (CEST)
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
Cc: tiwai@suse.de, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

In SKL+ platforms, all IPC commands are serialised, i.e. the driver sends
a new IPC to DSP, only after receiving a reply from the firmware for the
current IPC.

Hence it seems apparent that there is only a single modifier of the IPC RX
List. However, during an IPC timeout case in a multithreaded environment,
there is a possibility of the list element being deleted two times if not
properly protected.

So, use spin lock save/restore to prevent rx_list corruption.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 58c525096a7c..498b15345b1a 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -413,8 +413,11 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	u32 reply = header.primary & IPC_GLB_REPLY_STATUS_MASK;
 	u64 *ipc_header = (u64 *)(&header);
 	struct skl_sst *skl = container_of(ipc, struct skl_sst, ipc);
+	unsigned long flags;
 
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
 	msg = skl_ipc_reply_get_msg(ipc, *ipc_header);
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 	if (msg == NULL) {
 		dev_dbg(ipc->dev, "ipc: rx list is empty\n");
 		return;
@@ -456,8 +459,10 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		}
 	}
 
+	spin_lock_irqsave(&ipc->dsp->spinlock, flags);
 	list_del(&msg->list);
 	sst_ipc_tx_msg_reply_complete(ipc, msg);
+	spin_unlock_irqrestore(&ipc->dsp->spinlock, flags);
 }
 
 irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
-- 
1.9.1
