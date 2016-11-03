From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add sst_ipc_tx_message_nopm" to
	the asoc tree
Date: Thu, 03 Nov 2016 11:27:29 -0600
Message-ID: <E1c2LnV-0002hA-SV@finisterre>
References: <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73EA926681D
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 18:27:42 +0100 (CET)
In-Reply-To: <1474868137-29712-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jayachandran B <jayachandran.b@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add sst_ipc_tx_message_nopm

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

>From 80a0df18191ab50eee7da3cd56cecdd55b7ab148 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 3 Nov 2016 17:07:14 +0530
Subject: [PATCH] ASoC: Intel: Add sst_ipc_tx_message_nopm

If the DSP is in low power mode, it needs to be woken up by a "wake" IPC
to set it into the D0 state before we can send any other IPC command.

The call flow is that the driver calls sst_ipc_tx_message_wait() to send any
IPC and this call checks if the device is in low power mode and in that
case we need to send the wake IPC.

So add a new IPC nopm variant which can be called from driver and
doesn't check for power state (as we already know that) and avoids
circular dependency of again checking power state.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/common/sst-ipc.c | 8 ++++++++
 sound/soc/intel/common/sst-ipc.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index 45a85190a081..2c1b3159ac1a 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -220,6 +220,14 @@ int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
 }
 EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nowait);
 
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes)
+{
+	return ipc_tx_message(ipc, header, tx_data, tx_bytes,
+		rx_data, rx_bytes, 1);
+}
+EXPORT_SYMBOL_GPL(sst_ipc_tx_message_nopm);
+
 struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	u64 header)
 {
diff --git a/sound/soc/intel/common/sst-ipc.h b/sound/soc/intel/common/sst-ipc.h
index 46871a5dff1d..f4aab1b3789a 100644
--- a/sound/soc/intel/common/sst-ipc.h
+++ b/sound/soc/intel/common/sst-ipc.h
@@ -82,6 +82,9 @@ int sst_ipc_tx_message_wait(struct sst_generic_ipc *ipc, u64 header,
 int sst_ipc_tx_message_nowait(struct sst_generic_ipc *ipc, u64 header,
 	void *tx_data, size_t tx_bytes);
 
+int sst_ipc_tx_message_nopm(struct sst_generic_ipc *ipc, u64 header,
+	void *tx_data, size_t tx_bytes, void *rx_data, size_t rx_bytes);
+
 struct ipc_message *sst_ipc_reply_find_msg(struct sst_generic_ipc *ipc,
 	u64 header);
 
-- 
2.10.1
