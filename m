From: "Yang, Libin" <Libin.Yang@amd.com>
Subject: HDA-Intel -  Patch to support RV7xx HDMI Audio
Date: Thu, 14 Feb 2008 14:55:02 +0800
Message-ID: <206C6845C72CAE439DC3D9D413C571A496598E@ssuzexmb3.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by alsa0.perex.cz (Postfix) with ESMTP id 59607243E5
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 07:56:08 +0100 (CET)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, "Huang, Shane" <Shane.Huang@amd.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This patch is to add R7xx HDMI audio support. Would you please accept
it? Thanks a lot!

Signed-off-by: Libin Yang <Libin.yang@amd.com>


--- alsa-driver-1.0.16/alsa-kernel/pci/hda/hda_intel.c.orig
2008-02-13 11:57:11.000000000 -0500
+++ alsa-driver-1.0.16/alsa-kernel/pci/hda/hda_intel.c	2008-02-13
12:02:39.000000000 -0500
@@ -2015,6 +2015,9 @@
 	{ 0x1002, 0xaa20, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV635 HDMI */
 	{ 0x1002, 0xaa28, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV620 HDMI */
 	{ 0x1002, 0xaa30, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV770 HDMI */
+	{ 0x1002, 0xaa38, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV730 HDMI */
+	{ 0x1002, 0xaa40, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV710 HDMI */
+	{ 0x1002, 0xaa48, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RV740 HDMI */
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
 	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */


Thanks & Regards,
Libin
