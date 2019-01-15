From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/14] ALSA: ppc: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:49 +0100
Message-ID: <20190115162155.6308-9-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E82726745A
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
 sound/ppc/pmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index d692e4070167..6d420bd3ae17 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -1365,7 +1365,6 @@ void snd_pmac_suspend(struct snd_pmac *chip)
 	snd_power_change_state(chip->card, SNDRV_CTL_POWER_D3hot);
 	if (chip->suspend)
 		chip->suspend(chip);
-	snd_pcm_suspend_all(chip->pcm);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	snd_pmac_beep_stop(chip);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
-- 
2.20.1
