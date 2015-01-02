From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/21] ALSA: ice1712: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:51 +0100
Message-ID: <1420197895-17696-18-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF002604BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:21 +0100 (CET)
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

The various PCM allocation functions in this driver take a pointer to a
pointer of a PCM where if this parameter is provided the newly allocated PCM
is stored. All callers pass NULL though, so remove the parameter. This makes
the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/ice1712/ice1712.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index b039b46..a2ee2982 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -880,13 +880,11 @@ static struct snd_pcm_ops snd_ice1712_capture_ops = {
 	.pointer =	snd_ice1712_capture_pointer,
 };
 
-static int snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ice->card, "ICE1712 consumer", device, 1, 1, &pcm);
 	if (err < 0)
 		return err;
@@ -902,22 +900,17 @@ static int snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct snd_pcm *
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(ice->pci), 64*1024, 64*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	dev_warn(ice->card->dev,
 		 "Consumer PCM code does not work well at the moment --jk\n");
 
 	return 0;
 }
 
-static int snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ice->card, "ICE1712 consumer (DS)", device, 6, 0, &pcm);
 	if (err < 0)
 		return err;
@@ -932,9 +925,6 @@ static int snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device, struct snd_pc
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(ice->pci), 64*1024, 128*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
-
 	return 0;
 }
 
@@ -1260,13 +1250,11 @@ static struct snd_pcm_ops snd_ice1712_capture_pro_ops = {
 	.pointer =	snd_ice1712_capture_pro_pointer,
 };
 
-static int snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(ice->card, "ICE1712 multi", device, 1, 1, &pcm);
 	if (err < 0)
 		return err;
@@ -1282,8 +1270,6 @@ static int snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device, struct snd
 					      snd_dma_pci_data(ice->pci), 256*1024, 256*1024);
 
 	ice->pcm_pro = pcm;
-	if (rpcm)
-		*rpcm = pcm;
 
 	if (ice->cs8427) {
 		/* assign channels to iec958 */
@@ -2691,14 +2677,14 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 	c = &no_matched;
  __found:
 
-	err = snd_ice1712_pcm_profi(ice, pcm_dev++, NULL);
+	err = snd_ice1712_pcm_profi(ice, pcm_dev++);
 	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
 	if (ice_has_con_ac97(ice)) {
-		err = snd_ice1712_pcm(ice, pcm_dev++, NULL);
+		err = snd_ice1712_pcm(ice, pcm_dev++);
 		if (err < 0) {
 			snd_card_free(card);
 			return err;
@@ -2726,7 +2712,7 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 	}
 
 	if (ice_has_con_ac97(ice)) {
-		err = snd_ice1712_pcm_ds(ice, pcm_dev++, NULL);
+		err = snd_ice1712_pcm_ds(ice, pcm_dev++);
 		if (err < 0) {
 			snd_card_free(card);
 			return err;
-- 
1.8.0
