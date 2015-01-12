From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] sound: dmasound_atari: Remove obsolete
	IRQ_TYPE_SLOW
Date: Mon, 12 Jan 2015 09:40:20 +0100
Message-ID: <1421052021-12560-5-git-send-email-geert@linux-m68k.org>
References: <1421052021-12560-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
 by alsa0.perex.cz (Postfix) with ESMTP id 74B2B2605E4
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 09:40:26 +0100 (CET)
In-Reply-To: <1421052021-12560-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

IRQ_TYPE_SLOW is no longer used by the Atari platform interrupt code
since commit 734085651c9b80aa ("[PATCH] m68k: convert atari irq code")
in v2.6.18-rc1, so drop it.

Note that its value has been reused for a different purpose
(IRQ_TYPE_NONE) since commit 6a6de9ef5850d063 ("[PATCH] genirq: core")
in v2.6.18-rc1.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org
---
 sound/oss/dmasound/dmasound_atari.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 13c214466d3b9f0e..1c56bf58eff906e0 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -851,7 +851,7 @@ static int __init AtaIrqInit(void)
 	st_mfp.tim_dt_a = 1;	/* Cause interrupt after first event. */
 	st_mfp.tim_ct_a = 8;	/* Turn on event counting. */
 	/* Register interrupt handler. */
-	if (request_irq(IRQ_MFP_TIMA, AtaInterrupt, IRQ_TYPE_SLOW, "DMA sound",
+	if (request_irq(IRQ_MFP_TIMA, AtaInterrupt, 0, "DMA sound",
 			AtaInterrupt))
 		return 0;
 	st_mfp.int_en_a |= 0x20;	/* Turn interrupt on. */
-- 
1.9.1
