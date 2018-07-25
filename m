From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: vxpocket: Fix invalid endian
	conversions
Date: Wed, 25 Jul 2018 22:54:26 +0200
Message-ID: <20180725205427.16907-2-tiwai@suse.de>
References: <20180725205427.16907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96362267757
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:54:29 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 39474B05E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 20:54:29 +0000 (UTC)
In-Reply-To: <20180725205427.16907-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The endian conversions used in vxp_dma_read() and vxp_dma_write() are
superfluous and even wrong on big-endian machines, as inw() and outw()
already do conversions.  Kill them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pcmcia/vx/vxp_ops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pcmcia/vx/vxp_ops.c b/sound/pcmcia/vx/vxp_ops.c
index 8cde40226355..4c4ef1fec69f 100644
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -375,7 +375,7 @@ static void vxp_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--) {
-			outw(cpu_to_le16(*addr), port);
+			outw(*addr, port);
 			addr++;
 		}
 		addr = (unsigned short *)runtime->dma_area;
@@ -385,7 +385,7 @@ static void vxp_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--) {
-		outw(cpu_to_le16(*addr), port);
+		outw(*addr, port);
 		addr++;
 	}
 	vx_release_pseudo_dma(chip);
@@ -417,7 +417,7 @@ static void vxp_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--)
-			*addr++ = le16_to_cpu(inw(port));
+			*addr++ = inw(port);
 		addr = (unsigned short *)runtime->dma_area;
 		pipe->hw_ptr = 0;
 	}
@@ -425,12 +425,12 @@ static void vxp_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 1; count--)
-		*addr++ = le16_to_cpu(inw(port));
+		*addr++ = inw(port);
 	/* Disable DMA */
 	pchip->regDIALOG &= ~VXP_DLG_DMAREAD_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);
 	/* Read the last word (16 bits) */
-	*addr = le16_to_cpu(inw(port));
+	*addr = inw(port);
 	/* Disable 16-bit accesses */
 	pchip->regDIALOG &= ~VXP_DLG_DMA16_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);
-- 
2.18.0
