From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 04/21] ASoC: SOF: ipc: use timeout configured
	at probe
Date: Mon, 22 Jul 2019 09:13:45 -0500
Message-ID: <20190722141402.7194-5-pierre-louis.bossart@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8391F803F4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 16:14:14 +0200 (CEST)
In-Reply-To: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Do not hardcode IPC timeout value in ipc.c, but rather use the timeout
value configured during device probe. For platforms that do not override
the IPC timeout, default value TIMEOUT_DEFAULT_IPC_MS has already been
defined in core.c.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
