From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: atiixp: fix fall-through annotations
Date: Thu, 13 Sep 2018 13:43:47 -0500
Message-ID: <20180913184347.GA32356@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/atiixp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a1e4944..1a41f8c 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -903,15 +903,15 @@ static int snd_atiixp_playback_prepare(struct snd_pcm_substream *substream)
 	case 8:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(10) |
 			ATI_REG_OUT_DMA_SLOT_BIT(11);
-		/* fallthru */
+		/* fall through */
 	case 6:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(7) |
 			ATI_REG_OUT_DMA_SLOT_BIT(8);
-		/* fallthru */
+		/* fall through */
 	case 4:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(6) |
 			ATI_REG_OUT_DMA_SLOT_BIT(9);
-		/* fallthru */
+		/* fall through */
 	default:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(3) |
 			ATI_REG_OUT_DMA_SLOT_BIT(4);
-- 
2.7.4
