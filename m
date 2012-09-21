From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/3] ALSA: hda - use LPIB for delay estimation
Date: Fri, 21 Sep 2012 18:39:06 -0500
Message-ID: <1348270747-4083-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1348270747-4083-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E0F265DF9
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 01:39:16 +0200 (CEST)
In-Reply-To: <1348270747-4083-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

DMA Position in Buffer (DPIB) should be used for
ring buffer management, while LPIB register provides
information on the number of samples transfered on
the link. The difference between the two pieces of
information corresponds to hardware/DMA buffering.

This patch reports this difference in runtime->delay, and
removes the use of the COMBO mode on recent Intel hardware.

Credits to Takashi Iwai for an initial patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7ba187e..acd6756 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -538,6 +538,7 @@ enum {
 #define AZX_DCAPS_ALIGN_BUFSIZE	(1 << 22)	/* buffer size alignment */
 #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)	/* BDLE in 4k boundary */
 #define AZX_DCAPS_POSFIX_COMBO  (1 << 24)	/* Use COMBO as default */
+#define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
@@ -2116,6 +2117,27 @@ static unsigned int azx_get_position(struct azx *chip,
 
 	if (pos >= azx_dev->bufsize)
 		pos = 0;
+
+	/* calculate runtime delay from LPIB */
+	if (azx_dev->substream->runtime &&
+	    chip->position_fix[stream] == POS_FIX_POSBUF &&
+	    (chip->driver_caps & AZX_DCAPS_COUNT_LPIB_DELAY)) {
+		unsigned int lpib_pos = azx_sd_readl(azx_dev, SD_LPIB);
+		int delay;
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			delay = pos - lpib_pos;
+		else
+			delay = lpib_pos - pos;
+		if (delay < 0)
+			delay += azx_dev->bufsize;
+		if (delay >= azx_dev->period_bytes) {
+			snd_printk(KERN_ERR "delay %d > period_bytes %d\n",
+				delay, azx_dev->period_bytes);
+			delay = 0; /* something is wrong */
+		}
+		azx_dev->substream->runtime->delay =
+			bytes_to_frames(azx_dev->substream->runtime, delay);
+	}
 	return pos;
 }
 
@@ -3254,7 +3276,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* CPT */
 	{ PCI_DEVICE(0x8086, 0x1c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* PBG */
 	{ PCI_DEVICE(0x8086, 0x1d20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
@@ -3262,23 +3284,23 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* Panther Point */
 	{ PCI_DEVICE(0x8086, 0x1e20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* Lynx Point */
 	{ PCI_DEVICE(0x8086, 0x8c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* Lynx Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* Lynx Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9c21),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0c0c),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_COMBO },
+	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY },
 	/* SCH */
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-- 
1.7.9.5
