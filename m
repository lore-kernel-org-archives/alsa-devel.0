From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix IPC rx_list
	corruption" to the asoc tree
Date: Wed, 24 May 2017 18:41:54 +0100
Message-ID: <E1dDaIE-0002pS-M4@debutante>
References: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D0C26737B
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:42:03 +0200 (CEST)
In-Reply-To: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix IPC rx_list corruption

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

>From 5cd1f5c32132101955d7f0e1955249a84f9b6fd9 Mon Sep 17 00:00:00 2001
From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Date: Mon, 15 May 2017 19:44:29 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix IPC rx_list corruption

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
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
