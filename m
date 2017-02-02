From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 39/53] ALSA: x86: Drop flag_underrun field
Date: Thu,  2 Feb 2017 18:02:53 +0100
Message-ID: <20170202170307.24484-41-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 19A88266861
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

The flag_underrun flag is used to indicate to escalate the XRUN
reporting at the next position inquiry, but there is a much simpler
method to achieve it: just call snd_pcm_stop_xrun().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 9 +--------
 sound/x86/intel_hdmi_audio.h | 1 -
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c0cb59e6a89b..9ecdd9ad0199 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1297,11 +1297,6 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED)
 		return SNDRV_PCM_POS_XRUN;
 
-	if (intelhaddata->flag_underrun) {
-		intelhaddata->flag_underrun = false;
-		return SNDRV_PCM_POS_XRUN;
-	}
-
 	/* Use a hw register to calculate sub-period position reports.
 	 * This makes PulseAudio happier.
 	 */
@@ -1642,8 +1637,7 @@ static int had_process_buffer_underrun(struct snd_intelhad *intelhaddata)
 
 	if (stream_type == HAD_RUNNING_STREAM) {
 		/* Report UNDERRUN error to above layers */
-		intelhaddata->flag_underrun = true;
-		had_period_elapsed(stream->had_substream);
+		snd_pcm_stop_xrun(stream->had_substream);
 	}
 
 	return 0;
@@ -1965,7 +1959,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	ctx->drv_status = HAD_DRV_DISCONNECTED;
 	ctx->dev = &pdev->dev;
 	ctx->card = card;
-	ctx->flag_underrun = false;
 	ctx->aes_bits = SNDRV_PCM_DEFAULT_CON_SPDIF;
 	strcpy(card->driver, INTEL_HAD);
 	strcpy(card->shortname, INTEL_HAD);
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index be24682e3946..945f6831f1dd 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -123,7 +123,6 @@ struct snd_intelhad {
 	enum		intel_had_aud_buf_type curr_buf;
 	int		valid_buf_cnt;
 	unsigned int	aes_bits;
-	bool flag_underrun;
 	struct had_stream_data stream_data;
 	spinlock_t had_spinlock;
 	enum		intel_had_aud_buf_type buff_done;
-- 
2.11.0
