From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: cs5535 - Fix an endianness conversion
Date: Sun, 20 Nov 2011 23:57:49 +0300
Message-ID: <20111120205748.GA7354@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A6F7243DE
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 21:58:12 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaya Kumar <jayakumar.alsa@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

desc->size is supposed to be a le16 type.  On a big endian system the
current code will set ->size to zero.  We fixed a similar bug
on the next line but missed this one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is a static checker bug.  I haven't tested it.

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index e083122..dbf94b1 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -148,7 +148,7 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 		struct cs5535audio_dma_desc *desc =
 			&((struct cs5535audio_dma_desc *) dma->desc_buf.area)[i];
 		desc->addr = cpu_to_le32(addr);
-		desc->size = cpu_to_le32(period_bytes);
+		desc->size = cpu_to_le16(period_bytes);
 		desc->ctlreserved = cpu_to_le16(PRD_EOP);
 		desc_addr += sizeof(struct cs5535audio_dma_desc);
 		addr += period_bytes;
