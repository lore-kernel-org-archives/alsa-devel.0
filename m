From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/15] ALSA: hda - Add the support for Creative
	SoundCore3D
Date: Mon, 14 May 2012 17:32:01 +0200
Message-ID: <1337009526-26256-11-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C81324A2D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 07D0890CE3
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The controller is compatible with HD-audio 1.0a with some specific
restrictions.
- The BDLE entries can't be over 4k boundary
- No position-buffer and no MSI

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c19e71a..a70d7e5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -497,6 +497,7 @@ enum {
 	AZX_DRIVER_NVIDIA,
 	AZX_DRIVER_TERA,
 	AZX_DRIVER_CTX,
+	AZX_DRIVER_CTHDA,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -518,6 +519,7 @@ enum {
 #define AZX_DCAPS_OLD_SSYNC	(1 << 20)	/* Old SSYNC reg for ICH */
 #define AZX_DCAPS_BUFSIZE	(1 << 21)	/* no buffer size alignment */
 #define AZX_DCAPS_ALIGN_BUFSIZE	(1 << 22)	/* buffer size alignment */
+#define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)	/* BDLE in 4k boundary */
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
@@ -533,6 +535,9 @@ enum {
 	(AZX_DCAPS_NVIDIA_SNOOP | AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI |\
 	 AZX_DCAPS_ALIGN_BUFSIZE)
 
+#define AZX_DCAPS_PRESET_CTHDA \
+	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_4K_BDLE_BOUNDARY)
+
 static char *driver_short_names[] __devinitdata = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
 	[AZX_DRIVER_PCH] = "HDA Intel PCH",
@@ -546,6 +551,7 @@ static char *driver_short_names[] __devinitdata = {
 	[AZX_DRIVER_NVIDIA] = "HDA NVidia",
 	[AZX_DRIVER_TERA] = "HDA Teradici", 
 	[AZX_DRIVER_CTX] = "HDA Creative", 
+	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -1283,7 +1289,8 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 /*
  * set up a BDL entry
  */
-static int setup_bdle(struct snd_pcm_substream *substream,
+static int setup_bdle(struct azx *chip,
+		      struct snd_pcm_substream *substream,
 		      struct azx_dev *azx_dev, u32 **bdlp,
 		      int ofs, int size, int with_ioc)
 {
@@ -1302,6 +1309,12 @@ static int setup_bdle(struct snd_pcm_substream *substream,
 		bdl[1] = cpu_to_le32(upper_32_bits(addr));
 		/* program the size field of the BDL entry */
 		chunk = snd_pcm_sgbuf_get_chunk_size(substream, ofs, size);
+		/* one BDLE cannot cross 4K boundary on CTHDA chips */
+		if (chip->driver_caps & AZX_DCAPS_4K_BDLE_BOUNDARY) {
+			u32 remain = 0x1000 - (ofs & 0xfff);
+			if (chunk > remain)
+				chunk = remain;
+		}
 		bdl[2] = cpu_to_le32(chunk);
 		/* program the IOC to enable interrupt
 		 * only when the whole fragment is processed
@@ -1354,7 +1367,7 @@ static int azx_setup_periods(struct azx *chip,
 				   bdl_pos_adj[chip->dev_index]);
 			pos_adj = 0;
 		} else {
-			ofs = setup_bdle(substream, azx_dev,
+			ofs = setup_bdle(chip, substream, azx_dev,
 					 &bdl, ofs, pos_adj,
 					 !substream->runtime->no_period_wakeup);
 			if (ofs < 0)
@@ -1364,10 +1377,10 @@ static int azx_setup_periods(struct azx *chip,
 		pos_adj = 0;
 	for (i = 0; i < periods; i++) {
 		if (i == periods - 1 && pos_adj)
-			ofs = setup_bdle(substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
 					 period_bytes - pos_adj, 0);
 		else
-			ofs = setup_bdle(substream, azx_dev, &bdl, ofs,
+			ofs = setup_bdle(chip, substream, azx_dev, &bdl, ofs,
 					 period_bytes,
 					 !substream->runtime->no_period_wakeup);
 		if (ofs < 0)
@@ -3116,6 +3129,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
 	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
 #endif
+	/* CTHDA chips */
+	{ PCI_DEVICE(0x1102, 0x0010),
+	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
+	{ PCI_DEVICE(0x1102, 0x0012),
+	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
 	/* Vortex86MX */
 	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
 	/* VMware HDAudio */
-- 
1.7.9.2
