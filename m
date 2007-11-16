From: "Liu, Wolke" <Wolke.Liu@amd.com>
Subject: [PATCH] HDA-Intel - Add support for RV6xx HDMI audio
Date: Fri, 16 Nov 2007 17:49:33 +0800
Message-ID: <4749221FC8C1774886E3CB27713C6E06874EB1@sshaexmb1.amd.com>
References: <s5hejf4wys6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16]) by alsa0.perex.cz (Postfix) with ESMTP id A5593248CC
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 10:53:15 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <s5hejf4wys6.wl%tiwai@suse.de>
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
Cc: "Zhang, Andrea" <Andrea.Zhang@amd.com>, alsa-devel@alsa-project.org, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch is to add R6xx HDMI audio support. Meanwhile, the device ID
in the previous patch is changed.
I have checked the patch from Herton Ronaldo Krzesinski, it's right as
our spec said. :)

Thanks!

Signed-off-by: Wolke Liu <Wolke.Liu@amd.com>
Signed-off-by: Andrea Zhang <Andrea.Zhang@amd.com>

diff -r af733bf8e50c pci/hda/hda_intel.c
--- a/pci/hda/hda_intel.c	Thu Nov 15 16:18:14 2007 +0100
+++ b/pci/hda/hda_intel.c	Sat Nov 17 00:35:12 2007 +0800
@@ -106,6 +106,10 @@ MODULE_SUPPORTED_DEVICE("{{Intel, ICH6},
 			 "{ATI, R600},"
 			 "{ATI, RV630},"
 			 "{ATI, RV610},"
+			 "{ATI, RV670},"
+			 "{ATI, RV635},"
+			 "{ATI, RV620},"
+			 "{ATI, RV770},"
 			 "{VIA, VT8251},"
 			 "{VIA, VT8237A},"
 			 "{SiS, SIS966},"
@@ -1942,10 +1946,14 @@ static struct pci_device_id azx_ids[] = 
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
}, /* ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */
 	{ 0x1002, 0x7919, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS690 HDMI */
-	{ 0x1002, 0x960c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS780 HDMI */
+	{ 0x1002, 0x960f, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS780 HDMI */
 	{ 0x1002, 0xaa00, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI R600 HDMI */
 	{ 0x1002, 0xaa08, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV630 HDMI */
 	{ 0x1002, 0xaa10, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV610 HDMI */
+	{ 0x1002, 0xaa18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV670 HDMI */
+	{ 0x1002, 0xaa20, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV635 HDMI */
+	{ 0x1002, 0xaa28, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV620 HDMI */
+	{ 0x1002, 0xaa30, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV770 HDMI */
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
diff -r af733bf8e50c pci/hda/patch_atihdmi.c
--- a/pci/hda/patch_atihdmi.c	Thu Nov 15 16:18:14 2007 +0100
+++ b/pci/hda/patch_atihdmi.c	Sat Nov 17 00:32:59 2007 +0800
@@ -158,6 +158,6 @@ struct hda_codec_preset snd_hda_preset_a
 	{ .id = 0x1002793c, .name = "ATI RS600 HDMI", .patch =
patch_atihdmi },
 	{ .id = 0x10027919, .name = "ATI RS600 HDMI", .patch =
patch_atihdmi },
 	{ .id = 0x1002791a, .name = "ATI RS690/780 HDMI", .patch =
patch_atihdmi },
-	{ .id = 0x1002aa01, .name = "ATI R600 HDMI", .patch =
patch_atihdmi },
+	{ .id = 0x1002aa01, .name = "ATI R6xx HDMI", .patch =
patch_atihdmi },
 	{} /* terminator */
 };
