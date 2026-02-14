Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACEEEF8FFC
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:27:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C3F6602EC;
	Wed,  4 Mar 2026 17:26:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C3F6602EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772641627;
	bh=ZEHT+2cIE5Cz7w2ObVMbl/v61jVXE0Z7AQ/8z+8BIaI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YQ1lnJPaLKEP8TCjS1vhCm3Co98uBQLbkuyw6lW4eXw5IrX5C3ItShxs3efhHP63B
	 pC66AdSHg6ctn04C3Iekzq/MavmVhSHOV+L905VwYPW0PWaHS9A2M43gVpt8oqksYT
	 OUPbGdXN+pthBB/p8MrnTIxGKmduXtNt1MxumOmw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47BA9F806C7; Wed,  4 Mar 2026 17:25:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A619EF806C7;
	Wed,  4 Mar 2026 17:25:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2A43F804F2; Sat, 14 Feb 2026 09:50:50 +0100 (CET)
Received: from mail.unwrap.rs (mail.unwrap.rs [172.232.15.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA512)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F24CF8016D;
	Sat, 14 Feb 2026 09:50:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F24CF8016D
From: Cole Leavitt <cole@unwrap.rs>
To: perex@perex.cz
Cc: tiwai@suse.de,
	broonie@kernel.org,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Cole Leavitt <cole@unwrap.rs>
Subject: [PATCH 1/2] ASoC: SOF: Replace IPC TX busy deferral with bounded
 retry
Date: Sat, 14 Feb 2026 01:48:49 -0700
Message-ID: <20260214084850.7594-1-cole@unwrap.rs>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: cole@unwrap.rs
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: NNQ57CJWQNW3BTGGKAFTLXRSS4YUDBJO
X-Message-ID-Hash: NNQ57CJWQNW3BTGGKAFTLXRSS4YUDBJO
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:24:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NNQ57CJWQNW3BTGGKAFTLXRSS4YUDBJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The SOF IPC4 platform send_msg functions (hda_dsp_ipc4_send_msg,
mtl_ipc_send_msg, cnl_ipc4_send_msg) previously stored the message in
delayed_ipc_tx_msg and returned 0 when the TX register was busy. The
deferred message was supposed to be dispatched from the IRQ handler
when the DSP acknowledged the previous message.

This mechanism silently drops messages during D0i3 power transitions
because the IRQ handler never fires while the DSP is in a low-power
state. The caller then hangs in wait_event_timeout() for up to 500ms
per IPC chunk, causing multi-second audio stalls under CPU load.

Fix this by making the platform send_msg functions return -EBUSY
immediately when the TX register is busy (safe since they execute
under spin_lock_irq in sof_ipc_send_msg), and adding a bounded retry
loop with usleep_range() in ipc4_tx_msg_unlocked() which only holds
the tx_mutex (a sleepable context). The retry loop attempts up to 50
iterations with 100-200us delays, bounding the maximum busy-wait to
approximately 10ms instead of the previous 500ms timeout.

Also remove the now-dead delayed_ipc_tx_msg field from
sof_intel_hda_dev, the dispatch code, and the ack_received tracking
variable from all three IRQ thread handlers (hda_dsp_ipc4_irq_thread,
mtl_ipc_irq_thread, cnl_ipc4_irq_thread).

Signed-off-by: Cole Leavitt <cole@unwrap.rs>
---
 sound/soc/sof/intel/cnl.c     | 17 ++---------------
 sound/soc/sof/intel/hda-ipc.c | 17 ++---------------
 sound/soc/sof/intel/hda.h     |  8 --------
 sound/soc/sof/intel/mtl.c     | 17 ++---------------
 sound/soc/sof/ipc4.c          | 17 +++++++++++++++--
 5 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 0cc5725515e7..a2c6c7894a0f 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -37,7 +37,6 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context)
 {
 	struct sof_ipc4_msg notification_data = {{ 0 }};
 	struct snd_sof_dev *sdev = context;
-	bool ack_received = false;
 	bool ipc_irq = false;
 	u32 hipcida, hipctdr;
 
@@ -51,7 +50,6 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context)
 		cnl_ipc_dsp_done(sdev);
 
 		ipc_irq = true;
-		ack_received = true;
 	}
 
 	if (hipctdr & CNL_DSP_REG_HIPCTDR_BUSY) {
@@ -101,13 +99,6 @@ irqreturn_t cnl_ipc4_irq_thread(int irq, void *context)
 		/* This interrupt is not shared so no need to return IRQ_NONE. */
 		dev_dbg_ratelimited(sdev->dev, "nothing to do in IPC IRQ thread\n");
 
-	if (ack_received) {
-		struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
-
-		if (hdev->delayed_ipc_tx_msg)
-			cnl_ipc4_send_msg(sdev, hdev->delayed_ipc_tx_msg);
-	}
-
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_NS(cnl_ipc4_irq_thread, "SND_SOC_SOF_INTEL_CNL");
@@ -266,12 +257,8 @@ int cnl_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
 	struct sof_ipc4_msg *msg_data = msg->msg_data;
 
-	if (hda_ipc4_tx_is_busy(sdev)) {
-		hdev->delayed_ipc_tx_msg = msg;
-		return 0;
-	}
-
-	hdev->delayed_ipc_tx_msg = NULL;
+	if (hda_ipc4_tx_is_busy(sdev))
+		return -EBUSY;
 
 	/* send the message via mailbox */
 	if (msg_data->data_size)
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index 94425c510861..78449452041c 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -106,12 +106,8 @@ int hda_dsp_ipc4_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
 	struct sof_ipc4_msg *msg_data = msg->msg_data;
 
-	if (hda_ipc4_tx_is_busy(sdev)) {
-		hdev->delayed_ipc_tx_msg = msg;
-		return 0;
-	}
-
-	hdev->delayed_ipc_tx_msg = NULL;
+	if (hda_ipc4_tx_is_busy(sdev))
+		return -EBUSY;
 
 	/* send the message via mailbox */
 	if (msg_data->data_size)
@@ -168,7 +164,6 @@ irqreturn_t hda_dsp_ipc4_irq_thread(int irq, void *context)
 {
 	struct sof_ipc4_msg notification_data = {{ 0 }};
 	struct snd_sof_dev *sdev = context;
-	bool ack_received = false;
 	bool ipc_irq = false;
 	u32 hipcie, hipct;
 
@@ -182,7 +177,6 @@ irqreturn_t hda_dsp_ipc4_irq_thread(int irq, void *context)
 		hda_dsp_ipc_dsp_done(sdev);
 
 		ipc_irq = true;
-		ack_received = true;
 	}
 
 	if (hipct & HDA_DSP_REG_HIPCT_BUSY) {
@@ -236,13 +230,6 @@ irqreturn_t hda_dsp_ipc4_irq_thread(int irq, void *context)
 		/* This interrupt is not shared so no need to return IRQ_NONE. */
 		dev_dbg_ratelimited(sdev->dev, "nothing to do in IPC IRQ thread\n");
 
-	if (ack_received) {
-		struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
-
-		if (hdev->delayed_ipc_tx_msg)
-			hda_dsp_ipc4_send_msg(sdev, hdev->delayed_ipc_tx_msg);
-	}
-
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_NS(hda_dsp_ipc4_irq_thread, "SND_SOC_SOF_INTEL_HDA_COMMON");
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 562fe8be79c1..ac9f76a5ef97 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -549,14 +549,6 @@ struct sof_intel_hda_dev {
 
 	/* work queue for mic privacy state change notification sending */
 	struct sof_ace3_mic_privacy mic_privacy;
-
-	/*
-	 * Pointing to the IPC message if immediate sending was not possible
-	 * because the downlink communication channel was BUSY at the time.
-	 * The message will be re-tried when the channel becomes free (the ACK
-	 * is received from the DSP for the previous message)
-	 */
-	struct snd_sof_ipc_msg *delayed_ipc_tx_msg;
 };
 
 static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 095dcf1a18e4..24dec128f589 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -101,12 +101,8 @@ static int mtl_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *ms
 	struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
 	struct sof_ipc4_msg *msg_data = msg->msg_data;
 
-	if (hda_ipc4_tx_is_busy(sdev)) {
-		hdev->delayed_ipc_tx_msg = msg;
-		return 0;
-	}
-
-	hdev->delayed_ipc_tx_msg = NULL;
+	if (hda_ipc4_tx_is_busy(sdev))
+		return -EBUSY;
 
 	/* send the message via mailbox */
 	if (msg_data->data_size)
@@ -559,7 +555,6 @@ static irqreturn_t mtl_ipc_irq_thread(int irq, void *context)
 {
 	struct sof_ipc4_msg notification_data = {{ 0 }};
 	struct snd_sof_dev *sdev = context;
-	bool ack_received = false;
 	bool ipc_irq = false;
 	u32 hipcida;
 	u32 hipctdr;
@@ -576,7 +571,6 @@ static irqreturn_t mtl_ipc_irq_thread(int irq, void *context)
 		mtl_ipc_dsp_done(sdev);
 
 		ipc_irq = true;
-		ack_received = true;
 	}
 
 	if (hipctdr & MTL_DSP_REG_HFIPCXTDR_BUSY) {
@@ -628,13 +622,6 @@ static irqreturn_t mtl_ipc_irq_thread(int irq, void *context)
 		dev_dbg_ratelimited(sdev->dev, "nothing to do in IPC IRQ thread\n");
 	}
 
-	if (ack_received) {
-		struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
-
-		if (hdev->delayed_ipc_tx_msg)
-			mtl_ipc_send_msg(sdev, hdev->delayed_ipc_tx_msg);
-	}
-
 	return IRQ_HANDLED;
 }
 
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index a4a090e6724a..2e24308ef9cc 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -365,20 +365,33 @@ static int ipc4_wait_tx_done(struct snd_sof_ipc *ipc, void *reply_data)
 	return ret;
 }
 
+#define SOF_IPC4_TX_BUSY_RETRIES	50
+#define SOF_IPC4_TX_BUSY_DELAY_US	100
+#define SOF_IPC4_TX_BUSY_DELAY_MAX_US	200
+
 static int ipc4_tx_msg_unlocked(struct snd_sof_ipc *ipc,
 				void *msg_data, size_t msg_bytes,
 				void *reply_data, size_t reply_bytes)
 {
 	struct sof_ipc4_msg *ipc4_msg = msg_data;
 	struct snd_sof_dev *sdev = ipc->sdev;
-	int ret;
+	int ret, i;
 
 	if (msg_bytes > ipc->max_payload_size || reply_bytes > ipc->max_payload_size)
 		return -EINVAL;
 
 	sof_ipc4_log_header(sdev->dev, "ipc tx      ", msg_data, true);
 
-	ret = sof_ipc_send_msg(sdev, msg_data, msg_bytes, reply_bytes);
+	for (i = 0; i < SOF_IPC4_TX_BUSY_RETRIES; i++) {
+		ret = sof_ipc_send_msg(sdev, msg_data, msg_bytes, reply_bytes);
+		if (ret != -EBUSY)
+			break;
+		usleep_range(SOF_IPC4_TX_BUSY_DELAY_US,
+			     SOF_IPC4_TX_BUSY_DELAY_MAX_US);
+	}
+	if (i == SOF_IPC4_TX_BUSY_RETRIES)
+		dev_dbg(sdev->dev, "%s: TX still busy after %d retries\n",
+			__func__, i);
 	if (ret) {
 		dev_err_ratelimited(sdev->dev,
 				    "%s: ipc message send for %#x|%#x failed: %d\n",
-- 
2.52.0
