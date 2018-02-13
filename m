From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 2/5] ALSA: emu10k1: use
	dma_set_mask_and_coherent()
Date: Wed, 14 Feb 2018 00:05:16 +0100
Message-ID: <d1483681-e04f-ef2e-57fe-2ad9cfee2feb@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id D44FE2679D9
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 00:05:17 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

We have been calling dma_set_mask() and then dma_set_coherent_mask() with
the same value, but there is a dma_set_mask_and_coherent() function that
does exactly that so let's use it instead.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1, v2: None in this patch.

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
