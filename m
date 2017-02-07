From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: x86: Drop suspicious U24 format
	support
Date: Tue,  7 Feb 2017 09:45:04 +0100
Message-ID: <20170207084505.18134-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2263E2668D1
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 09:45:07 +0100 (CET)
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

U24 format is declared to be supported by the driver, but this looks
really doubtful, as there is no corresponding code.  Better to drop
it.  This format is very uncommon, so there should be practically no
impact by this change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8978dc9bf579..11ee4dddc5dd 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -136,8 +136,7 @@ static const struct snd_pcm_hardware had_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP|
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH),
-	.formats = (SNDRV_PCM_FMTBIT_S24 |
-		SNDRV_PCM_FMTBIT_U24),
+	.formats = SNDRV_PCM_FMTBIT_S24,
 	.rates = SNDRV_PCM_RATE_32000 |
 		SNDRV_PCM_RATE_44100 |
 		SNDRV_PCM_RATE_48000 |
-- 
2.11.0
