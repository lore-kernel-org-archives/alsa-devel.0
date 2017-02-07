From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: x86: Support S16 format
Date: Tue,  7 Feb 2017 14:11:19 +0100
Message-ID: <20170207131122.6345-4-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 732AA266FD8
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 14:11:26 +0100 (CET)
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

Now we support S16 PCM format in addition.  For this, we need to set
packet_mode=1 in AUD_CONFIG register.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index a0401476cd93..5697552f489a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -136,7 +136,8 @@ static const struct snd_pcm_hardware had_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP|
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH),
-	.formats = (SNDRV_PCM_FMTBIT_S24_LE |
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+		    SNDRV_PCM_FMTBIT_S24_LE |
 		    SNDRV_PCM_FMTBIT_S32_LE),
 	.rates = SNDRV_PCM_RATE_32000 |
 		SNDRV_PCM_RATE_44100 |
@@ -308,12 +309,10 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
 			   AUD_CH_STATUS_0, ch_stat0.regval);
 
 	switch (substream->runtime->format) {
-#if 0 /* FIXME: not supported yet */
 	case SNDRV_PCM_FORMAT_S16_LE:
 		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_20;
 		ch_stat1.regx.wrd_len = SMPL_WIDTH_16BITS;
 		break;
-#endif
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		ch_stat1.regx.max_wrd_len = MAX_SMPL_WIDTH_24;
@@ -354,6 +353,9 @@ static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
 	else
 		cfg_val.regx.layout = LAYOUT1;
 
+	if (substream->runtime->format == SNDRV_PCM_FORMAT_S16_LE)
+		cfg_val.regx.packet_mode = 1;
+
 	if (substream->runtime->format == SNDRV_PCM_FORMAT_S32_LE)
 		cfg_val.regx.left_align = 1;
 
-- 
2.11.0
