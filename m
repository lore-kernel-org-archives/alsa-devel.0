From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 3/4] pcm: hw: Remove superfluous call
	of snd_pcm_set_appl_ptr()
Date: Tue, 20 Jun 2017 17:35:23 +0200
Message-ID: <20170620153524.28099-4-tiwai@suse.de>
References: <20170620153524.28099-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D04A026734B
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 17:35:28 +0200 (CEST)
In-Reply-To: <20170620153524.28099-1-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

There is a call of snd_pcm_set_appl_ptr() in snd_pcm_hw_hw_params()
only for the capture direction.  This must be a leftover from the
ancient code.  Although it's harmless for now, it's superfluous and
confusing.  Let's kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_hw.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 2775483f1933..721b18d2bbbb 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -342,14 +342,7 @@ static int snd_pcm_hw_hw_params(snd_pcm_t *pcm, snd_pcm_hw_params_t * params)
 	params->info &= ~0xf0000000;
 	if (pcm->tstamp_type != SND_PCM_TSTAMP_TYPE_GETTIMEOFDAY)
 		params->info |= SND_PCM_INFO_MONOTONIC;
-	err = sync_ptr(hw, 0);
-	if (err < 0)
-		return err;
-	if (pcm->stream == SND_PCM_STREAM_CAPTURE) {
-		snd_pcm_set_appl_ptr(pcm, &hw->mmap_control->appl_ptr, hw->fd,
-				     SNDRV_PCM_MMAP_OFFSET_CONTROL);
-	}
-	return 0;
+	return sync_ptr(hw, 0);
 }
 
 static void snd_pcm_hw_close_timer(snd_pcm_hw_t *hw)
-- 
2.13.1
