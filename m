From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: cs5535audio: Fix invalid endian
	conversion
Date: Wed, 25 Jul 2018 22:54:27 +0200
Message-ID: <20180725205427.16907-3-tiwai@suse.de>
References: <20180725205427.16907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70ADA26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:54:29 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3EF02B05F
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

One place in cs5535audio_build_dma_packets() does an extra conversion
via cpu_to_le32(); namely jmpprd_addr is passed to setup_prd() ops,
which writes the value via cs_writel().  That is, the callback does
the conversion by itself, and we don't need to convert beforehand.

This patch fixes that bogus conversion.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs5535audio/cs5535audio.h     | 6 +++---
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio.h b/sound/pci/cs5535audio/cs5535audio.h
index f4fcdf93f3c8..d84620a0c26c 100644
--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -67,9 +67,9 @@ struct cs5535audio_dma_ops {
 };
 
 struct cs5535audio_dma_desc {
-	u32 addr;
-	u16 size;
-	u16 ctlreserved;
+	__le32 addr;
+	__le16 size;
+	__le16 ctlreserved;
 };
 
 struct cs5535audio_dma {
diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index ee7065f6e162..326caec854e1 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -158,8 +158,8 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 	lastdesc->addr = cpu_to_le32((u32) dma->desc_buf.addr);
 	lastdesc->size = 0;
 	lastdesc->ctlreserved = cpu_to_le16(PRD_JMP);
-	jmpprd_addr = cpu_to_le32(lastdesc->addr +
-				  (sizeof(struct cs5535audio_dma_desc)*periods));
+	jmpprd_addr = (u32)dma->desc_buf.addr +
+		sizeof(struct cs5535audio_dma_desc) * periods;
 
 	dma->substream = substream;
 	dma->period_bytes = period_bytes;
-- 
2.18.0
