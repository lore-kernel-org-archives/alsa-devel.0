From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 17/19] ASoC: SOF: IPC: add ipc dump function
Date: Tue, 30 Apr 2019 18:09:32 -0500
Message-ID: <20190430230934.4321-18-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD03DF8972F
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:07 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

Dump IPC status when IPC timed out. IPC status is platform specific and
need bind to plaform.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc.c      | 1 +
 sound/soc/sof/ops.h      | 6 ++++++
 sound/soc/sof/sof-priv.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 437e80a07bc2..ba1bb17a8d1e 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -207,6 +207,7 @@ static int tx_wait_done(struct snd_sof_ipc *ipc, struct snd_sof_ipc_msg *msg,
 		dev_err(sdev->dev, "error: ipc timed out for 0x%x size %d\n",
 			hdr->cmd, hdr->size);
 		snd_sof_dsp_dbg_dump(ipc->sdev, SOF_DBG_REGS | SOF_DBG_MBOX);
+		snd_sof_ipc_dump(ipc->sdev);
 		snd_sof_trace_notify_for_error(ipc->sdev);
 		ret = -ETIMEDOUT;
 	} else {
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index b8e2bf1fee24..80fc3b374c2b 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -155,6 +155,12 @@ static inline void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
 		return sof_ops(sdev)->dbg_dump(sdev, flags);
 }
 
+static inline void snd_sof_ipc_dump(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->ipc_dump)
+		return sof_ops(sdev)->ipc_dump(sdev);
+}
+
 /* register IO */
 static inline void snd_sof_dsp_write(struct snd_sof_dev *sdev, u32 bar,
 				     u32 offset, u32 value)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 170adc21ef17..1e85d6f9c5c3 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -176,6 +176,7 @@ struct snd_sof_dsp_ops {
 	int debug_map_count; /* optional */
 	void (*dbg_dump)(struct snd_sof_dev *sof_dev,
 			 u32 flags); /* optional */
+	void (*ipc_dump)(struct snd_sof_dev *sof_dev); /* optional */
 
 	/* host DMA trace initialization */
 	int (*trace_init)(struct snd_sof_dev *sdev,
-- 
2.17.1
