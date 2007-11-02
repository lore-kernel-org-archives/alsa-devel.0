From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] HDA-Intel - Add support for RV610/RV630 HDMI
	audio
Date: Fri, 2 Nov 2007 02:41:42 -0200
Message-ID: <200711020241.42445.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F43D2453F
	for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2007 05:41:54 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Wolke Liu <wolke.liu@amd.com>, Felix Kuehling <fkuehlin@ati.com>
List-Id: alsa-devel@alsa-project.org

The Audio interface on HD2400/HD2600 cards isn't currently detected by
snd-hda-intel. I added missing pci device ids for RV610 and RV630, but
I only had a HD2400 pro card to test, where now the audio interface is
detected (and no need to change patch_atihdmi.c, as the codec vendor id
remains 0x1002aa01 for which we already have an entry there). I also
couldn't test if sound pass-trough is ok (and I don't know how to), but
at least now the device is detected.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

--- a/sound/pci/hda/hda_intel.c.orig	2007-11-02 01:59:29.000000000 -0200
+++ b/sound/pci/hda/hda_intel.c	2007-11-02 01:59:58.000000000 -0200
@@ -104,6 +104,8 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},
 			 "{ATI, RS690},"
 			 "{ATI, RS780},"
 			 "{ATI, R600},"
+			 "{ATI, RV630},"
+			 "{ATI, RV610},"
 			 "{VIA, VT8251},"
 			 "{VIA, VT8237A},"
 			 "{SiS, SIS966},"
@@ -1945,6 +1947,8 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x1002, 0x7919, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RS690 HDMI */
 	{ 0x1002, 0x960c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RS780 HDMI */
 	{ 0x1002, 0xaa00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI R600 HDMI */
+	{ 0x1002, 0xaa08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RV630 HDMI */
+	{ 0x1002, 0xaa10, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RV610 HDMI */
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA }, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS }, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI }, /* ULI M5461 */

--
[]'s
Herton
