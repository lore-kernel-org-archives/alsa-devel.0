From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add FW reply for
	MCLK/SCLK IPC" to the asoc tree
Date: Wed, 28 Nov 2018 12:57:38 +0000 (GMT)
Message-ID: <20181128125738.DD6F5440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEFB267B72
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 13:57:42 +0100 (CET)
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

   ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

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

>From 61f94ee4a7435c35d78b22e4ae6e0551908000ae Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 29 Jan 2018 21:46:00 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add FW reply for MCLK/SCLK IPC

If mclk/sclk is already running, FW responds with IPC reply MCLK/SCLK
already running. Add these to the IPC reply lookup table.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 8708755a8f9a..9f3ce73593ae 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -249,6 +249,8 @@ enum skl_ipc_glb_reply {
 	IPC_GLB_REPLY_INVALID_CONFIG_DATA_LEN = 121,
 	IPC_GLB_REPLY_GATEWAY_NOT_INITIALIZED = 140,
 	IPC_GLB_REPLY_GATEWAY_NOT_EXIST = 141,
+	IPC_GLB_REPLY_SCLK_ALREADY_RUNNING = 150,
+	IPC_GLB_REPLY_MCLK_ALREADY_RUNNING = 151,
 
 	IPC_GLB_REPLY_PPL_NOT_INITIALIZED = 160,
 	IPC_GLB_REPLY_PPL_NOT_EXIST = 161,
@@ -401,6 +403,10 @@ struct skl_ipc_err_map {
 static struct skl_ipc_err_map skl_err_map[] = {
 	{"DSP out of memory", IPC_GLB_REPLY_OUT_OF_MEMORY, -ENOMEM},
 	{"DSP busy", IPC_GLB_REPLY_BUSY, -EBUSY},
+	{"SCLK already running", IPC_GLB_REPLY_SCLK_ALREADY_RUNNING,
+			IPC_GLB_REPLY_SCLK_ALREADY_RUNNING},
+	{"MCLK already running", IPC_GLB_REPLY_MCLK_ALREADY_RUNNING,
+			IPC_GLB_REPLY_MCLK_ALREADY_RUNNING},
 };
 
 static int skl_ipc_set_reply_error_code(struct sst_generic_ipc *ipc, u32 reply)
-- 
2.19.1
