From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 40/53] ALSA: x86: Drop superfluous state field
Date: Thu,  2 Feb 2017 18:02:54 +0100
Message-ID: <20170202170307.24484-42-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA502675A2
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The state field keeps the connection state and it's basically as same
as drv_status field.  Drop this redundancy.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 56 ++++++++++++++--------------------------
 sound/x86/intel_hdmi_audio.h     |  3 +--
 sound/x86/intel_hdmi_lpe_audio.h |  6 -----
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9ecdd9ad0199..621be602addd 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1644,7 +1644,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 }
 
 /* process hot plug, called from wq with mutex locked */
-static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
+static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
@@ -1657,8 +1657,9 @@ static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
 		dev_dbg(intelhaddata->dev, "Device already connected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
-		return 0;
+		return;
 	}
+
 	buf_id = intelhaddata->curr_buf;
 	intelhaddata->buff_done = buf_id;
 	intelhaddata->drv_status = HAD_DRV_CONNECTED;
@@ -1679,12 +1680,10 @@ static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	}
 
 	had_build_channel_allocation_map(intelhaddata);
-
-	return 0;
 }
 
 /* process hot unplug, called from wq with mutex locked */
-static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
+static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct had_stream_data *had_stream;
@@ -1697,14 +1696,14 @@ static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		dev_dbg(intelhaddata->dev, "Device already disconnected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
-		return 0;
+		return;
 
-	} else {
-		/* Disable Audio */
-		snd_intelhad_enable_audio_int(intelhaddata, false);
-		snd_intelhad_enable_audio(intelhaddata, false);
 	}
 
+	/* Disable Audio */
+	snd_intelhad_enable_audio_int(intelhaddata, false);
+	snd_intelhad_enable_audio(intelhaddata, false);
+
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
@@ -1722,8 +1721,6 @@ static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
-
-	return 0;
 }
 
 /* PCM operations structure and the calls back for the same */
@@ -1847,18 +1844,13 @@ static void had_audio_wq(struct work_struct *work)
 	if (!pdata->hdmi_connected) {
 		dev_dbg(ctx->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
 			__func__);
-
-		if (ctx->state != hdmi_connector_status_connected) {
-			dev_dbg(ctx->dev, "%s: Already Unplugged!\n",
-				__func__);
-		} else {
-			ctx->state = hdmi_connector_status_disconnected;
-			had_process_hot_unplug(ctx);
-		}
-
+		had_process_hot_unplug(ctx);
 	} else {
 		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
 
+		dev_dbg(ctx->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
+			__func__, eld->port_id,	pdata->tmds_clock_speed);
+
 		switch (eld->pipe_id) {
 		case 0:
 			ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
@@ -1877,22 +1869,15 @@ static void had_audio_wq(struct work_struct *work)
 
 		memcpy(&ctx->eld, eld->eld_data, sizeof(ctx->eld));
 
-		had_process_hot_plug(ctx);
-
-		ctx->state = hdmi_connector_status_connected;
+		ctx->dp_output = pdata->dp_output;
+		ctx->tmds_clock_speed = pdata->tmds_clock_speed;
+		ctx->link_rate = pdata->link_rate;
 
-		dev_dbg(ctx->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
-			__func__, eld->port_id,	pdata->tmds_clock_speed);
-
-		if (pdata->tmds_clock_speed) {
-			ctx->tmds_clock_speed = pdata->tmds_clock_speed;
-			ctx->dp_output = pdata->dp_output;
-			ctx->link_rate = pdata->link_rate;
+		had_process_hot_plug(ctx);
 
-			/* Process mode change if stream is active */
-			if (ctx->stream_data.stream_type == HAD_RUNNING_STREAM)
-				hdmi_audio_mode_change(ctx);
-		}
+		/* Process mode change if stream is active */
+		if (ctx->stream_data.stream_type == HAD_RUNNING_STREAM)
+			hdmi_audio_mode_change(ctx);
 	}
 	mutex_unlock(&ctx->mutex);
 }
@@ -1966,7 +1951,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	ctx->irq = -1;
 	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
 	INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
-	ctx->state = hdmi_connector_status_disconnected;
 
 	card->private_free = hdmi_lpe_audio_free;
 
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 945f6831f1dd..258396e61829 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -129,7 +129,6 @@ struct snd_intelhad {
 	struct device *dev;
 	struct snd_pcm_chmap *chmap;
 	int underrun_count;
-	enum hdmi_connector_status state;
 	int tmds_clock_speed;
 	int link_rate;
 
@@ -138,7 +137,7 @@ struct snd_intelhad {
 	void __iomem *mmio_start;
 	unsigned int had_config_offset;
 	struct work_struct hdmi_audio_wq;
-	struct mutex mutex; /* for protecting chmap, state and eld */
+	struct mutex mutex; /* for protecting chmap and eld */
 };
 
 #endif /* _INTEL_HDMI_AUDIO_ */
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 628c578ecedf..1bc961522d0d 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -591,12 +591,6 @@ union aud_info_frame3 {
 	u32 fr3_val;
 };
 
-enum hdmi_connector_status {
-	hdmi_connector_status_connected = 1,
-	hdmi_connector_status_disconnected = 2,
-	hdmi_connector_status_unknown = 3,
-};
-
 #define HDMI_AUDIO_UNDERRUN     (1UL<<31)
 #define HDMI_AUDIO_BUFFER_DONE  (1UL<<29)
 
-- 
2.11.0
