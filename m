From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 2/5] ALSA: emu10k1: use dma_set_mask_and_coherent()
Date: Sun, 21 Jan 2018 17:26:58 +0100
Message-ID: <b2925b7c-46b5-a6de-226b-b8740299640b@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have been calling dma_set_mask() and then dma_set_coherent_mask() with
the same value, but there is a dma_set_mask_and_coherent() function that
does exactly that so let's use it instead.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/pci/emu10k1/emu10k1_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index a0a4d31ded53..11e868f569d6 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1871,8 +1871,7 @@ int snd_emu10k1_create(struct snd_card *card,
 	emu->address_mode = is_audigy ? 0 : 1;
 	/* set the DMA transfer mask */
 	emu->dma_mask = emu->address_mode ? EMU10K1_DMA_MASK : AUDIGY_DMA_MASK;
-	if (dma_set_mask(&pci->dev, emu->dma_mask) < 0 ||
-	    dma_set_coherent_mask(&pci->dev, emu->dma_mask) < 0) {
+	if (dma_set_mask_and_coherent(&pci->dev, emu->dma_mask) < 0) {
 		dev_err(card->dev,
 			"architecture does not support PCI busmaster DMA with mask 0x%lx\n",
 			emu->dma_mask);
