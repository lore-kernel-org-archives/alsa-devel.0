From: "Yang, Libin" <Libin.Yang@amd.com>
Subject: HDA-Intel -  Patch to support new AMD HDMI Audio
Date: Tue, 12 Aug 2008 17:12:25 +0800
Message-ID: <206C6845C72CAE439DC3D9D413C571A4015A0372@ssuzexmb3.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by alsa0.perex.cz (Postfix) with ESMTP id 8C6CB24493
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 11:12:42 +0200 (CEST)
Content-Class: urn:content-classes:message
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
Cc: alsa-devel@alsa-project.org, "Xu, Andiry" <Andiry.Xu@amd.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This patch is to support new HDMI audio device. Would you please review
it? Thanks a lot!
---------------------------------------------------------------------

Signed-off-by: Libin Yang <libin.yang@amd.com>

--- alsa-driver-1.0.17/alsa-kernel/pci/hda/hda_intel.c.orig
2008-08-12 15:33:37.000000000 +0800
+++ alsa-driver-1.0.17/alsa-kernel/pci/hda/hda_intel.c	2008-08-12
15:34:30.000000000 +0800
@@ -2268,6 +2268,7 @@
 	{ PCI_DEVICE(0x1002, 0x793b), .driver_data = AZX_DRIVER_ATIHDMI
},
 	{ PCI_DEVICE(0x1002, 0x7919), .driver_data = AZX_DRIVER_ATIHDMI
},
 	{ PCI_DEVICE(0x1002, 0x960f), .driver_data = AZX_DRIVER_ATIHDMI
},
+	{ PCI_DEVICE(0x1002, 0x970f), .driver_data = AZX_DRIVER_ATIHDMI
},
 	{ PCI_DEVICE(0x1002, 0xaa00), .driver_data = AZX_DRIVER_ATIHDMI
},
 	{ PCI_DEVICE(0x1002, 0xaa08), .driver_data = AZX_DRIVER_ATIHDMI
},
 	{ PCI_DEVICE(0x1002, 0xaa10), .driver_data = AZX_DRIVER_ATIHDMI
},

Thanks & Regards,
Libin
