From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] AACI cleanup
Date: Sun, 22 Nov 2009 17:31:18 +0000
Message-ID: <20091122172921.GC28172@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 0351224352
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2009 18:31:31 +0100 (CET)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Below is a patch which adds me to MAINTAINERS for this driver, and fixes
the buffer size calculation to use the size which ALSA is expecting.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--
Please review carefully, since I am presently unable to run-time test
changes to this driver due to incompatibilities system ABI.

 MAINTAINERS      |    5 +++++
 sound/arm/aaci.c |    7 ++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c824b4d..dffb0c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -512,6 +512,11 @@ W:	http://www.arm.linux.org.uk/
 S:	Maintained
 F:	arch/arm/
 
+ARM PRIMECELL AACI PL041 DRIVER
+M:	Russell King <linux@arm.linux.org.uk>
+S:	Maintained
+F:	sound/arm/aaci.*
+
 ARM PRIMECELL MMCI PL180/1 DRIVER
 S:	Orphan
 F:	drivers/mmc/host/mmci.*
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 1f0f821..a03fe80 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -18,10 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/amba/bus.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/sizes.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -534,7 +531,7 @@ static int aaci_pcm_prepare(struct snd_pcm_substream *substream)
 	struct aaci_runtime *aacirun = runtime->private_data;
 
 	aacirun->start	= (void *)runtime->dma_area;
-	aacirun->end	= aacirun->start + runtime->dma_bytes;
+	aacirun->end	= aacirun->start + snd_pcm_lib_buffer_bytes(substream);
 	aacirun->ptr	= aacirun->start;
 	aacirun->period	=
 	aacirun->bytes	= frames_to_bytes(runtime, runtime->period_size);
