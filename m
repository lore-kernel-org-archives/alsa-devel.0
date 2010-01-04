From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sbawe: fix memory detection part 2
Date: Mon, 4 Jan 2010 22:23:34 +0100
Message-ID: <20100104222334.8947028a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 60738103803
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 02:18:35 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The patch "sbawe: fix memory detection" fixed detection
for memoryless SB32 cards but broke detection of memory
above 512KB. This patch fixes the regression.

The patch has been tested on the SB32 card (CT3670) with
0MB, 2MB and 8MB memory installed.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/sb/emu8000.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 751762f..0c40951 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -377,12 +377,13 @@ init_arrays(struct snd_emu8000 *emu)
 static void __devinit
 size_dram(struct snd_emu8000 *emu)
 {
-	int i, size;
+	int i, size, detected_size;
 
 	if (emu->dram_checked)
 		return;
 
 	size = 0;
+	detected_size = 0;
 
 	/* write out a magic number */
 	snd_emu8000_dma_chan(emu, 0, EMU8000_RAM_WRITE);
@@ -393,6 +394,8 @@ size_dram(struct snd_emu8000 *emu)
 
 	while (size < EMU8000_MAX_DRAM) {
 
+		size += 512 * 1024;  /* increment 512kbytes */
+
 		/* Write a unique data on the test address.
 		 * if the address is out of range, the data is written on
 		 * 0x200000(=EMU8000_DRAM_OFFSET).  Then the id word is
@@ -414,7 +417,7 @@ size_dram(struct snd_emu8000 *emu)
 		if (EMU8000_SMLD_READ(emu) != UNIQUE_ID2)
 			break; /* no memory at this address */
 
-		size += 512 * 1024;  /* increment 512kbytes */
+		detected_size = size;
 
 		snd_emu8000_read_wait(emu);
 
@@ -442,9 +445,9 @@ size_dram(struct snd_emu8000 *emu)
 	snd_emu8000_dma_chan(emu, 1, EMU8000_RAM_CLOSE);
 
 	snd_printdd("EMU8000 [0x%lx]: %d Kb on-board memory detected\n",
-		    emu->port1, size/1024);
+		    emu->port1, detected_size/1024);
 
-	emu->mem_size = size;
+	emu->mem_size = detected_size;
 	emu->dram_checked = 1;
 }
 
-- 
1.6.4


----------------------------------------------------------------------
Sypie, sypie, ale czy sypac bedzie nadal?
Sprawdz pogode >> http://link.interia.pl/f2530
