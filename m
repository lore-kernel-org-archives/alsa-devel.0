From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: sparc: Fix invalid snd_free_pages()
	at error path
Date: Fri, 23 Nov 2018 18:19:56 +0100
Message-ID: <20181123171956.9236-2-tiwai@suse.de>
References: <20181123171956.9236-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DEE72677E8
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 18:19:57 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B267AAE78
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 17:19:57 +0000 (UTC)
In-Reply-To: <20181123171956.9236-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Some spurious calls of snd_free_pages() have been overlooked and
remain in the error paths of sparc cs4231 driver code.  Since
runtime->dma_area is managed by the PCM core helper, we shouldn't
release manually.

Drop the superfluous calls.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sparc/cs4231.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index e73c962590eb..079063d8038d 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1146,10 +1146,8 @@ static int snd_cs4231_playback_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_cs4231_playback;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_PLAY);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->playback_substream = substream;
 	chip->p_periods_sent = 0;
 	snd_pcm_set_sync(substream);
@@ -1167,10 +1165,8 @@ static int snd_cs4231_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_cs4231_capture;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_RECORD);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->capture_substream = substream;
 	chip->c_periods_sent = 0;
 	snd_pcm_set_sync(substream);
-- 
2.19.1
