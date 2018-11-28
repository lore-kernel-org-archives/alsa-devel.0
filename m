From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Make DSP replies more
	human readable" to the asoc tree
Date: Wed, 28 Nov 2018 12:57:42 +0000 (GMT)
Message-ID: <20181128125742.AE9DF440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D0B49267B4F
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 13:57:51 +0100 (CET)
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
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Make DSP replies more human readable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From aa15679b2dc898049e9117fbe3ddda0b50fa52d2 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 29 Jan 2018 21:45:59 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Make DSP replies more human readable

Add more meaning to the IPC replies for easy debugging. Replace the switch
case with a lookup table to lookup for the IPC replies and print in human
readable form.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 44 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 5234fafb758a..8708755a8f9a 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -392,18 +392,43 @@ int skl_ipc_process_notification(struct sst_generic_ipc *ipc,
 	return 0;
 }
 
-static int skl_ipc_set_reply_error_code(u32 reply)
+struct skl_ipc_err_map {
+	const char *msg;
+	enum skl_ipc_glb_reply reply;
+	int err;
+};
+
+static struct skl_ipc_err_map skl_err_map[] = {
+	{"DSP out of memory", IPC_GLB_REPLY_OUT_OF_MEMORY, -ENOMEM},
+	{"DSP busy", IPC_GLB_REPLY_BUSY, -EBUSY},
+};
+
+static int skl_ipc_set_reply_error_code(struct sst_generic_ipc *ipc, u32 reply)
 {
-	switch (reply) {
-	case IPC_GLB_REPLY_OUT_OF_MEMORY:
-		return -ENOMEM;
+	int i;
 
-	case IPC_GLB_REPLY_BUSY:
-		return -EBUSY;
+	for (i = 0; i < ARRAY_SIZE(skl_err_map); i++) {
+		if (skl_err_map[i].reply == reply)
+			break;
+	}
 
-	default:
+	if (i == ARRAY_SIZE(skl_err_map)) {
+		dev_err(ipc->dev, "ipc FW reply: %d FW Error Code: %u\n",
+				reply,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
 		return -EINVAL;
 	}
+
+	if (skl_err_map[i].err < 0)
+		dev_err(ipc->dev, "ipc FW reply: %s FW Error Code: %u\n",
+				skl_err_map[i].msg,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+	else
+		dev_info(ipc->dev, "ipc FW reply: %s FW Error Code: %u\n",
+				skl_err_map[i].msg,
+				ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+
+	return skl_err_map[i].err;
 }
 
 void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
@@ -441,10 +466,7 @@ void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 
 		}
 	} else {
-		msg->errno = skl_ipc_set_reply_error_code(reply);
-		dev_err(ipc->dev, "ipc FW reply: reply=%d\n", reply);
-		dev_err(ipc->dev, "FW Error Code: %u\n",
-			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+		msg->errno = skl_ipc_set_reply_error_code(ipc, reply);
 		switch (IPC_GLB_NOTIFY_MSG_TYPE(header.primary)) {
 		case IPC_GLB_LOAD_MULTIPLE_MODS:
 		case IPC_GLB_LOAD_LIBRARY:
-- 
2.19.1
