From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: x86: Don't pass SNDRV_PCM_INFO_BATCH
	flag
Date: Fri,  3 Feb 2017 17:43:57 +0100
Message-ID: <20170203164400.12983-2-tiwai@suse.de>
References: <20170203164400.12983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3E3266B58
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 17:44:03 +0100 (CET)
In-Reply-To: <20170203164400.12983-1-tiwai@suse.de>
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

The PCM engine on LPE audio isn't like a batch-style process, but
rather it deals with the standard ring buffer.  Passing the BATCH info
flag is inappropriate.

Similarly, the DOUBLE flag is also superfluous.  Drop both bits.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index c83f02c2593e..32a21422e6f5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -131,10 +131,8 @@ static const struct channel_map_table map_tables[] = {
 /* hardware capability structure */
 static const struct snd_pcm_hardware snd_intel_hadstream = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_DOUBLE |
 		SNDRV_PCM_INFO_MMAP|
-		SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_BATCH),
+		SNDRV_PCM_INFO_MMAP_VALID),
 	.formats = (SNDRV_PCM_FMTBIT_S24 |
 		SNDRV_PCM_FMTBIT_U24),
 	.rates = SNDRV_PCM_RATE_32000 |
-- 
2.11.0
