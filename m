Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA6C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 00:41:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7009A22DD3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 00:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7009A22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0302818F7;
	Wed, 20 Jan 2021 01:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0302818F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611103281;
	bh=ASdIBld0kRKrSBmWTcADXh8t0hV9MAQAzBS0G31VLvA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hgjs+STihCK2CZ5nuLy5OLNFAWxLq1Kyl9il3l9uLYC4bEYrF0c8ZFtXLCjFqNdmk
	 CDtQvUXmXMPMM2FjraDXkHf1KsGy3/7vJWTW1aClGiGEzItbYdj1qQS8+VecmxF92r
	 yiVqBE0C+OrLg+dic0LBIB9yZ636cczqU3ShDynA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7B19F80507;
	Wed, 20 Jan 2021 01:37:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48CCAF80508; Wed, 20 Jan 2021 01:37:28 +0100 (CET)
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86386F804FB
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 01:37:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86386F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.b="n3T9Dtc1"
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 1F82BA13C9;
 Wed, 20 Jan 2021 01:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=UMN9to6pAnT+
 kXPPZYJfkC29hxPBXNediHgxXL349us=; b=n3T9Dtc19sfJzQ80NQU21S5e+1+o
 DEB5Hpum78B98DFe3b09scZiTbovRkN3D7xBD6kxmQVOi0EGwfbxT1MgfpVO1Bmw
 s8eXd5aBXVizBVk5qCGF8fEToBpXOlN8/fL9Rlr2txfzCDEuvYK4LtBQsypuCtOI
 ykSW43trymeDIWbfXJ38eYg5h/OgrSAc9zxMvZA3ebiotB9PQLGXl6WtBkrfsGeT
 2ee49IXZ4ti6nB3HvBFS1dATy2vuIQizmTvfkbmylodxaLBEUqMygC6E5FCfWry0
 8E82sU88jgfN/XqbKVNfzsUWLqekkAcCwsaCK0NzScCuFG98a4aZu5tlGA==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH 7/7] ALSA: virtio: introduce device suspend/resume support
Date: Wed, 20 Jan 2021 01:36:35 +0100
Message-ID: <20210120003638.3339987-8-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Takashi Iwai <tiwai@suse.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 54 ++++++++++++++++++++
 sound/virtio/virtio_pcm.c     | 40 +++++++++++++++
 sound/virtio/virtio_pcm.h     |  6 +++
 sound/virtio/virtio_pcm_ops.c | 93 ++++++++++++++++++++---------------
 4 files changed, 154 insertions(+), 39 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 02814c3932ab..2bde324f9b95 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -507,6 +507,56 @@ static void virtsnd_config_changed(struct virtio_device *vdev)
 			 "sound device configuration was changed\n");
 }
 
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_freeze() - Suspend device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_freeze(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+
+	virtsnd_disable_vqs(snd);
+
+	vdev->config->reset(vdev);
+	vdev->config->del_vqs(vdev);
+
+	return 0;
+}
+
+/**
+ * virtsnd_restore() - Resume device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_restore(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+	int rc;
+
+	rc = virtsnd_find_vqs(snd);
+	if (rc)
+		return rc;
+
+	virtio_device_ready(vdev);
+
+	virtsnd_enable_vqs(snd);
+
+	if (snd->nsubstreams) {
+		rc = virtsnd_pcm_restore(snd);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -520,6 +570,10 @@ static struct virtio_driver virtsnd_driver = {
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
 	.config_changed = virtsnd_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtsnd_freeze,
+	.restore = virtsnd_restore,
+#endif
 };
 
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 6a1ca6b2c3ca..68d9c6dee13a 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -122,6 +122,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *substream,
 		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_RESUME |
 		SNDRV_PCM_INFO_PAUSE;
 
 	if (!info->channels_min || info->channels_min > info->channels_max) {
@@ -511,6 +512,45 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_pcm_restore() - Resume PCM substreams.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_restore(struct virtio_snd *snd)
+{
+	unsigned int i;
+
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *substream = &snd->substreams[i];
+		struct snd_pcm_substream *ksubstream = substream->substream;
+		int rc;
+
+		if (!substream->suspended)
+			continue;
+
+		/*
+		 * We restart the substream by executing the standard command
+		 * sequence. The START command will be sent from a subsequent
+		 * call to the trigger() callback function after the device has
+		 * been resumed.
+		 */
+		rc = ksubstream->ops->hw_params(ksubstream, NULL);
+		if (rc)
+			return rc;
+
+		rc = ksubstream->ops->prepare(ksubstream);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 /**
  * virtsnd_pcm_event() - Handle the PCM device event notification.
  * @snd: VirtIO sound device.
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index a326b921b947..23d0fdd57225 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -41,6 +41,7 @@ struct virtio_pcm_msg;
  * @hw_ptr: Substream hardware pointer value in frames [0 ... buffer_size).
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
+ * @suspended: Kernel ALSA substream is suspended.
  * @msgs: I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
  * @msg_count: Number of pending I/O messages in the virtqueue.
@@ -60,6 +61,7 @@ struct virtio_pcm_substream {
 	atomic_t hw_ptr;
 	atomic_t xfer_enabled;
 	atomic_t xfer_xrun;
+	bool suspended;
 	struct virtio_pcm_msg *msgs;
 	int msg_last_enqueued;
 	atomic_t msg_count;
@@ -102,6 +104,10 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
 
 int virtsnd_pcm_build_devs(struct virtio_snd *snd);
 
+#ifdef CONFIG_PM_SLEEP
+int virtsnd_pcm_restore(struct virtio_snd *snd);
+#endif /* CONFIG_PM_SLEEP */
+
 void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *event);
 
 void virtsnd_pcm_tx_notify_cb(struct virtqueue *vqueue);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 8d26c1144ad6..1723eda4b052 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -183,6 +183,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	if (!ss)
 		return -EBADFD;
 
+	ss->suspended = false;
+
 	substream->runtime->hw = ss->hw;
 	substream->private_data = ss;
 
@@ -237,18 +239,20 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 	int vrate = -1;
 	int rc;
 
-	/*
-	 * If we got here after ops->trigger() was called, the queue may
-	 * still contain messages. In this case, we need to release the
-	 * substream first.
-	 */
-	if (atomic_read(&ss->msg_count)) {
-		rc = virtsnd_pcm_release(ss);
-		if (rc) {
-			dev_err(&vdev->dev,
-				"SID %u: invalid I/O queue state\n",
-				ss->sid);
-			return rc;
+	if (!ss->suspended) {
+		/*
+		 * If we got here after ops->trigger() was called, the queue may
+		 * still contain messages. In this case, we need to release the
+		 * substream first.
+		 */
+		if (atomic_read(&ss->msg_count)) {
+			rc = virtsnd_pcm_release(ss);
+			if (rc) {
+				dev_err(&vdev->dev,
+					"SID %u: invalid I/O queue state\n",
+					ss->sid);
+				return rc;
+			}
 		}
 	}
 
@@ -379,37 +383,41 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
-	struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
 	struct virtio_snd_msg *msg;
 	unsigned long flags;
 	int rc;
 
-	/*
-	 * If we got here after ops->trigger() was called, the queue may
-	 * still contain messages. In this case, we need to reset the
-	 * substream first.
-	 */
-	if (atomic_read(&ss->msg_count)) {
-		rc = virtsnd_pcm_hw_params(substream, NULL);
-		if (rc)
-			return rc;
-	}
-
-	spin_lock_irqsave(&queue->lock, flags);
-	ss->msg_last_enqueued = -1;
-	spin_unlock_irqrestore(&queue->lock, flags);
+	if (!ss->suspended) {
+		struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
+
+		/*
+		 * If we got here after ops->trigger() was called, the queue may
+		 * still contain messages. In this case, we need to reset the
+		 * substream first.
+		 */
+		if (atomic_read(&ss->msg_count)) {
+			rc = virtsnd_pcm_hw_params(substream, NULL);
+			if (rc)
+				return rc;
+		}
 
-	/*
-	 * Since I/O messages are asynchronous, they can be completed
-	 * when the runtime structure no longer exists. Since each
-	 * completion implies incrementing the hw_ptr, we cache all the
-	 * current values needed to compute the new hw_ptr value.
-	 */
-	ss->frame_bytes = substream->runtime->frame_bits >> 3;
-	ss->period_size = substream->runtime->period_size;
-	ss->buffer_size = substream->runtime->buffer_size;
+		spin_lock_irqsave(&queue->lock, flags);
+		ss->msg_last_enqueued = -1;
+		spin_unlock_irqrestore(&queue->lock, flags);
+
+		/*
+		 * Since I/O messages are asynchronous, they can be completed
+		 * when the runtime structure no longer exists. Since each
+		 * completion implies incrementing the hw_ptr, we cache all the
+		 * current values needed to compute the new hw_ptr value.
+		 */
+		ss->frame_bytes = substream->runtime->frame_bits >> 3;
+		ss->period_size = substream->runtime->period_size;
+		ss->buffer_size = substream->runtime->buffer_size;
+
+		atomic_set(&ss->hw_ptr, 0);
+	}
 
-	atomic_set(&ss->hw_ptr, 0);
 	atomic_set(&ss->xfer_xrun, 0);
 	atomic_set(&ss->msg_count, 0);
 
@@ -442,9 +450,12 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
 	switch (command) {
 	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME: {
 		int rc;
 
+		ss->suspended = false;
+
 		spin_lock(&queue->lock);
 		rc = virtsnd_pcm_msg_send(ss);
 		spin_unlock(&queue->lock);
@@ -461,9 +472,13 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 		return virtsnd_ctl_msg_send(snd, msg);
 	}
 	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND: {
 		atomic_set(&ss->xfer_enabled, 0);
 
+		if (command == SNDRV_PCM_TRIGGER_SUSPEND)
+			ss->suspended = true;
+
 		msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
 						GFP_ATOMIC);
 		if (IS_ERR(msg))
-- 
2.30.0


