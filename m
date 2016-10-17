From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] ALSA: hda - allow 40 bit DMA mask for NVidia devices
Date: Mon, 17 Oct 2016 17:23:59 +0100
Message-ID: <1476721439-29519-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz
Cc: travis@sgi.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: alsa-devel@alsa-project.org

Commit 49d9e77e72cf ("ALSA: hda - Fix system panic when DMA > 40 bits
for Nvidia audio controllers") simply disabled any DMA exceeding 32
bits for NVidia devices, even though they are capable of performing
DMA up to 40 bits. On some architectures (such as arm64), system memory
is not guaranteed to be 32-bit addressable by PCI devices, and so this
change prevents NVidia devices from working on platforms such as AMD
Seattle.

Since the original commit already mentioned that up to 40 bits of DMA
is supported, and given that the code has been updated in the meantime
to support a 40 bit DMA mask on other devices, revert commit 49d9e77e72cf
and explicitly set the DMA mask to 40 bits for NVidia devices.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 sound/pci/hda/hda_intel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c3469f756ec2..c64d986009a9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -341,8 +341,7 @@ enum {
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
-	(AZX_DCAPS_NO_MSI | /*AZX_DCAPS_ALIGN_BUFSIZE |*/ \
-	 AZX_DCAPS_NO_64BIT | AZX_DCAPS_CORBRP_SELF_CLEAR |\
+	(AZX_DCAPS_NO_MSI | AZX_DCAPS_CORBRP_SELF_CLEAR |\
 	 AZX_DCAPS_SNOOP_TYPE(NVIDIA))
 
 #define AZX_DCAPS_PRESET_CTHDA \
@@ -1716,6 +1715,10 @@ static int azx_first_init(struct azx *chip)
 		}
 	}
 
+	/* NVidia hardware normally only supports up to 40 bits of DMA */
+	if (chip->pci->vendor == PCI_VENDOR_ID_NVIDIA)
+		dma_bits = 40;
+
 	/* disable 64bit DMA address on some devices */
 	if (chip->driver_caps & AZX_DCAPS_NO_64BIT) {
 		dev_dbg(card->dev, "Disabling 64bit DMA\n");
-- 
2.7.4
