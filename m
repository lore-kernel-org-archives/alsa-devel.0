From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: x86: Don't pass SNDRV_PCM_INFO_BATCH
	flag
Date: Tue,  7 Feb 2017 14:11:20 +0100
Message-ID: <20170207131122.6345-5-tiwai@suse.de>
References: <20170207131122.6345-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 318EE266FD0
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

The PCM engine on LPE audio isn't like a batch-style process any
longer, but rather it deals with the standard ring buffer.  Remove the
BATCH info flag so that PA can handle the buffer in timer-sched mode.

Similarly, the DOUBLE flag is also superfluous.  Drop both bits.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5697552f489a..8f87ac3057c6 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -132,10 +132,8 @@ static const struct channel_map_table map_tables[] = {
 /* hardware capability structure */
 static const struct snd_pcm_hardware had_pcm_hardware = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_DOUBLE |
-		SNDRV_PCM_INFO_MMAP|
-		SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_BATCH),
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
 		    SNDRV_PCM_FMTBIT_S24_LE |
 		    SNDRV_PCM_FMTBIT_S32_LE),
-- 
2.11.0
