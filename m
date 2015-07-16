From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Print error code in IPC
	for SKL" to the asoc tree
Date: Thu, 16 Jul 2015 22:01:12 +0100
Message-ID: <E1ZFqHI-0001eQ-E8@finisterre>
References: <1436546926-17263-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01527266654
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:01:23 +0200 (CEST)
In-Reply-To: <1436546926-17263-8-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Omair M Abdullah <omair.m.abdullah@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Print error code in IPC for SKL

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

>From 28f3b6f113186ff69bdc5e63126ae7fd5e35a138 Mon Sep 17 00:00:00 2001
From: Omair M Abdullah <omair.m.abdullah@intel.com>
Date: Fri, 10 Jul 2015 22:18:45 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Print error code in IPC for SKL

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index c0d0928..937a0a3 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -362,6 +362,12 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 		break;
 	}
 
+	if (reply != IPC_GLB_REPLY_SUCCESS) {
+		dev_err(ipc->dev, "ipc FW reply: reply=%d", reply);
+		dev_err(ipc->dev, "FW Error Code: %u\n",
+			ipc->dsp->fw_ops.get_fw_errcode(ipc->dsp));
+	}
+
 	list_del(&msg->list);
 	sst_ipc_tx_msg_reply_complete(ipc, msg);
 }
-- 
2.1.4
