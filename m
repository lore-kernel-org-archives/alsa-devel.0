From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 53/53] ALSA: x86: Rename drv_status to connected
Date: Thu,  2 Feb 2017 18:03:07 +0100
Message-ID: <20170202170307.24484-55-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 31B362675AF
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:19 +0100 (CET)
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

After the rewrite of the runtime PM code, we have only two driver
status: CONNECTED and DISCONNECTED.  So it's clearer to use a boolean
flag, and name it easier one, "connected".

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 40 ++++++++++++++++++++--------------------
 sound/x86/intel_hdmi_audio.h     |  4 ++--
 sound/x86/intel_hdmi_lpe_audio.h |  8 --------
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index f032610d1287..c83f02c2593e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -202,7 +202,7 @@ mid_hdmi_audio_write(struct snd_intelhad *ctx, u32 reg, u32 val)
 static int had_read_register(struct snd_intelhad *intelhaddata,
 			     u32 offset, u32 *data)
 {
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return -ENODEV;
 
 	mid_hdmi_audio_read(intelhaddata, offset, data);
@@ -221,7 +221,7 @@ static void fixup_dp_config(struct snd_intelhad *intelhaddata,
 static int had_write_register(struct snd_intelhad *intelhaddata,
 			      u32 offset, u32 data)
 {
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return -ENODEV;
 
 	fixup_dp_config(intelhaddata, offset, &data);
@@ -234,7 +234,7 @@ static int had_read_modify(struct snd_intelhad *intelhaddata, u32 offset,
 {
 	u32 val_tmp;
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return -ENODEV;
 
 	mid_hdmi_audio_read(intelhaddata, offset, &val_tmp);
@@ -556,7 +556,7 @@ static int had_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct snd_intelhad *intelhaddata = info->private_data;
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return -ENODEV;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = HAD_MAX_CHANNEL;
@@ -573,7 +573,7 @@ static int had_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	int i;
 	const struct snd_pcm_chmap_elem *chmap;
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return -ENODEV;
 
 	mutex_lock(&intelhaddata->mutex);
@@ -968,7 +968,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 
 	pm_runtime_get_sync(intelhaddata->dev);
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+	if (!intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
 			__func__);
 		retval = -ENODEV;
@@ -1098,7 +1098,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		/* Disable local INTRs till register prgmng is done */
-		if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+		if (!intelhaddata->connected) {
 			dev_dbg(intelhaddata->dev,
 				"_START: HDMI cable plugged-out\n");
 			retval = -ENODEV;
@@ -1150,7 +1150,7 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+	if (!intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
 			__func__);
 		retval = -ENODEV;
@@ -1219,7 +1219,7 @@ snd_intelhad_pcm_pointer(struct snd_pcm_substream *substream)
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
+	if (!intelhaddata->connected)
 		return SNDRV_PCM_POS_XRUN;
 
 	/* Use a hw register to calculate sub-period position reports.
@@ -1380,7 +1380,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	intr_count = 1;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+	if (!intelhaddata->connected) {
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 		dev_dbg(intelhaddata->dev,
 			"%s:Device already disconnected\n", __func__);
@@ -1419,7 +1419,7 @@ static int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+	if (!intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "HDMI cable plugged-out\n");
 		return 0;
 	}
@@ -1460,14 +1460,14 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	struct pcm_stream_info *stream;
 	struct snd_pcm_substream *substream;
 	unsigned long flags;
-	int drv_status;
+	int connected;
 
 	stream = &intelhaddata->stream_info;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
 	buf_id = intelhaddata->curr_buf;
 	intelhaddata->buff_done = buf_id;
-	drv_status = intelhaddata->drv_status;
+	connected = intelhaddata->connected;
 	if (stream->running)
 		intelhaddata->curr_buf = HAD_BUF_TYPE_A;
 
@@ -1478,7 +1478,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 
 	snd_intelhad_handle_underrun(intelhaddata);
 
-	if (drv_status == HAD_DRV_DISCONNECTED) {
+	if (!connected) {
 		dev_dbg(intelhaddata->dev,
 			"%s:Device already disconnected\n", __func__);
 		return 0;
@@ -1501,7 +1501,7 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	struct snd_pcm_substream *substream;
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
-	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
+	if (intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "Device already connected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
 		return;
@@ -1509,7 +1509,7 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 
 	buf_id = intelhaddata->curr_buf;
 	intelhaddata->buff_done = buf_id;
-	intelhaddata->drv_status = HAD_DRV_CONNECTED;
+	intelhaddata->connected = true;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_CONNECTED\n",
 			__func__, __LINE__);
@@ -1543,7 +1543,7 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 
 	spin_lock_irq(&intelhaddata->had_spinlock);
 
-	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
+	if (!intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "Device already disconnected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
 		goto out;
@@ -1554,7 +1554,7 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	snd_intelhad_enable_audio_int(intelhaddata, false);
 	snd_intelhad_enable_audio(substream, intelhaddata, false);
 
-	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
+	intelhaddata->connected = false;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
@@ -1855,7 +1855,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	ctx = card->private_data;
 	spin_lock_init(&ctx->had_spinlock);
 	mutex_init(&ctx->mutex);
-	ctx->drv_status = HAD_DRV_DISCONNECTED;
+	ctx->connected = false;
 	ctx->dev = &pdev->dev;
 	ctx->card = card;
 	ctx->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
@@ -1960,7 +1960,7 @@ static int hdmi_lpe_audio_remove(struct platform_device *pdev)
 {
 	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
 
-	if (ctx->drv_status != HAD_DRV_DISCONNECTED)
+	if (ctx->connected)
 		snd_intelhad_enable_audio_int(ctx, false);
 	snd_card_free(ctx->card);
 	return 0;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index dea51fcfc07f..9f713a8a88bc 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -80,7 +80,7 @@ struct ring_buf_info {
  * struct snd_intelhad - intelhad driver structure
  *
  * @card: ptr to hold card details
- * @drv_status: driver status
+ * @connected: the monitor connection status
  * @buf_info: ring buffer info
  * @stream_info: stream information
  * @eld: holds ELD info
@@ -95,7 +95,7 @@ struct ring_buf_info {
  */
 struct snd_intelhad {
 	struct snd_card	*card;
-	enum had_drv_status	drv_status;
+	bool		connected;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
 	unsigned char	eld[HDMI_MAX_ELD_BYTES];
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 5a5adb7f0cde..be9783910a3a 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -82,14 +82,6 @@
 /* Naud Value */
 #define DP_NAUD_VAL					32768
 
-enum had_drv_status {
-	HAD_DRV_CONNECTED,
-	HAD_DRV_RUNNING,
-	HAD_DRV_DISCONNECTED,
-	HAD_DRV_SUSPENDED,
-	HAD_DRV_ERR,
-};
-
 /* enum intel_had_aud_buf_type - HDMI controller ring buffer types */
 enum intel_had_aud_buf_type {
 	HAD_BUF_TYPE_A = 0,
-- 
2.11.0
