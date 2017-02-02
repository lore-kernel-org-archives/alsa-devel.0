From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/53] ALSA: x86: Move the global
	underrun_count to struct snd_intelhad
Date: Thu,  2 Feb 2017 18:02:30 +0100
Message-ID: <20170202170307.24484-18-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A69C32668E2
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

The last one is in intel_hdmi_audio.c, underrun_count: this can be
embedded in snd_intelhad object.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 15 +++++++--------
 sound/x86/intel_hdmi_audio.h |  2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index ed9db2ebe9cf..e08691110a48 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -40,7 +40,6 @@
 /*standard module options for ALSA. This module supports only one card*/
 static int hdmi_card_index = SNDRV_DEFAULT_IDX1;
 static char *hdmi_card_id = SNDRV_DEFAULT_STR1;
-static int underrun_count;
 
 module_param_named(index, hdmi_card_index, int, 0444);
 MODULE_PARM_DESC(index,
@@ -969,7 +968,7 @@ static int snd_intelhad_open(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 	had_stream = intelhaddata->private_data;
 	runtime = substream->runtime;
-	underrun_count = 0;
+	intelhaddata->underrun_count = 0;
 
 	pm_runtime_get(intelhaddata->dev);
 
@@ -1376,19 +1375,19 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 			  AUD_BUF_A_LENGTH + (buf_id * HAD_REG_WIDTH), &t);
 
 	if ((t == 0) || (t == ((u32)-1L))) {
-		underrun_count++;
+		intelhaddata->underrun_count++;
 		pr_debug("discovered buffer done for buf %d, count = %d\n",
-			buf_id, underrun_count);
+			 buf_id, intelhaddata->underrun_count);
 
-		if (underrun_count > (HAD_MIN_PERIODS/2)) {
+		if (intelhaddata->underrun_count > (HAD_MIN_PERIODS/2)) {
 			pr_debug("assume audio_codec_reset, underrun = %d - do xrun\n",
-				underrun_count);
-			underrun_count = 0;
+				 intelhaddata->underrun_count);
+			intelhaddata->underrun_count = 0;
 			return SNDRV_PCM_POS_XRUN;
 		}
 	} else {
 		/* Reset Counter */
-		underrun_count = 0;
+		intelhaddata->underrun_count = 0;
 	}
 
 	t = intelhaddata->buf_info[buf_id].buf_size - t;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 110d1d083000..da0a927d37fe 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -119,6 +119,7 @@ struct had_pvt_data {
  * @chmap: holds channel map info
  * @audio_reg_base: hdmi audio register base offset
  * @hw_silence: flag indicates SoC support for HW silence/Keep alive
+ * @underrun_count: PCM stream underrun counter
  */
 struct snd_intelhad {
 	struct snd_card	*card;
@@ -142,6 +143,7 @@ struct snd_intelhad {
 	unsigned int	*audio_reg_base;
 	unsigned int	audio_cfg_offset;
 	bool		hw_silence;
+	int underrun_count;
 };
 
 int had_event_handler(enum had_event_type event_type, void *data);
-- 
2.11.0
