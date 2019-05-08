From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: aica: Fix a long-time build breakage
Date: Wed,  8 May 2019 16:41:19 +0200
Message-ID: <20190508144119.4997-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE7E1F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 16:41:21 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7B6B1AD05
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 14:41:20 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The build of aica sound driver has been broken since the timer API
conversion and some code rewrite.  This patch fixes the breakage by
using the common substream field, as well as a bit cleaning up wrt the
timer handling in the code.

Fixes: d522bb6a105f ("ALSA: sh: aica: Convert timers to use timer_setup()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/aica.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index e7fef3fce44a..a24e486d9d83 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -303,7 +303,7 @@ static void aica_period_elapsed(struct timer_list *t)
 {
 	struct snd_card_aica *dreamcastcard = from_timer(dreamcastcard,
 							      t, timer);
-	struct snd_pcm_substream *substream = dreamcastcard->timer_substream;
+	struct snd_pcm_substream *substream = dreamcastcard->substream;
 	/*timer function - so cannot sleep */
 	int play_period;
 	struct snd_pcm_runtime *runtime;
@@ -335,13 +335,6 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
 	dreamcastcard = substream->pcm->private_data;
 	/*get the queue to do the work */
 	schedule_work(&(dreamcastcard->spu_dma_work));
-	/* Timer may already be running */
-	if (unlikely(dreamcastcard->timer_substream)) {
-		mod_timer(&dreamcastcard->timer, jiffies + 4);
-		return;
-	}
-	timer_setup(&dreamcastcard->timer, aica_period_elapsed, 0);
-	dreamcastcard->timer_substream = substream;
 	mod_timer(&dreamcastcard->timer, jiffies + 4);
 }
 
@@ -379,8 +372,8 @@ static int snd_aicapcm_pcm_close(struct snd_pcm_substream
 {
 	struct snd_card_aica *dreamcastcard = substream->pcm->private_data;
 	flush_work(&(dreamcastcard->spu_dma_work));
-	if (dreamcastcard->timer_substream)
-		del_timer(&dreamcastcard->timer);
+	del_timer(&dreamcastcard->timer);
+	dreamcastcard->substream = NULL;
 	kfree(dreamcastcard->channel);
 	spu_disable();
 	return 0;
@@ -613,6 +606,7 @@ static int snd_aica_probe(struct platform_device *devptr)
 	       "Yamaha AICA Super Intelligent Sound Processor for SEGA Dreamcast");
 	/* Prepare to use the queue */
 	INIT_WORK(&(dreamcastcard->spu_dma_work), run_spu_dma);
+	timer_setup(&dreamcastcard->timer, aica_period_elapsed, 0);
 	/* Load the PCM 'chip' */
 	err = snd_aicapcmchip(dreamcastcard, 0);
 	if (unlikely(err < 0))
-- 
2.16.4
