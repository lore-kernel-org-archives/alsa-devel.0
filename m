From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 7/9] ASoC: SOF: ipc: fix a race,
	leading to IPC timeouts
Date: Fri, 24 May 2019 14:09:23 -0500
Message-ID: <20190524190925.5931-8-pierre-louis.bossart@linux.intel.com>
References: <20190524190925.5931-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CD64F89630
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:09:41 +0200 (CEST)
In-Reply-To: <20190524190925.5931-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Currently on all supported platforms the IPC IRQ thread first signals
the sender when an IPC response is received from the DSP, then unmasks
the IPC interrupt. Those actions are performed without holding any
locks, so the thread can be interrupted between them. IPC timeouts
have been observed in such scenarios: if the sender is woken up and it
proceeds with sending the next message without unmasking the IPC
interrupt, it can miss the next response. This patch takes a spin-lock
to prevent the IRQ thread from being preempted at that point. It also
makes sure, that the next IPC transmission by the host cannot take
place before the IRQ thread has finished updating all the required IPC
registers.

Fixes: 53e0c72d98b ("ASoC: SOF: Add support for IPC IO between DSP and Host")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/bdw.c     |  9 ++++-----
 sound/soc/sof/intel/byt.c     | 10 +++++-----
 sound/soc/sof/intel/cnl.c     |  4 ++++
 sound/soc/sof/intel/hda-ipc.c | 17 ++++++++++++++---
 sound/soc/sof/ipc.c           | 13 -------------
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 065cb868bdfa..8ff3ee520aea 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -283,6 +283,8 @@ static irqreturn_t bdw_irq_thread(int irq, void *context)
 						 SHIM_IMRX, SHIM_IMRX_DONE,
 						 SHIM_IMRX_DONE);
 
+		spin_lock_irq(&sdev->ipc_lock);
+
 		/*
 		 * handle immediate reply from DSP core. If the msg is
 		 * found, set done bit in cmd_done which is called at the
@@ -294,6 +296,8 @@ static irqreturn_t bdw_irq_thread(int irq, void *context)
 		snd_sof_ipc_reply(sdev, ipcx);
 
 		bdw_dsp_done(sdev);
+
+		spin_unlock_irq(&sdev->ipc_lock);
 	}
 
 	ipcd = snd_sof_dsp_read(sdev, BDW_DSP_BAR, SHIM_IPCD);
@@ -485,7 +489,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -501,8 +504,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 	/* get reply */
 	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
 
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
-
 	if (reply.error < 0) {
 		memcpy(msg->reply_data, &reply, sizeof(reply));
 		ret = reply.error;
@@ -521,8 +522,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 	}
 
 	msg->reply_error = ret;
-
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 }
 
 static void bdw_host_done(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 7bf9143d3106..9e4c07eb889b 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -329,6 +329,9 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 						   SHIM_IMRX,
 						   SHIM_IMRX_DONE,
 						   SHIM_IMRX_DONE);
+
+		spin_lock_irq(&sdev->ipc_lock);
+
 		/*
 		 * handle immediate reply from DSP core. If the msg is
 		 * found, set done bit in cmd_done which is called at the
@@ -340,6 +343,8 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 		snd_sof_ipc_reply(sdev, ipcx);
 
 		byt_dsp_done(sdev);
+
+		spin_unlock_irq(&sdev->ipc_lock);
 	}
 
 	/* new message from DSP */
@@ -383,7 +388,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -399,8 +403,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 	/* get reply */
 	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
 
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
-
 	if (reply.error < 0) {
 		memcpy(msg->reply_data, &reply, sizeof(reply));
 		ret = reply.error;
@@ -419,8 +421,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 	}
 
 	msg->reply_error = ret;
-
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 }
 
 static void byt_host_done(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index c059d1170bab..e59d180da7e2 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -64,6 +64,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 					CNL_DSP_REG_HIPCCTL,
 					CNL_DSP_REG_HIPCCTL_DONE, 0);
 
+		spin_lock_irq(&sdev->ipc_lock);
+
 		/* handle immediate reply from DSP core */
 		hda_dsp_ipc_get_reply(sdev);
 		snd_sof_ipc_reply(sdev, msg);
@@ -75,6 +77,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 		cnl_ipc_dsp_done(sdev);
 
+		spin_unlock_irq(&sdev->ipc_lock);
+
 		ret = IRQ_HANDLED;
 	}
 
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 73ead7070cde..51b285103394 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -72,7 +72,6 @@ void hda_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
 	struct sof_ipc_cmd_hdr *hdr;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -84,7 +83,6 @@ void hda_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 		dev_warn(sdev->dev, "unexpected ipc interrupt raised!\n");
 		return;
 	}
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
 
 	hdr = msg->msg_data;
 	if (hdr->cmd == (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_CTX_SAVE)) {
@@ -123,7 +121,6 @@ void hda_dsp_ipc_get_reply(struct snd_sof_dev *sdev)
 out:
 	msg->reply_error = ret;
 
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 }
 
 static bool hda_dsp_ipc_is_sof(uint32_t msg)
@@ -172,6 +169,18 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 					HDA_DSP_REG_HIPCCTL,
 					HDA_DSP_REG_HIPCCTL_DONE, 0);
 
+		/*
+		 * Make sure the interrupt thread cannot be preempted between
+		 * waking up the sender and re-enabling the interrupt. Also
+		 * protect against a theoretical race with sof_ipc_tx_message():
+		 * if the DSP is fast enough to receive an IPC message, reply to
+		 * it, and the host interrupt processing calls this function on
+		 * a different core from the one, where the sending is taking
+		 * place, the message might not yet be marked as expecting a
+		 * reply.
+		 */
+		spin_lock_irq(&sdev->ipc_lock);
+
 		/* handle immediate reply from DSP core - ignore ROM messages */
 		if (hda_dsp_ipc_is_sof(msg)) {
 			hda_dsp_ipc_get_reply(sdev);
@@ -187,6 +196,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 		/* set the done bit */
 		hda_dsp_ipc_dsp_done(sdev);
 
+		spin_unlock_irq(&sdev->ipc_lock);
+
 		ret = IRQ_HANDLED;
 	}
 
diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index 894e68cbd69d..10304a90cf25 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -308,19 +308,8 @@ EXPORT_SYMBOL(sof_ipc_tx_message);
 int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
 {
 	struct snd_sof_ipc_msg *msg = &sdev->ipc->msg;
-	unsigned long flags;
-
-	/*
-	 * Protect against a theoretical race with sof_ipc_tx_message(): if the
-	 * DSP is fast enough to receive an IPC message, reply to it, and the
-	 * host interrupt processing calls this function on a different core
-	 * from the one, where the sending is taking place, the message might
-	 * not yet be marked as expecting a reply.
-	 */
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
 
 	if (msg->ipc_complete) {
-		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 		dev_err(sdev->dev, "error: no reply expected, received 0x%x",
 			msg_id);
 		return -EINVAL;
@@ -330,8 +319,6 @@ int snd_sof_ipc_reply(struct snd_sof_dev *sdev, u32 msg_id)
 	msg->ipc_complete = true;
 	wake_up(&msg->waitq);
 
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(snd_sof_ipc_reply);
-- 
2.20.1
