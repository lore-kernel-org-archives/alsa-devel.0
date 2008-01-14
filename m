From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Enable chipset gcap usage
Date: Mon, 14 Jan 2008 11:44:27 -0800
Message-ID: <1200339867.27806.25.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-F+3e4Gh9nxAIQnmHFOVK"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F3D12462B
	for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2008 20:44:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-F+3e4Gh9nxAIQnmHFOVK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I tweaked this as promised, and ran it through the checkpatch.pl utility
from kernel git tree.  I have tested it on my Asus Z62F laptop as well
as a few systems in my work environment without issue.

Summary:  hda_intel.c use gcap register to determine number of streams
supported by southbridge.

This patch quieries the southbridge for the number of streams supported
by the southbridge in most chipsets, and reads these values from the
chipset directly.  Most systems are hardwired for 4 streams in each
direction, but newer chipsets change that capability.  As a fallback,
the old hardcoded method is still available.



Signed off by Tobin Davis <tdavis@dsl-only.net>




--=-F+3e4Gh9nxAIQnmHFOVK
Content-Disposition: attachment; filename=hda-gcap.patch
Content-Type: text/x-patch; name=hda-gcap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 1f9fd3d3cb12 pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Mon Jan 14 12:07:53 2008 +0100
+++ b/pci/hda/hda_intel.c	Mon Jan 14 10:30:21 2008 -0800
@@ -1708,12 +1708,13 @@ static int __devinit azx_create(struct s
 {
 	struct azx *chip;
 	int err;
+	unsigned short gcap;
 	static struct snd_device_ops ops = {
 		.dev_free = azx_dev_free,
 	};
 
 	*rchip = NULL;
-	
+
 	err = pci_enable_device(pci);
 	if (err < 0)
 		return err;
@@ -1775,25 +1776,40 @@ static int __devinit azx_create(struct s
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	switch (chip->driver_type) {
-	case AZX_DRIVER_ULI:
+	gcap = azx_readw(chip, ICH6_REG_GCAP);
+	snd_printdd("chipset global capabilities = 0x%x\n", gcap);
+
+	if (gcap) {
+	    /* read number of streams from GCAP register instead of using
+	       hardcoded value */
+
+	    chip->playback_streams = (gcap & (0xF << 12)) >> 12;
+	    chip->capture_streams = (gcap & (0xF << 8)) >> 8;
+	    chip->playback_index_offset = (gcap & (0xF << 12)) >> 12;
+	    chip->capture_index_offset = 0;
+	} else {
+	    /* gcap didn't give any info, switching to old method */
+
+	    switch (chip->driver_type) {
+	    case AZX_DRIVER_ULI:
 		chip->playback_streams = ULI_NUM_PLAYBACK;
 		chip->capture_streams = ULI_NUM_CAPTURE;
 		chip->playback_index_offset = ULI_PLAYBACK_INDEX;
 		chip->capture_index_offset = ULI_CAPTURE_INDEX;
 		break;
-	case AZX_DRIVER_ATIHDMI:
+	    case AZX_DRIVER_ATIHDMI:
 		chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
 		chip->capture_streams = ATIHDMI_NUM_CAPTURE;
 		chip->playback_index_offset = ATIHDMI_PLAYBACK_INDEX;
 		chip->capture_index_offset = ATIHDMI_CAPTURE_INDEX;
 		break;
-	default:
+	    default:
 		chip->playback_streams = ICH6_NUM_PLAYBACK;
 		chip->capture_streams = ICH6_NUM_CAPTURE;
 		chip->playback_index_offset = ICH6_PLAYBACK_INDEX;
 		chip->capture_index_offset = ICH6_CAPTURE_INDEX;
 		break;
+	    }
 	}
 	chip->num_streams = chip->playback_streams + chip->capture_streams;
 	chip->azx_dev = kcalloc(chip->num_streams, sizeof(*chip->azx_dev),

--=-F+3e4Gh9nxAIQnmHFOVK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-F+3e4Gh9nxAIQnmHFOVK--
