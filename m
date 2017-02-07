From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: x86: Allow no-period-wakeup setup
Date: Tue,  7 Feb 2017 14:11:22 +0100
Message-ID: <20170207131122.6345-7-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34166266FD2
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

In the current implementation, the driver may update the BDs even at
PCM pointer callback.  This allows us to skip the period interrupt
effectively.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 979b396272ae..9dacac2b833c 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -133,7 +133,8 @@ static const struct channel_map_table map_tables[] = {
 static const struct snd_pcm_hardware had_pcm_hardware = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_MMAP_VALID),
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
 		    SNDRV_PCM_FMTBIT_S24_LE |
 		    SNDRV_PCM_FMTBIT_S32_LE),
@@ -864,7 +865,9 @@ static void had_prog_bd(struct snd_pcm_substream *substream,
 	int ofs = intelhaddata->pcmbuf_filled * intelhaddata->period_bytes;
 	u32 addr = substream->runtime->dma_addr + ofs;
 
-	addr |= AUD_BUF_VALID | AUD_BUF_INTR_EN;
+	addr |= AUD_BUF_VALID;
+	if (!substream->runtime->no_period_wakeup)
+		addr |= AUD_BUF_INTR_EN;
 	had_write_register(intelhaddata, AUD_BUF_ADDR(idx), addr);
 	had_write_register(intelhaddata, AUD_BUF_LEN(idx),
 			   intelhaddata->period_bytes);
-- 
2.11.0
