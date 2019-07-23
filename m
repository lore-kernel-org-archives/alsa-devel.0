From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: ipc: use timeout configured at
	probe" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:14 +0100 (BST)
Message-ID: <20190723112914.977952742B60@ypsilon.sirena.org.uk>
References: <20190722141402.7194-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EAB0DF8048F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:15 +0200 (CEST)
In-Reply-To: <20190722141402.7194-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: ipc: use timeout configured at probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 6dd78b310b8d4ab5d0b851e369b5b3d46c6a32a9 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Mon, 22 Jul 2019 09:13:45 -0500
Subject: [PATCH] ASoC: SOF: ipc: use timeout configured at probe

Do not hardcode IPC timeout value in ipc.c, but rather use the timeout
value configured during device probe. For platforms that do not override
the IPC timeout, default value TIMEOUT_DEFAULT_IPC_MS has already been
defined in core.c.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 20dfca9c93b7..b2f359d2f7e5 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -17,12 +17,6 @@
 #include "sof-priv.h"
 #include "ops.h"
 
-/*
- * IPC message default size and timeout (ms).
- * TODO: allow platforms to set size and timeout.
- */
-#define IPC_TIMEOUT_MS		300
-
 static void ipc_trace_message(struct snd_sof_dev *sdev, u32 msg_id);
 static void ipc_stream_message(struct snd_sof_dev *sdev, u32 msg_cmd);
 
@@ -211,7 +205,7 @@ static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
 
 	/* wait for DSP IPC completion */
 	ret = wait_event_timeout(msg->waitq, msg->ipc_complete,
-				 msecs_to_jiffies(IPC_TIMEOUT_MS));
+				 msecs_to_jiffies(sdev->ipc_timeout));
 
 	if (ret == 0) {
 		dev_err(sdev->dev, "error: ipc timed out for 0x%x size %d\n",
-- 
2.20.1
