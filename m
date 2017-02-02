From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 19/53] ALSA: x86: Embed snd_intelhad into
	snd_card
Date: Thu,  2 Feb 2017 18:02:33 +0100
Message-ID: <20170202170307.24484-21-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF2C22668EC
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
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

Instead of allocating snd_intelhad struct, use the card's private_data
and embed it.  It simplifies the code a lot.

While we're at it, embed had_stream into snd_intelhad struct instead
of individually allocating, and rename had_pvt_data to a bit more
specific name, had_stream_data.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c    | 77 +++++++----------------------------------
 sound/x86/intel_hdmi_audio.h    |  4 +--
 sound/x86/intel_hdmi_audio_if.c | 32 ++++++++---------
 3 files changed, 31 insertions(+), 82 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 49cb95072a88..dfc4452afee1 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -961,12 +961,12 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
 	struct had_stream_pvt *stream;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	int retval;
 
 	pr_debug("snd_intelhad_open called\n");
 	intelhaddata = snd_pcm_substream_chip(substream);
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	runtime = substream->runtime;
 	intelhaddata->underrun_count = 0;
 
@@ -1180,13 +1180,13 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 	unsigned long flag_irq;
 	struct snd_intelhad *intelhaddata;
 	struct had_stream_pvt *stream;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 
 	pr_debug("snd_intelhad_pcm_trigger called\n");
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	stream = substream->runtime->private_data;
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1262,13 +1262,13 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	u32 link_rate = 0;
 	struct snd_intelhad *intelhaddata;
 	struct snd_pcm_runtime *runtime;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 
 	pr_debug("snd_intelhad_pcm_prepare called\n");
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 
 	if (had_get_hwstate(intelhaddata)) {
 		pr_err("%s: HDMI cable plugged-out\n", __func__);
@@ -1480,31 +1480,6 @@ struct snd_pcm_ops snd_intelhad_playback_ops = {
 };
 
 /**
- * snd_intelhad_create - to crete alsa card instance
- *
- * @intelhaddata: pointer to internal context
- * @card: pointer to card
- *
- * This function is called when the hdmi cable is plugged in
- */
-static int snd_intelhad_create(
-		struct snd_intelhad *intelhaddata,
-		struct snd_card *card)
-{
-	int retval;
-	static struct snd_device_ops ops = {
-	};
-
-	pr_debug("snd_intelhad_create called\n");
-
-	if (!intelhaddata)
-		return -EINVAL;
-
-	/* ALSA api to register the device */
-	retval = snd_device_new(card, SNDRV_DEV_LOWLEVEL, intelhaddata, &ops);
-	return retval;
-}
-/**
  * snd_intelhad_pcm_free - to free the memory allocated
  *
  * @pcm: pointer to pcm instance
@@ -1596,36 +1571,24 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	struct snd_pcm *pcm;
 	struct snd_card *card;
 	struct snd_intelhad *intelhaddata;
-	struct had_pvt_data *had_stream;
 
 	pr_debug("Enter %s\n", __func__);
 
-	/* allocate memory for saving internal context and working */
-	intelhaddata = kzalloc(sizeof(*intelhaddata), GFP_KERNEL);
-	if (!intelhaddata)
-		return -ENOMEM;
-
-	had_stream = kzalloc(sizeof(*had_stream), GFP_KERNEL);
-	if (!had_stream) {
-		retval = -ENOMEM;
-		goto free_haddata;
-	}
+	/* create a card instance with ALSA framework */
+	retval = snd_card_new(&devptr->dev, hdmi_card_index, hdmi_card_id,
+			      THIS_MODULE, sizeof(*intelhaddata), &card);
+	if (retval)
+		return retval;
 
+	intelhaddata = card->private_data;
 	spin_lock_init(&intelhaddata->had_spinlock);
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
 	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
 
-	/* create a card instance with ALSA framework */
-	retval = snd_card_new(&devptr->dev, hdmi_card_index, hdmi_card_id,
-				THIS_MODULE, 0, &card);
-
-	if (retval)
-		goto free_hadstream;
 	intelhaddata->card = card;
 	intelhaddata->card_id = hdmi_card_id;
 	intelhaddata->card_index = card->number;
-	intelhaddata->private_data = had_stream;
 	intelhaddata->flag_underrun = 0;
 	intelhaddata->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
 	strncpy(card->driver, INTEL_HAD, strlen(INTEL_HAD));
@@ -1654,12 +1617,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	if (retval)
 		goto err;
 
-	/* internal function call to register device with ALSA */
-	retval = snd_intelhad_create(intelhaddata, card);
-	if (retval)
-		goto err;
-
-	card->private_data = &intelhaddata;
 	retval = snd_card_register(card);
 	if (retval)
 		goto err;
@@ -1688,15 +1645,9 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	*had_ret = intelhaddata;
 
 	return 0;
+
 err:
 	snd_card_free(card);
-free_hadstream:
-	kfree(had_stream);
-	pm_runtime_disable(intelhaddata->dev);
-	intelhaddata->dev = NULL;
-free_haddata:
-	kfree(intelhaddata);
-	intelhaddata = NULL;
 	pr_err("Error returned from %s api %#x\n", __func__, retval);
 	return retval;
 }
@@ -1724,8 +1675,6 @@ int hdmi_audio_remove(struct snd_intelhad *intelhaddata)
 		had_set_caps(intelhaddata, HAD_SET_DISABLE_AUDIO, NULL);
 	}
 	snd_card_free(intelhaddata->card);
-	kfree(intelhaddata->private_data);
-	kfree(intelhaddata);
 	return 0;
 }
 
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 32a2fb766e47..98a004499f3c 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -95,7 +95,7 @@ struct had_stream_pvt {
 	ssize_t				dbg_cum_bytes;
 };
 
-struct had_pvt_data {
+struct had_stream_data {
 	enum had_status_stream		stream_type;
 };
 
@@ -133,7 +133,7 @@ struct snd_intelhad {
 	int		valid_buf_cnt;
 	unsigned int	aes_bits;
 	int flag_underrun;
-	struct had_pvt_data *private_data;
+	struct had_stream_data stream_data;
 	spinlock_t had_spinlock;
 	enum		intel_had_aud_buf_type buff_done;
 	struct device *dev;
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 8e3a0943332b..caf982e55ec6 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -45,13 +45,13 @@
 int hdmi_audio_query(void *haddata, struct hdmi_audio_event event)
 {
 	struct snd_pcm_substream *substream = NULL;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 	struct snd_intelhad *intelhaddata = (struct snd_intelhad *)haddata;
 
 	if (intelhaddata->stream_info.had_substream)
 		substream = intelhaddata->stream_info.had_substream;
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	switch (event.type) {
 	case HAD_EVENT_QUERY_IS_AUDIO_BUSY:
 		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
@@ -98,14 +98,14 @@ int hdmi_audio_query(void *haddata, struct hdmi_audio_event event)
 int hdmi_audio_suspend(void *haddata)
 {
 	int caps, retval = 0;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 	struct snd_pcm_substream *substream;
 	struct snd_intelhad *intelhaddata = (struct snd_intelhad *)haddata;
 
 	pr_debug("Enter:%s\n", __func__);
 
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	substream = intelhaddata->stream_info.had_substream;
 
 	if (intelhaddata->dev->power.runtime_status != RPM_SUSPENDED) {
@@ -199,10 +199,10 @@ static inline int had_chk_intrmiss(struct snd_intelhad *intelhaddata,
 	int i, intr_count = 0;
 	enum intel_had_aud_buf_type buff_done;
 	u32 buf_size, buf_addr;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 
 	buff_done = buf_id;
 
@@ -244,12 +244,12 @@ int had_process_buffer_done(struct snd_intelhad *intelhaddata)
 	enum intel_had_aud_buf_type buff_done;
 	struct pcm_stream_info *stream;
 	u32 buf_size;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	int intr_count;
 	enum had_status_stream		stream_type;
 	unsigned long flag_irqs;
 
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 	intr_count = 1;
 
@@ -331,12 +331,12 @@ int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct pcm_stream_info *stream;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	enum had_status_stream stream_type;
 	unsigned long flag_irqs;
 	int drv_status;
 
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	stream = &intelhaddata->stream_info;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
@@ -372,13 +372,13 @@ int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 
 	pr_debug("Enter:%s\n", __func__);
 
 	substream = intelhaddata->stream_info.had_substream;
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
 	if (intelhaddata->drv_status == HAD_DRV_CONNECTED) {
@@ -413,12 +413,12 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	int caps, retval = 0;
 	enum intel_had_aud_buf_type buf_id;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 
 	pr_debug("Enter:%s\n", __func__);
 
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 	buf_id = intelhaddata->curr_buf;
 
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
@@ -476,11 +476,11 @@ int had_event_handler(enum had_event_type event_type, void *data)
 	struct snd_intelhad *intelhaddata = data;
 	enum intel_had_aud_buf_type buf_id;
 	struct snd_pcm_substream *substream;
-	struct had_pvt_data *had_stream;
+	struct had_stream_data *had_stream;
 	unsigned long flag_irqs;
 
 	buf_id = intelhaddata->curr_buf;
-	had_stream = intelhaddata->private_data;
+	had_stream = &intelhaddata->stream_data;
 
 	/* Switching to a function can drop atomicity even in INTR context.
 	 * Thus, a big lock is acquired to maintain atomicity.
-- 
2.11.0
