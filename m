From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/20] ALSA: sparc: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:07 +0100
Message-ID: <20190205194221.25924-7-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46858267905
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:28 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sparc/dbri.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 7609eceba1a2..fc34c863b93c 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2243,12 +2243,9 @@ static int snd_dbri_pcm(struct snd_card *card)
 	pcm->info_flags = 0;
 	strcpy(pcm->name, card->shortname);
 
-	if ((err = snd_pcm_lib_preallocate_pages_for_all(pcm,
-			SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL),
-			64 * 1024, 64 * 1024)) < 0)
-		return err;
-
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+					      snd_dma_continuous_data(GFP_KERNEL),
+					      64 * 1024, 64 * 1024);
 	return 0;
 }
 
-- 
2.16.4
