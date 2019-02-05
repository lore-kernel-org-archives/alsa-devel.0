From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/20] ALSA: ppc: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:05 +0100
Message-ID: <20190205194221.25924-5-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B7AA2678FD
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:26 +0100 (CET)
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
 sound/ppc/snd_ps3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index abe031c9d592..521236efcc4d 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -1024,15 +1024,11 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 
 	the_card.pcm->info_flags = SNDRV_PCM_INFO_NONINTERLEAVED;
 	/* pre-alloc PCM DMA buffer*/
-	ret = snd_pcm_lib_preallocate_pages_for_all(the_card.pcm,
+	snd_pcm_lib_preallocate_pages_for_all(the_card.pcm,
 					SNDRV_DMA_TYPE_DEV,
 					&dev->core,
 					SND_PS3_PCM_PREALLOC_SIZE,
 					SND_PS3_PCM_PREALLOC_SIZE);
-	if (ret < 0) {
-		pr_info("%s: prealloc failed\n", __func__);
-		goto clean_card;
-	}
 
 	/*
 	 * allocate null buffer
-- 
2.16.4
