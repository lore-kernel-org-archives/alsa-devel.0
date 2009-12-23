From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] jazz16: refine dma and irq selection
Date: Wed, 23 Dec 2009 18:02:41 +0100
Message-ID: <20091223180241.eaaf83fe.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8843B10380E
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 17:59:58 +0100 (CET)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 79DFA27040F
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 17:59:56 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id ABCD0132476
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 17:59:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Narrow the dma and irq selection after the DOS driver.

Add ALSA configuration description as well.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The dma8 must be 8-bit otherwise the 8-bit sound played
through 16-bit dma has metalic noise. The 8-bit DMA cannot
play 16-bit sound.

 Documentation/sound/alsa/ALSA-Configuration.txt |   15 +++++++++++++++
 sound/isa/sb/jazz16.c                           |   21 ++++++++++++++++++++-
 sound/isa/sb/sb8_main.c                         |    3 ++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 8923597..92b0975 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -1123,6 +1123,21 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 
     This module supports multiple cards, autoprobe and ISA PnP.
 
+  Module snd-jazz16
+  -------------------
+
+    Module for Media Vision Jazz16 chipset. The chipset consists of 3 chips:
+    MVD1216 + MVA416 + MVA514.
+
+    port	- port # for SB DSP chip (0x210,0x220,0x230,0x240,0x250,0x260)
+    irq		- IRQ # for SB DSP chip (3,5,7,9,10,15)
+    dma8	- DMA # for SB DSP chip (1,3)
+    dma16	- DMA # for SB DSP chip (5,7)
+    mpu_port	- MPU-401 port # (0x300,0x310,0x320,0x330)
+    mpu_irq	- MPU-401 irq # (2,3,5,7)
+
+    This module supports multiple cards.
+
   Module snd-korg1212
   -------------------
 
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index d52966b..8d21a3f 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -189,10 +189,29 @@ static int __devinit snd_jazz16_match(struct device *devptr, unsigned int dev)
 	if (port[dev] == SNDRV_AUTO_PORT) {
 		snd_printk(KERN_ERR "please specify port\n");
 		return 0;
+	} else if (port[dev] == 0x200 || (port[dev] & ~0x270)) {
+		snd_printk(KERN_ERR "incorrect port specified\n");
+		return 0;
+	}
+	if (dma8[dev] != SNDRV_AUTO_DMA &&
+	    dma8[dev] != 1 && dma8[dev] != 3) {
+		snd_printk(KERN_ERR "dma8 must be 1 or 3\n");
+		return 0;
 	}
 	if (dma16[dev] != SNDRV_AUTO_DMA &&
 	    dma16[dev] != 5 && dma16[dev] != 7) {
-		snd_printk(KERN_ERR "dma16 must be 5 or 7");
+		snd_printk(KERN_ERR "dma16 must be 5 or 7\n");
+		return 0;
+	}
+	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
+	    (mpu_port[dev] & ~0x030) != 0x300) {
+		snd_printk(KERN_ERR "incorrect mpu_port specified\n");
+		return 0;
+	}
+	if (mpu_irq[dev] != SNDRV_AUTO_DMA &&
+	    mpu_irq[dev] != 2 && mpu_irq[dev] != 3 &&
+	    mpu_irq[dev] != 5 && mpu_irq[dev] != 7) {
+		snd_printk(KERN_ERR "mpu_irq must be 2, 3, 5 or 7\n");
 		return 0;
 	}
 	return 1;
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 3222aed..7d84c9f 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -510,7 +510,8 @@ static int snd_sb8_open(struct snd_pcm_substream *substream)
 	}
 	switch (chip->hardware) {
 	case SB_HW_JAZZ16:
-		runtime->hw.formats |= SNDRV_PCM_FMTBIT_S16_LE;
+		if (chip->dma16 == 5 || chip->dma16 == 7)
+			runtime->hw.formats |= SNDRV_PCM_FMTBIT_S16_LE;
 		runtime->hw.rates |= SNDRV_PCM_RATE_8000_48000;
 		runtime->hw.rate_min = 4000;
 		runtime->hw.rate_max = 50000;
-- 
1.6.4


----------------------------------------------------------------------
Sprawdz sekrety swojego biorytmu.
Kliknij >> http://link.interia.pl/f2534
