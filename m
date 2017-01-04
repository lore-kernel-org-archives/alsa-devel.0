From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: vx: Fix possible transfer overflow
Date: Wed,  4 Jan 2017 18:01:14 +0100
Message-ID: <20170104170115.9830-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F5DF267547
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 18:01:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2E16CAC74
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 17:01:18 +0000 (UTC)
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

The pseudo DMA transfer codes in VX222 and VX-pocket driver have a
slight bug where they check the buffer boundary wrongly, and may
overflow.  Also, the zero sample count might be handled badly for the
playback (although it shouldn't happen in theory).  This patch
addresses these issues.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=141541
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_pcm.c   |  6 ++++--
 sound/pci/vx222/vx222_ops.c | 12 ++++++------
 sound/pcmcia/vx/vxp_ops.c   | 12 ++++++------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index 11467272089e..41a617886cc7 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1048,8 +1048,10 @@ static void vx_pcm_capture_update(struct vx_core *chip, struct snd_pcm_substream
 		/* ok, let's accelerate! */
 		int align = pipe->align * 3;
 		space = (count / align) * align;
-		vx_pseudo_dma_read(chip, runtime, pipe, space);
-		count -= space;
+		if (space > 0) {
+			vx_pseudo_dma_read(chip, runtime, pipe, space);
+			count -= space;
+		}
 	}
 	/* read the rest of bytes */
 	while (count > 0) {
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index af83b3b38052..8e457ea27f89 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -269,12 +269,12 @@ static void vx2_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
+		for (; length > 0; length--) {
 			outl(cpu_to_le32(*addr), port);
 			addr++;
 		}
@@ -284,7 +284,7 @@ static void vx2_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	pipe->hw_ptr += count;
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
+	for (; count > 0; count--) {
 		outl(cpu_to_le32(*addr), port);
 		addr++;
 	}
@@ -307,12 +307,12 @@ static void vx2_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	vx2_setup_pseudo_dma(chip, 0);
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
+		for (; length > 0; length--)
 			*addr++ = le32_to_cpu(inl(port));
 		addr = (u32 *)runtime->dma_area;
 		pipe->hw_ptr = 0;
@@ -320,7 +320,7 @@ static void vx2_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	pipe->hw_ptr += count;
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0)
+	for (; count > 0; count--)
 		*addr++ = le32_to_cpu(inl(port));
 
 	vx2_release_pseudo_dma(chip);
diff --git a/sound/pcmcia/vx/vxp_ops.c b/sound/pcmcia/vx/vxp_ops.c
index 281972913c32..56aa1ba73ccc 100644
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -369,12 +369,12 @@ static void vxp_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	unsigned short *addr = (unsigned short *)(runtime->dma_area + offset);
 
 	vx_setup_pseudo_dma(chip, 1);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
+		for (; length > 0; length--) {
 			outw(cpu_to_le16(*addr), port);
 			addr++;
 		}
@@ -384,7 +384,7 @@ static void vxp_dma_write(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	pipe->hw_ptr += count;
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
+	for (; count > 0; count--) {
 		outw(cpu_to_le16(*addr), port);
 		addr++;
 	}
@@ -411,12 +411,12 @@ static void vxp_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	if (snd_BUG_ON(count % 2))
 		return;
 	vx_setup_pseudo_dma(chip, 0);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
+		for (; length > 0; length--)
 			*addr++ = le16_to_cpu(inw(port));
 		addr = (unsigned short *)runtime->dma_area;
 		pipe->hw_ptr = 0;
@@ -424,7 +424,7 @@ static void vxp_dma_read(struct vx_core *chip, struct snd_pcm_runtime *runtime,
 	pipe->hw_ptr += count;
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 1)
+	for (; count > 1; count--)
 		*addr++ = le16_to_cpu(inw(port));
 	/* Disable DMA */
 	pchip->regDIALOG &= ~VXP_DLG_DMAREAD_SEL_MASK;
-- 
2.11.0
