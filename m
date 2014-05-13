From: mengdong.lin@intel.com
Subject: [PATCH 2/2] ALSA: hda - mask buggy stream DMA0 for
	Broadwell display controller
Date: Tue, 13 May 2014 12:36:13 +0800
Message-ID: <1399955773-3213-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8279E2652F1
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 06:34:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Broadwell display controller has 3 stream DMA engines. DMA0 cannot update DMA
postion buffer properly while DMA1 and DMA2 can work well. So this patch masks
the buggy DMA0.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 377c3a5..13b13a3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -281,6 +281,9 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
+#define is_broadwell_controller(pci) \
+	((pci)->vendor == 0x8086 && (pci)->device == 0x160c)
+
 #ifdef CONFIG_X86
 static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
 {
@@ -1249,6 +1252,7 @@ static int azx_first_init(struct azx *chip)
 	struct snd_card *card = chip->card;
 	int err;
 	unsigned short gcap;
+	unsigned int stream_mask = 0;
 
 #if BITS_PER_LONG != 64
 	/* Fix up base address on ULI M5461 */
@@ -1364,7 +1368,10 @@ static int azx_first_init(struct azx *chip)
 		return err;
 
 	/* initialize streams */
-	azx_init_stream(chip, 0);
+	if (is_broadwell_controller(pci))
+		stream_mask = 0x1; /* mask buggy stream DMA0 */
+
+	azx_init_stream(chip, stream_mask);
 
 	/* initialize chip */
 	azx_init_pci(chip);
-- 
1.8.1.2
