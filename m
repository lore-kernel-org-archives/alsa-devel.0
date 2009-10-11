From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] snd_dma_pointer workaround for chipsets with
	buggy DMA
Date: Sun, 11 Oct 2009 12:48:00 +0200
Message-ID: <20091011124800.e150b349.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id CDD8A103801
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 12:31:02 +0200 (CEST)
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

The chipsets with the isa_dma_bridge_buggy set do not stop DMA during
DMA counter reads. The DMA counter is read in two 8-bit read steps
on x86 platform. Sometimes, such reads happen during higher byte
change so the lower byte is already decremented (rolled over) but
the higher byte is not. It introduces an error that position is
moved 256 bytes ahead of the true position. Thus, the next DMA
position read can return a lower value then the previous read.
If the DMA position is decreased (reversed) the ALSA subsystem is
tricked into the playback underrun error and resets the playback.
It results in a "pop" during a playback.

Work around the issue by reading the counter twice and choosing a higher
value.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This issue can be tested with the pcm tool from the alsa-lib's test package. 
The command "pcm -c 2 -b 350000 -p 5800" can easily trigger the original error
every ten seconds on my system.
This work around greatly reduces the underrun errors for ogg123 and mpg321 
on VIA Apollo (586) chipset + K6-2 533 MHz (from every few seconds to one per about
15 minutes - few songs).


 sound/core/isadma.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/core/isadma.c b/sound/core/isadma.c
index 79f0f16..950e19b 100644
--- a/sound/core/isadma.c
+++ b/sound/core/isadma.c
@@ -85,16 +85,24 @@ EXPORT_SYMBOL(snd_dma_disable);
 unsigned int snd_dma_pointer(unsigned long dma, unsigned int size)
 {
 	unsigned long flags;
-	unsigned int result;
+	unsigned int result, result1;
 
 	flags = claim_dma_lock();
 	clear_dma_ff(dma);
 	if (!isa_dma_bridge_buggy)
 		disable_dma(dma);
 	result = get_dma_residue(dma);
+	/*
+	 * HACK - read the counter again and choose higher value in order to
+	 * avoid reading during counter lower byte roll over if the
+	 * isa_dma_bridge_buggy is set.
+	 */
+	result1 = get_dma_residue(dma);
 	if (!isa_dma_bridge_buggy)
 		enable_dma(dma);
 	release_dma_lock(flags);
+	if (unlikely(result < result1))
+		result = result1;
 #ifdef CONFIG_SND_DEBUG
 	if (result > size)
 		snd_printk(KERN_ERR "pointer (0x%x) for DMA #%ld is greater than transfer size (0x%x)\n", result, dma, size);
-- 
1.6.0.3



---------------------------------------------------------------
Zobacz jak pracuje sie na wysokosciach.
Kliknij >>> http://link.interia.pl/f2384
