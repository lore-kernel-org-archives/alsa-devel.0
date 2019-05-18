From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/12] ASoC: SOF: ipc: fix a race,
	leading to IPC timeouts
Date: Sat, 18 May 2019 15:27:00 -0500
Message-ID: <20190518202704.7772-9-pierre-louis.bossart@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B70AF8972A
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2019 22:27:29 +0200 (CEST)
In-Reply-To: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
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
the sender when an IPC response is received from the DSP, then
unmasks the IPC interrupt. Those actions are performed without
holding any locks, so the thread can be interrupted between them. IPC
timeouts have been observed in such scenarios: if the sender is woken
up and it proceeds with sending the next message without unmasking
the IPC interrupt, it can miss the next response. This patch takes a
spin-lock to prevent the IRQ thread from being preempted at that
point. It also makes sure, that the next IPC transmission by the host
cannot take place before the IRQ thread has finished updating all the
required IPC registers.

Fixes: 53e0c72d98b ("ASoC: SOF: Add support for IPC IO between DSP and Host")
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/bdw.c     | 11 ++++++-----
 sound/soc/sof/intel/byt.c     | 12 +++++++-----
 sound/soc/sof/intel/cnl.c     |  6 ++++++
 sound/soc/sof/intel/hda-ipc.c | 19 ++++++++++++++++---
 sound/soc/sof/ipc.c           | 13 -------------
 5 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 065cb868bdfa..9dfdc02192b7 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -278,11 +278,15 @@ static irqreturn_t bdw_irq_thread(int irq, void *context)
 	/* reply message from DSP */
 	if (ipcx & SHIM_IPCX_DONE &&
 	    !(imrx & SHIM_IMRX_DONE)) {
+		unsigned long flags;
+
 		/* Mask Done interrupt before return */
 		snd_sof_dsp_update_bits_unlocked(sdev, BDW_DSP_BAR,
 						 SHIM_IMRX, SHIM_IMRX_DONE,
 						 SHIM_IMRX_DONE);
 
+		spin_lock_irqsave(&sdev->ipc_lock, flags);
+
 		/*
 		 * handle immediate reply from DSP core. If the msg is
 		 * found, set done bit in cmd_done which is called at the
@@ -294,6 +298,8 @@ static irqreturn_t bdw_irq_thread(int irq, void *context)
 		snd_sof_ipc_reply(sdev, ipcx);
 
 		bdw_dsp_done(sdev);
+
+		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 	}
 
 	ipcd = snd_sof_dsp_read(sdev, BDW_DSP_BAR, SHIM_IPCD);
@@ -485,7 +491,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -501,8 +506,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 	/* get reply */
 	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
 
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
-
 	if (reply.error < 0) {
 		memcpy(msg->reply_data, &reply, sizeof(reply));
 		ret = reply.error;
@@ -521,8 +524,6 @@ static void bdw_get_reply(struct snd_sof_dev *sdev)
 	}
 
 	msg->reply_error = ret;
-
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 }
 
 static void bdw_host_done(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 7bf9143d3106..5a11a104110b 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -324,11 +324,16 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 	/* reply message from DSP */
 	if (ipcx & SHIM_BYT_IPCX_DONE &&
 	    !(imrx & SHIM_IMRX_DONE)) {
+		unsigned long flags;
+
 		/* Mask Done interrupt before first */
 		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR,
 						   SHIM_IMRX,
 						   SHIM_IMRX_DONE,
 						   SHIM_IMRX_DONE);
+
+		spin_lock_irqsave(&sdev->ipc_lock, flags);
+
 		/*
 		 * handle immediate reply from DSP core. If the msg is
 		 * found, set done bit in cmd_done which is called at the
@@ -340,6 +345,8 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
 		snd_sof_ipc_reply(sdev, ipcx);
 
 		byt_dsp_done(sdev);
+
+		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 	}
 
 	/* new message from DSP */
@@ -383,7 +390,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_ipc_msg *msg = sdev->msg;
 	struct sof_ipc_reply reply;
-	unsigned long flags;
 	int ret = 0;
 
 	/*
@@ -399,8 +405,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 	/* get reply */
 	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
 
-	spin_lock_irqsave(&sdev->ipc_lock, flags);
-
 	if (reply.error < 0) {
 		memcpy(msg->reply_data, &reply, sizeof(reply));
 		ret = reply.error;
@@ -419,8 +423,6 @@ static void byt_get_reply(struct snd_sof_dev *sdev)
 	}
 
 	msg->reply_error = ret;
-
-	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
 }
 
 static void byt_host_done(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 08a1a3d3c08d..fd8c499b3ea0 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -50,6 +50,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 	/* reply message from DSP */
 	if (hipcida & CNL_DSP_REG_HIPCIDA_DONE &&
 	    hipcctl & CNL_DSP_REG_HIPCCTL_DONE) {
+		unsigned long flags;
+
 		hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
 					 CNL_DSP_REG_HIPCIDR);
 		msg_ext = hipci & CNL_DSP_REG_HIPCIDR_MSG_MASK;
@@ -64,6 +66,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 					CNL_DSP_REG_HIPCCTL,
 					CNL_DSP_REG_HIPCCTL_DONE, 0);
 
+		spin_lock_irqsave(&sdev->ipc_lock, flags);
+
 		/* handle immediate reply from DSP core */
 		hda_dsp_ipc_get_reply(sdev);
 		snd_sof_ipc_reply(sdev, msg);
@@ -75,6 +79,8 @@ static irqreturn_t cnl_ipc_irq_thread(int irq, void *context)
 
 		cnl_ipc_dsp_done(sdev);
 
+		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
+
 		ret = IRQ_HANDLED;
 	}
 
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 73ead7070cde..c977a447051d 100644
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
@@ -158,6 +155,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 	/* is this a reply message from the DSP */
 	if (hipcie & HDA_DSP_REG_HIPCIE_DONE &&
 	    hipcctl & HDA_DSP_REG_HIPCCTL_DONE) {
+		unsigned long flags;
+
 		hipci = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
 					 HDA_DSP_REG_HIPCI);
 		msg = hipci & HDA_DSP_REG_HIPCI_MSG_MASK;
@@ -172,6 +171,18 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
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
+		spin_lock_irqsave(&sdev->ipc_lock, flags);
+
 		/* handle immediate reply from DSP core - ignore ROM messages */
 		if (hda_dsp_ipc_is_sof(msg)) {
 			hda_dsp_ipc_get_reply(sdev);
@@ -187,6 +198,8 @@ irqreturn_t hda_dsp_ipc_irq_thread(int irq, void *context)
 		/* set the done bit */
 		hda_dsp_ipc_dsp_done(sdev);
 
+		spin_unlock_irqrestore(&sdev->ipc_lock, flags);
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
