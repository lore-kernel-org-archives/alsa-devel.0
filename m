From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 20/21] ALSA: trident: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:54 +0100
Message-ID: <1420197895-17696-21-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C8F32605A8
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:24 +0100 (CET)
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
is stored. All callers pass NULL though, so remove the parameter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/trident/trident.c      |  6 +++---
 sound/pci/trident/trident.h      |  6 +++---
 sound/pci/trident/trident_main.c | 21 +++------------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index a54cd68..cedf13b 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -127,21 +127,21 @@ static int snd_trident_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s PCI Audio at 0x%lx, irq %d",
 		card->shortname, trident->port, trident->irq);
 
-	if ((err = snd_trident_pcm(trident, pcm_dev++, NULL)) < 0) {
+	if ((err = snd_trident_pcm(trident, pcm_dev++)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	switch (trident->device) {
 	case TRIDENT_DEVICE_ID_DX:
 	case TRIDENT_DEVICE_ID_NX:
-		if ((err = snd_trident_foldback_pcm(trident, pcm_dev++, NULL)) < 0) {
+		if ((err = snd_trident_foldback_pcm(trident, pcm_dev++)) < 0) {
 			snd_card_free(card);
 			return err;
 		}
 		break;
 	}
 	if (trident->device == TRIDENT_DEVICE_ID_NX || trident->device == TRIDENT_DEVICE_ID_SI7018) {
-		if ((err = snd_trident_spdif_pcm(trident, pcm_dev++, NULL)) < 0) {
+		if ((err = snd_trident_spdif_pcm(trident, pcm_dev++)) < 0) {
 			snd_card_free(card);
 			return err;
 		}
diff --git a/sound/pci/trident/trident.h b/sound/pci/trident/trident.h
index 5f110eb..9624e59 100644
--- a/sound/pci/trident/trident.h
+++ b/sound/pci/trident/trident.h
@@ -420,9 +420,9 @@ int snd_trident_create(struct snd_card *card,
 		       struct snd_trident ** rtrident);
 int snd_trident_create_gameport(struct snd_trident *trident);
 
-int snd_trident_pcm(struct snd_trident * trident, int device, struct snd_pcm **rpcm);
-int snd_trident_foldback_pcm(struct snd_trident * trident, int device, struct snd_pcm **rpcm);
-int snd_trident_spdif_pcm(struct snd_trident * trident, int device, struct snd_pcm **rpcm);
+int snd_trident_pcm(struct snd_trident *trident, int device);
+int snd_trident_foldback_pcm(struct snd_trident *trident, int device);
+int snd_trident_spdif_pcm(struct snd_trident *trident, int device);
 int snd_trident_attach_synthesizer(struct snd_trident * trident);
 struct snd_trident_voice *snd_trident_alloc_voice(struct snd_trident * trident, int type,
 					     int client, int port);
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 57cd757..c380c99 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2172,14 +2172,11 @@ static struct snd_pcm_ops snd_trident_spdif_7018_ops = {
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_pcm(struct snd_trident *trident,
-		    int device, struct snd_pcm **rpcm)
+int snd_trident_pcm(struct snd_trident *trident, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(trident->card, "trident_dx_nx", device, trident->ChanPCM, 1, &pcm)) < 0)
 		return err;
 
@@ -2214,8 +2211,6 @@ int snd_trident_pcm(struct snd_trident *trident,
 						      snd_dma_pci_data(trident->pci), 64*1024, 128*1024);
 	}
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -2230,16 +2225,13 @@ int snd_trident_pcm(struct snd_trident *trident,
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_foldback_pcm(struct snd_trident *trident,
-			     int device, struct snd_pcm **rpcm)
+int snd_trident_foldback_pcm(struct snd_trident *trident, int device)
 {
 	struct snd_pcm *foldback;
 	int err;
 	int num_chan = 3;
 	struct snd_pcm_substream *substream;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if (trident->device == TRIDENT_DEVICE_ID_NX)
 		num_chan = 4;
 	if ((err = snd_pcm_new(trident->card, "trident_dx_nx", device, 0, num_chan, &foldback)) < 0)
@@ -2271,8 +2263,6 @@ int snd_trident_foldback_pcm(struct snd_trident *trident,
 		snd_pcm_lib_preallocate_pages_for_all(foldback, SNDRV_DMA_TYPE_DEV,
 						      snd_dma_pci_data(trident->pci), 64*1024, 128*1024);
 
-	if (rpcm)
-		*rpcm = foldback;
 	return 0;
 }
 
@@ -2287,14 +2277,11 @@ int snd_trident_foldback_pcm(struct snd_trident *trident,
   
   ---------------------------------------------------------------------------*/
 
-int snd_trident_spdif_pcm(struct snd_trident *trident,
-			  int device, struct snd_pcm **rpcm)
+int snd_trident_spdif_pcm(struct snd_trident *trident, int device)
 {
 	struct snd_pcm *spdif;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(trident->card, "trident_dx_nx IEC958", device, 1, 0, &spdif)) < 0)
 		return err;
 
@@ -2310,8 +2297,6 @@ int snd_trident_spdif_pcm(struct snd_trident *trident,
 
 	snd_pcm_lib_preallocate_pages_for_all(spdif, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(trident->pci), 64*1024, 128*1024);
 
-	if (rpcm)
-		*rpcm = spdif;
 	return 0;
 }
 
-- 
1.8.0
