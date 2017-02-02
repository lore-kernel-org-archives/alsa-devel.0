From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 29/53] ALSA: x86: Drop unused fields from
	snd_intelhad struct
Date: Thu,  2 Feb 2017 18:02:43 +0100
Message-ID: <20170202170307.24484-31-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7149F267587
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

Also change the flag_underrun to bool to be clearer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 14 +++++---------
 sound/x86/intel_hdmi_audio.h | 14 +-------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8b25687601ac..0a14f5dacb00 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -593,9 +593,8 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 		return err;
 
 	intelhaddata->chmap->private_data = intelhaddata;
-	intelhaddata->kctl = intelhaddata->chmap->kctl;
-	intelhaddata->kctl->info = had_chmap_ctl_info;
-	intelhaddata->kctl->get = had_chmap_ctl_get;
+	intelhaddata->chmap->kctl->info = had_chmap_ctl_info;
+	intelhaddata->chmap->kctl->get = had_chmap_ctl_get;
 	intelhaddata->chmap->chmap = NULL;
 	return 0;
 }
@@ -1331,7 +1330,7 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 	intelhaddata = snd_pcm_substream_chip(substream);
 
 	if (intelhaddata->flag_underrun) {
-		intelhaddata->flag_underrun = 0;
+		intelhaddata->flag_underrun = false;
 		return SNDRV_PCM_POS_XRUN;
 	}
 
@@ -1690,7 +1689,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 
 	if (stream_type == HAD_RUNNING_STREAM) {
 		/* Report UNDERRUN error to above layers */
-		intelhaddata->flag_underrun = 1;
+		intelhaddata->flag_underrun = true;
 		had_period_elapsed(stream->had_substream);
 	}
 
@@ -1776,7 +1775,6 @@ static int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
-	intelhaddata->audio_reg_base = NULL;
 
 	return 0;
 }
@@ -2019,9 +2017,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	ctx->drv_status = HAD_DRV_DISCONNECTED;
 	ctx->dev = &pdev->dev;
 	ctx->card = card;
-	ctx->card_id = hdmi_card_id;
-	ctx->card_index = card->number;
-	ctx->flag_underrun = 0;
+	ctx->flag_underrun = false;
 	ctx->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
 	strcpy(card->driver, INTEL_HAD);
 	strcpy(card->shortname, INTEL_HAD);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index bcbb4b262fff..4549c4d9d650 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -39,8 +39,6 @@
 #include <sound/pcm.h>
 #include "intel_hdmi_lpe_audio.h"
 
-struct platform_device;
-
 #define PCM_INDEX		0
 #define MAX_PB_STREAMS		1
 #define MAX_CAP_STREAMS		0
@@ -102,8 +100,6 @@ struct had_stream_data {
  * struct snd_intelhad - intelhad driver structure
  *
  * @card: ptr to hold card details
- * @card_index: sound card index
- * @card_id: detected sound card id
  * @drv_status: driver status
  * @buf_info: ring buffer info
  * @stream_info: stream information
@@ -114,15 +110,11 @@ struct had_stream_data {
  * @aes_bits: IEC958 status bits
  * @buff_done: id of current buffer done intr
  * @dev: platoform device handle
- * @kctl: holds kctl ptrs used for channel map
  * @chmap: holds channel map info
- * @audio_reg_base: hdmi audio register base offset
  * @underrun_count: PCM stream underrun counter
  */
 struct snd_intelhad {
 	struct snd_card	*card;
-	int		card_index;
-	char		*card_id;
 	enum had_drv_status	drv_status;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
@@ -131,15 +123,12 @@ struct snd_intelhad {
 	enum		intel_had_aud_buf_type curr_buf;
 	int		valid_buf_cnt;
 	unsigned int	aes_bits;
-	int flag_underrun;
+	bool flag_underrun;
 	struct had_stream_data stream_data;
 	spinlock_t had_spinlock;
 	enum		intel_had_aud_buf_type buff_done;
 	struct device *dev;
-	struct snd_kcontrol *kctl;
 	struct snd_pcm_chmap *chmap;
-	unsigned int	*audio_reg_base;
-	unsigned int	audio_cfg_offset;
 	int underrun_count;
 	enum hdmi_connector_status state;
 	int tmds_clock_speed;
@@ -149,7 +138,6 @@ struct snd_intelhad {
 	int irq;
 	void __iomem *mmio_start;
 	unsigned int had_config_offset;
-	int hdmi_audio_interrupt_mask;
 	struct work_struct hdmi_audio_wq;
 };
 
-- 
2.11.0
