From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: x86: Support S32 format
Date: Tue,  7 Feb 2017 14:11:18 +0100
Message-ID: <20170207131122.6345-3-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 32CF8266FD1
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:11:24 +0100 (CET)
In-Reply-To: <20170207131122.6345-1-tiwai@suse.de>
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

The hardware has the support for the left-aligned 24bit format in
32bit packet.  This corresponds to S32 format in ALSA.  We need to set
the msbits restriction as well to inform user-space that only MSB
24bit are available.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index eb7044d2f314..a0401476cd93 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -136,7 +136,8 @@ static const struct snd_pcm_hardware had_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP|
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH),
-	.formats = SNDRV_PCM_FMTBIT_S24,
+	.formats = (SNDRV_PCM_FMTBIT_S24_LE |
+		    SNDRV_PCM_FMTBIT_S32_LE),
 	.rates = SNDRV_PCM_RATE_32000 |
 		SNDRV_PCM_RATE_44100 |
 		SNDRV_PCM_RATE_48000 |
@@ -267,7 +268,6 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	union aud_cfg cfg_val = {.regval = 0};
 	union aud_ch_status_0 ch_stat0 = {.regval = 0};
 	union aud_ch_status_1 ch_stat1 = {.regval = 0};
-	int format;
 
 	ch_stat0.regx.lpcm_id = (intelhaddata->aes_bits &
 					  IEC958_AES0_NONAUDIO) >> 1;
@@ -307,17 +307,20 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 	had_write_register(intelhaddata,
 			   AUD_CH_STATUS_0, ch_stat0.regval);
 
-	format = substream->runtime->format;
-
-	if (format == SNDRV_PCM_FORMAT_S16_LE) {
+	switch (substream->runtime->format) {
+#if 0 /* FIXME: not supported yet */
+	case SNDRV_PCM_FORMAT_S16_LE:
 		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_20;
 		ch_stat1.regx.wrd_len = SMPL_WIDTH_16BITS;
-	} else if (format == SNDRV_PCM_FORMAT_S24_LE) {
+		break;
+#endif
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
 		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_24;
 		ch_stat1.regx.wrd_len = SMPL_WIDTH_24BITS;
-	} else {
-		ch_stat1.regx.max_wrd_len = 0;
-		ch_stat1.regx.wrd_len = 0;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	had_write_register(intelhaddata,
@@ -351,6 +354,9 @@ static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
 	else
 		cfg_val.regx.layout = LAYOUT1;
 
+	if (substream->runtime->format == SNDRV_PCM_FORMAT_S32_LE)
+		cfg_val.regx.left_align = 1;
+
 	cfg_val.regx.val_bit = 1;
 
 	/* fix up the DP bits */
@@ -1057,6 +1063,10 @@ static int had_pcm_open(struct snd_pcm_substream *substream)
 	if (retval < 0)
 		goto error;
 
+	retval = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (retval < 0)
+		goto error;
+
 	/* expose PCM substream */
 	spin_lock_irq(&intelhaddata->had_spinlock);
 	intelhaddata->stream_info.substream = substream;
-- 
2.11.0
