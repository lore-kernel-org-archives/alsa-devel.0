From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/14] ALSA: arm: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:51 +0100
Message-ID: <20190115162155.6308-11-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B92F26745C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/arm/aaci.c        | 1 -
 sound/arm/pxa2xx-ac97.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0114ffed56dd..0c3f073e2600 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -757,7 +757,6 @@ static int aaci_do_suspend(struct snd_card *card)
 {
 	struct aaci *aaci = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
-	snd_pcm_suspend_all(aaci->pcm);
 	return 0;
 }
 
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 1f72672262d0..68fe5bb11eea 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -124,7 +124,6 @@ static int pxa2xx_ac97_do_suspend(struct snd_card *card)
 	pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
-	snd_pcm_suspend_all(pxa2xx_ac97_pcm);
 	snd_ac97_suspend(pxa2xx_ac97_ac97);
 	if (platform_ops && platform_ops->suspend)
 		platform_ops->suspend(platform_ops->priv);
-- 
2.20.1
