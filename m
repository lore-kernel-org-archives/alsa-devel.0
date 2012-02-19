From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ALSA: pxa2xx-pcm: replace 0xffffffff with
 DMA_BIT_MASK macro
Date: Sun, 19 Feb 2012 15:40:19 +0800
Message-ID: <1329637219.4818.5.camel@phoenix>
References: <1329637158.4818.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 97EDF103BF8
	for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2012 08:40:25 +0100 (CET)
Received: by pbbrp2 with SMTP id rp2so5504829pbb.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2012 23:40:24 -0800 (PST)
In-Reply-To: <1329637158.4818.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Iwai <tiwai@suse.de>, Takashi@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/arm/pxa2xx-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm.c b/sound/arm/pxa2xx-pcm.c
index 26422a3..cbe6374 100644
--- a/sound/arm/pxa2xx-pcm.c
+++ b/sound/arm/pxa2xx-pcm.c
@@ -80,7 +80,7 @@ static struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.mmap		= pxa2xx_pcm_mmap,
 };
 
-static u64 pxa2xx_pcm_dmamask = 0xffffffff;
+static u64 pxa2xx_pcm_dmamask = DMA_BIT_MASK(32);
 
 int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
 		   struct snd_pcm **rpcm)
@@ -100,7 +100,7 @@ int pxa2xx_pcm_new(struct snd_card *card, struct pxa2xx_pcm_client *client,
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &pxa2xx_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = 0xffffffff;
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	if (play) {
 		int stream = SNDRV_PCM_STREAM_PLAYBACK;
-- 
1.7.5.4
