From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Add Asus VX1 support.
Date: Sat, 03 Nov 2007 12:52:54 -0700
Message-ID: <1194119574.27981.6.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oG8QcyTR/kjAHrooWnL2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id F1D3F243D9
	for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2007 20:52:56 +0100 (CET)
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


--=-oG8QcyTR/kjAHrooWnL2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Simple patch to add the Asus VX1 laptop to the Analog Devices pci quirk
list.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-oG8QcyTR/kjAHrooWnL2
Content-Disposition: attachment; filename=Asus-VX1.patch
Content-Type: text/x-patch; name=Asus-VX1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 3e1a17f8baca pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Wed Oct 31 17:36:20 2007 +0100
+++ b/pci/hda/patch_analog.c	Sat Nov 03 12:47:36 2007 -0700
@@ -841,6 +841,7 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x1043, 0x1297, "ASUS Z62F", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x12b3, "ASUS V1j", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x1302, "ASUS W3j", AD1986A_LAPTOP_EAPD),
+	SND_PCI_QUIRK(0x1043, 0x1443, "ASUS VX1", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x1447, "ASUS A8J", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x817f, "ASUS P5", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x818f, "ASUS P5", AD1986A_LAPTOP),

--=-oG8QcyTR/kjAHrooWnL2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-oG8QcyTR/kjAHrooWnL2--
