From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 30/53] ALSA: x86: Drop superfluous PCM
	private_free
Date: Thu,  2 Feb 2017 18:02:44 +0100
Message-ID: <20170202170307.24484-32-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CAB726757B
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

snd_pcm_lib_preallocate_free_for_all() doesn't have to be called from
each driver as it's called in the PCM core.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 0a14f5dacb00..28eb980d2d2e 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1792,17 +1792,6 @@ static struct snd_pcm_ops snd_intelhad_playback_ops = {
 	.mmap =	snd_intelhad_pcm_mmap,
 };
 
-/*
- * snd_intelhad_pcm_free - to free the memory allocated
- *
- * @pcm: pointer to pcm instance
- * This function is called when the device is removed
- */
-static void snd_intelhad_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static int had_iec958_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
@@ -2063,7 +2052,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	/* setup private data which can be retrieved when required */
 	pcm->private_data = ctx;
-	pcm->private_free = snd_intelhad_pcm_free;
 	pcm->info_flags = 0;
 	strncpy(pcm->name, card->shortname, strlen(card->shortname));
 	/* setup the ops for playabck */
-- 
2.11.0
