From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Enable chipset gcap usage
Date: Thu, 03 Jan 2008 15:34:05 -0800
Message-ID: <1199403245.3732.450.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vbu4mgurU1V43e2AtBVE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDF32467F
	for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2008 00:34:09 +0100 (CET)
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


--=-vbu4mgurU1V43e2AtBVE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  hda_intel.c use gcap register to determine number of streams
supported by southbridge.

This patch removes hardcoded values for the number of streams supported
by the southbridge in most chipsets, and reads these values from the
chipset directly.  Most systems are hardwired for 4 streams in each
direction, but newer chipsets change that capability.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-vbu4mgurU1V43e2AtBVE
Content-Disposition: attachment; filename=hda-gcap.patch
Content-Type: text/x-patch; name=hda-gcap.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 1227a1c12325 pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Mon Dec 24 14:40:56 2007 +0100
+++ b/pci/hda/hda_intel.c	Thu Jan 03 15:27:10 2008 -0800
@@ -1709,12 +1709,13 @@ static int __devinit azx_create(struct s
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
@@ -1790,10 +1791,19 @@ static int __devinit azx_create(struct s
 		chip->capture_index_offset = ATIHDMI_CAPTURE_INDEX;
 		break;
 	default:
-		chip->playback_streams = ICH6_NUM_PLAYBACK;
-		chip->capture_streams = ICH6_NUM_CAPTURE;
-		chip->playback_index_offset = ICH6_PLAYBACK_INDEX;
-		chip->capture_index_offset = ICH6_CAPTURE_INDEX;
+		/* read number of streams from GCAP register instead of using
+		 * hardcoded value
+		 */
+		gcap = azx_readw(chip, GCAP);
+		if(!gcap) {
+			snd_printk(KERN_ERR "Device has no streams \n");
+			goto errout;
+		};
+		chip->playback_streams = (gcap&(0xF<<12))>>12;
+		chip->capture_streams = (gcap&(0xF<<8))>>8;
+		chip->playback_index_offset = (gcap&(0xF<<12))>>12;
+		chip->capture_index_offset = 0;
+
 		break;
 	}
 	chip->num_streams = chip->playback_streams + chip->capture_streams;

--=-vbu4mgurU1V43e2AtBVE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-vbu4mgurU1V43e2AtBVE--
