From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/20] ALSA: parisc: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:03 +0100
Message-ID: <20190205194221.25924-3-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 25158267374
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
 sound/parisc/harmony.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index f36e7006e00c..a4264b8943f0 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -669,14 +669,8 @@ snd_harmony_pcm_init(struct snd_harmony *h)
 	}
 
 	/* pre-allocate space for DMA */
-	err = snd_pcm_lib_preallocate_pages_for_all(pcm, h->dma.type,
-						    h->dma.dev,
-						    MAX_BUF_SIZE, 
-						    MAX_BUF_SIZE);
-	if (err < 0) {
-		printk(KERN_ERR PFX "buffer allocation error: %d\n", err);
-		return err;
-	}
+	snd_pcm_lib_preallocate_pages_for_all(pcm, h->dma.type, h->dma.dev,
+					      MAX_BUF_SIZE, MAX_BUF_SIZE);
 
 	h->st.format = snd_harmony_set_data_format(h,
 		SNDRV_PCM_FORMAT_S16_BE, 1);
-- 
2.16.4
