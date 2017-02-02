From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 38/53] ALSA: x86: Fix racy access to chmap
Date: Thu,  2 Feb 2017 18:02:52 +0100
Message-ID: <20170202170307.24484-40-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3E25267596
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:17 +0100 (CET)
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

The access to chmap can be racy against the hotplug process, where it
recreates the chmap on the fly.  For protecting against it, a mutex is
introduced in this patch.  It's also used for protecting the change /
reference of eld and state fields, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 32 +++++++++++++++++++++++---------
 sound/x86/intel_hdmi_audio.h |  1 +
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 046af2367fba..c0cb59e6a89b 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -555,11 +555,17 @@ static int had_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
 		return -ENODEV;
-	if (!intelhaddata->chmap->chmap)
+
+	mutex_lock(&intelhaddata->mutex);
+	if (!intelhaddata->chmap->chmap) {
+		mutex_unlock(&intelhaddata->mutex);
 		return -ENODATA;
+	}
+
 	chmap = intelhaddata->chmap->chmap;
 	for (i = 0; i < chmap->channels; i++)
 		ucontrol->value.integer.value[i] = chmap->map[i];
+	mutex_unlock(&intelhaddata->mutex);
 
 	return 0;
 }
@@ -1352,6 +1358,7 @@ static int snd_intelhad_pcm_mmap(struct snd_pcm_substream *substream,
 			vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
+/* process mode change of the running stream; called in mutex */
 static int hdmi_audio_mode_change(struct snd_intelhad *intelhaddata)
 {
 	struct snd_pcm_substream *substream;
@@ -1642,7 +1649,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
-/* process hot plug, called from wq */
+/* process hot plug, called from wq with mutex locked */
 static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
@@ -1682,7 +1689,7 @@ static int had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	return 0;
 }
 
-/* process hot unplug, called from wq */
+/* process hot unplug, called from wq with mutex locked */
 static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	enum intel_had_aud_buf_type buf_id;
@@ -1751,12 +1758,14 @@ static int had_iec958_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_intelhad *intelhaddata = snd_kcontrol_chip(kcontrol);
 
+	mutex_lock(&intelhaddata->mutex);
 	ucontrol->value.iec958.status[0] = (intelhaddata->aes_bits >> 0) & 0xff;
 	ucontrol->value.iec958.status[1] = (intelhaddata->aes_bits >> 8) & 0xff;
 	ucontrol->value.iec958.status[2] =
 					(intelhaddata->aes_bits >> 16) & 0xff;
 	ucontrol->value.iec958.status[3] =
 					(intelhaddata->aes_bits >> 24) & 0xff;
+	mutex_unlock(&intelhaddata->mutex);
 	return 0;
 }
 
@@ -1775,16 +1784,19 @@ static int had_iec958_put(struct snd_kcontrol *kcontrol,
 {
 	unsigned int val;
 	struct snd_intelhad *intelhaddata = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
 
 	val = (ucontrol->value.iec958.status[0] << 0) |
 		(ucontrol->value.iec958.status[1] << 8) |
 		(ucontrol->value.iec958.status[2] << 16) |
 		(ucontrol->value.iec958.status[3] << 24);
+	mutex_lock(&intelhaddata->mutex);
 	if (intelhaddata->aes_bits != val) {
 		intelhaddata->aes_bits = val;
-		return 1;
+		changed = 1;
 	}
-	return 1;
+	mutex_unlock(&intelhaddata->mutex);
+	return changed;
 }
 
 static struct snd_kcontrol_new had_control_iec958_mask = {
@@ -1837,6 +1849,7 @@ static void had_audio_wq(struct work_struct *work)
 		container_of(work, struct snd_intelhad, hdmi_audio_wq);
 	struct intel_hdmi_lpe_audio_pdata *pdata = ctx->dev->platform_data;
 
+	mutex_lock(&ctx->mutex);
 	if (!pdata->hdmi_connected) {
 		dev_dbg(ctx->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
 			__func__);
@@ -1844,12 +1857,11 @@ static void had_audio_wq(struct work_struct *work)
 		if (ctx->state != hdmi_connector_status_connected) {
 			dev_dbg(ctx->dev, "%s: Already Unplugged!\n",
 				__func__);
-			return;
+		} else {
+			ctx->state = hdmi_connector_status_disconnected;
+			had_process_hot_unplug(ctx);
 		}
 
-		ctx->state = hdmi_connector_status_disconnected;
-		had_process_hot_unplug(ctx);
-
 	} else {
 		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
 
@@ -1888,6 +1900,7 @@ static void had_audio_wq(struct work_struct *work)
 				hdmi_audio_mode_change(ctx);
 		}
 	}
+	mutex_unlock(&ctx->mutex);
 }
 
 /* release resources */
@@ -1948,6 +1961,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	ctx = card->private_data;
 	spin_lock_init(&ctx->had_spinlock);
+	mutex_init(&ctx->mutex);
 	ctx->drv_status = HAD_DRV_DISCONNECTED;
 	ctx->dev = &pdev->dev;
 	ctx->card = card;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 8b85a5668d83..be24682e3946 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -139,6 +139,7 @@ struct snd_intelhad {
 	void __iomem *mmio_start;
 	unsigned int had_config_offset;
 	struct work_struct hdmi_audio_wq;
+	struct mutex mutex; /* for protecting chmap, state and eld */
 };
 
 #endif /* _INTEL_HDMI_AUDIO_ */
-- 
2.11.0
