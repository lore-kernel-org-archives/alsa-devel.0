From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: vx222: Fix invalid endian conversions
Date: Wed, 25 Jul 2018 22:54:25 +0200
Message-ID: <20180725205427.16907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 968BE26775C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:54:29 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2CFA9ACB1
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 20:54:29 +0000 (UTC)
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

The endian conversions used in vx2_dma_read() and vx2_dma_write() are
superfluous and even wrong on big-endian machines, as inl() and outl()
already do conversions.  Kill them.

Spotted by sparse, a warning like:
  sound/pci/vx222/vx222_ops.c:278:30: warning: incorrect type in argument 1 (different base types)

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/vx222/vx222_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index d4298af6d3ee..c0d0bf44f365 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -275,7 +275,7 @@ static void vx2_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--) {
-			outl(cpu_to_le32(*addr), port);
+			outl(*addr, port);
 			addr++;
 		}
 		addr = (u32 *)runtime->dma_area;
@@ -285,7 +285,7 @@ static void vx2_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--) {
-		outl(cpu_to_le32(*addr), port);
+		outl(*addr, port);
 		addr++;
 	}
 
@@ -313,7 +313,7 @@ static void vx2_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--)
-			*addr++ = le32_to_cpu(inl(port));
+			*addr++ = inl(port);
 		addr = (u32 *)runtime->dma_area;
 		pipe->hw_ptr = 0;
 	}
@@ -321,7 +321,7 @@ static void vx2_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--)
-		*addr++ = le32_to_cpu(inl(port));
+		*addr++ = inl(port);
 
 	vx2_release_pseudo_dma(chip);
 }
-- 
2.18.0
