From: Jiang zhe <zhe.jiang@intel.com>
Subject: Same pci id for different ASUS machine
Date: Thu, 13 Mar 2008 10:48:49 +0800
Message-ID: <1205376529.15217.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-P6uh2DByo5Kg4TqSdAZS"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ED432447C
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 03:47:48 +0100 (CET)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--=-P6uh2DByo5Kg4TqSdAZS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

According to the [0003839]
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3839

The PCI ID of ASUS F9S is 1043:1339 and "model=lenovo" works for it.
But I found that ASUS G1 have the same id and model is 3stack in the
alsa driver.

Which one is true?

--- alsa-driver-hg20080313/alsa-kernel/pci/hda/patch_realtek.c
2008-03-13 09:00:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-13 10:38:57.000000000
+0800
@@ -12591,7 +12591,7 @@ static struct snd_pci_quirk alc861vd_cfg
 	SND_PCI_QUIRK(0x1019, 0xa88d, "Realtek ALC660 demo", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x103c, 0x30bf, "HP TX1000", ALC861VD_HP),
 	SND_PCI_QUIRK(0x1043, 0x12e2, "Asus z35m", ALC660VD_3ST),
-	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
+	SND_PCI_QUIRK(0x1043, 0x1339, "Asus F9S", ALC861VD_LENOVO),
 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST_DIG),
 	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x1179, 0xff00, "Toshiba A135", ALC861VD_LENOVO),


--=-P6uh2DByo5Kg4TqSdAZS
Content-Disposition: attachment; filename=asus_F9s_alc861vd.patch
Content-Type: text/x-patch; name=asus_F9s_alc861vd.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-hg20080313/alsa-kernel/pci/hda/patch_realtek.c	2008-03-13 09:00:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-13 10:38:57.000000000 +0800
@@ -12591,7 +12591,7 @@ static struct snd_pci_quirk alc861vd_cfg
 	SND_PCI_QUIRK(0x1019, 0xa88d, "Realtek ALC660 demo", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x103c, 0x30bf, "HP TX1000", ALC861VD_HP),
 	SND_PCI_QUIRK(0x1043, 0x12e2, "Asus z35m", ALC660VD_3ST),
-	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
+	SND_PCI_QUIRK(0x1043, 0x1339, "Asus F9S", ALC861VD_LENOVO),
 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST_DIG),
 	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x1179, 0xff00, "Toshiba A135", ALC861VD_LENOVO),

--=-P6uh2DByo5Kg4TqSdAZS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-P6uh2DByo5Kg4TqSdAZS--
