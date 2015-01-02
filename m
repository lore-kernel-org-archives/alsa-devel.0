From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/21] ASLA: ad1889: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:44 +0100
Message-ID: <1420197895-17696-11-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id E6187260536
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:12 +0100 (CET)
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

snd_ad1889_pcm_init() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/ad1889.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 1610c38..547ee30 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -623,14 +623,11 @@ snd_ad1889_interrupt(int irq, void *dev_id)
 }
 
 static int
-snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
+snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device)
 {
 	int err;
 	struct snd_pcm *pcm;
 
-	if (rpcm)
-		*rpcm = NULL;
-
 	err = snd_pcm_new(chip->card, chip->card->driver, device, 1, 1, &pcm);
 	if (err < 0)
 		return err;
@@ -658,9 +655,6 @@ snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 		return err;
 	}
 	
-	if (rpcm)
-		*rpcm = pcm;
-	
 	return 0;
 }
 
@@ -1016,7 +1010,7 @@ snd_ad1889_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto free_and_ret;
 	
-	err = snd_ad1889_pcm_init(chip, 0, NULL);
+	err = snd_ad1889_pcm_init(chip, 0);
 	if (err < 0)
 		goto free_and_ret;
 
-- 
1.8.0
