From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA - enable snoop on SCH
Date: Sat, 02 Feb 2008 10:34:44 -0800
Message-ID: <1201977284.24072.105.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-l+9UfBKLdhShVDrBLxtl"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id ED8CA24598
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 19:34:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-l+9UfBKLdhShVDrBLxtl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch enables snoop on Intel SCH chipset, eliminating static during
playback.


Signed off by Tobin Davis <tdavis@dsl-only.net>


P.S. I know this is real close to the final release, but it is
critically needed for product enabling.  The patch has no effect on
other components, and has been tested on production desktop and laptop
systems, along with Intel's Mobile Internet Device.  This is the last
patch needed for release.

P.P.S  Forgot to include the patch in the last email.  Doh.

--=-l+9UfBKLdhShVDrBLxtl
Content-Disposition: attachment; filename=hda-snoop.patch
Content-Type: text/x-patch; name=hda-snoop.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 823ccbb17a3d pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Wed Jan 30 14:58:38 2008 +0100
+++ b/pci/hda/hda_intel.c	Sat Feb 02 10:26:04 2008 -0800
@@ -275,6 +275,11 @@ enum {
 #define NVIDIA_HDA_TRANSREG_ADDR      0x4e
 #define NVIDIA_HDA_ENABLE_COHBITS     0x0f
 
+/* Defines for Intel SCH HDA snoop control */
+#define INTEL_SCH_HDA_DEVC      0x78
+#define INTEL_SCH_HDA_DEVC_NOSNOOP       (0x1<<11)
+
+
 /*
  */
 
@@ -868,6 +873,8 @@ static void update_pci_byte(struct pci_d
 
 static void azx_init_pci(struct azx *chip)
 {
+	unsigned short snoop;
+
 	/* Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
 	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
 	 * Ensuring these bits are 0 clears playback static on some HD Audio
@@ -888,6 +895,19 @@ static void azx_init_pci(struct azx *chi
 				NVIDIA_HDA_TRANSREG_ADDR,
 				0x0f, NVIDIA_HDA_ENABLE_COHBITS);
 		break;
+	case AZX_DRIVER_SCH:
+		pci_read_config_word(chip->pci, INTEL_SCH_HDA_DEVC, &snoop);
+		if (snoop & INTEL_SCH_HDA_DEVC_NOSNOOP) {
+			pci_write_config_word(chip->pci, INTEL_SCH_HDA_DEVC, \
+				snoop & (~INTEL_SCH_HDA_DEVC_NOSNOOP));
+			pci_read_config_word(chip->pci,
+				INTEL_SCH_HDA_DEVC, &snoop);
+			snd_printdd("HDA snoop disabled, enabling ... %s\n",\
+				(snoop & INTEL_SCH_HDA_DEVC_NOSNOOP) \
+				? "Failed" : "OK");
+		}
+		break;
+
         }
 }
 
@@ -1040,6 +1060,7 @@ static int azx_setup_controller(struct a
 
 static unsigned int azx_max_codecs[] __devinitdata = {
 	[AZX_DRIVER_ICH] = 3,
+	[AZX_DRIVER_SCH] = 3,
 	[AZX_DRIVER_ATI] = 4,
 	[AZX_DRIVER_ATIHDMI] = 4,
 	[AZX_DRIVER_VIA] = 3,		/* FIXME: correct? */

--=-l+9UfBKLdhShVDrBLxtl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-l+9UfBKLdhShVDrBLxtl--
