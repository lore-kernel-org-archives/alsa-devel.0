From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/21] ALSA: ml403-ac97cr: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:35 +0100
Message-ID: <1420197895-17696-2-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id A330D26049F
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:00 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

snd_ml403_ac97cr_pcm() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/drivers/ml403-ac97cr.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index bcca825..ec01de1 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1238,14 +1238,11 @@ snd_ml403_ac97cr_mixer(struct snd_ml403_ac97cr *ml403_ac97cr)
 }
 
 static int
-snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
-		     struct snd_pcm **rpcm)
+snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ml403_ac97cr->card, "ML403AC97CR/1", device, 1, 1,
 			  &pcm);
 	if (err < 0)
@@ -1263,8 +1260,6 @@ snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
 					  snd_dma_continuous_data(GFP_KERNEL),
 					  64 * 1024,
 					  128 * 1024);
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1298,7 +1293,7 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 		return err;
 	}
 	PDEBUG(INIT_INFO, "probe(): mixer done\n");
-	err = snd_ml403_ac97cr_pcm(ml403_ac97cr, 0, NULL);
+	err = snd_ml403_ac97cr_pcm(ml403_ac97cr, 0);
 	if (err < 0) {
 		snd_card_free(card);
 		return err;
-- 
1.8.0
