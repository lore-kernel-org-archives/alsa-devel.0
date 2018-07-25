From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/14] ALSA: atiixp_modem: Proper endian
	notations
Date: Wed, 25 Jul 2018 23:24:13 +0200
Message-ID: <20180725212414.19795-14-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C641D26778D
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 80599B0B0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The DMA address table in atiixp modem driver is in little-endian,
hence we should define it with __le32 properly.

Spotted by sparse, a warning like:
  sound/pci/atiixp_modem.c:360:28: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/atiixp_modem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index a586635664e0..dc1de860cedf 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -183,10 +183,10 @@ struct atiixp_modem;
  */
 
 struct atiixp_dma_desc {
-	u32 addr;	/* DMA buffer address */
+	__le32 addr;	/* DMA buffer address */
 	u16 status;	/* status bits */
 	u16 size;	/* size of the packet in dwords */
-	u32 next;	/* address of the next packet descriptor */
+	__le32 next;	/* address of the next packet descriptor */
 };
 
 /*
-- 
2.18.0
