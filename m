From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: wss: Fix invalid snd_free_pages() at
	error path
Date: Fri, 23 Nov 2018 18:19:55 +0100
Message-ID: <20181123171956.9236-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C2FD26770D
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 18:19:57 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A54D2AD94
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 17:19:57 +0000 (UTC)
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
remain in the error paths of wss driver code.  Since runtime->dma_area
is managed by the PCM core helper, we shouldn't release manually.

Drop the superfluous calls.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/wss/wss_lib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 32453f81b95a..3a5008837576 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1531,7 +1531,6 @@ static int snd_wss_playback_open(struct snd_pcm_substream *substream)
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma1);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->playback_substream = substream;
@@ -1572,7 +1571,6 @@ static int snd_wss_capture_open(struct snd_pcm_substream *substream)
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma2);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->capture_substream = substream;
-- 
2.19.1
