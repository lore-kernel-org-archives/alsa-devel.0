From: Baruch Even <baruch@ev-en.org>
Subject: Sound on MSI S420
Date: Fri, 25 May 2007 09:50:44 +0300
Message-ID: <46568744.3030307@ev-en.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000203050404080902080606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galon.ev-en.org (rrcs-24-123-59-149.central.biz.rr.com
	[24.123.59.149]) by alsa0.perex.cz (Postfix) with ESMTP id 98F2B243D5
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 08:51:05 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000203050404080902080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've succeeded by guessing to get my MSI S420 laptop sound to work. 
Attached is a one-liner patch to do that. The patch is against kernel 
2.6.22-rc2.

Since the patch is based on guesswork it might not be optimal but it 
does work for me.

Baruch

--------------000203050404080902080606
Content-Type: text/x-patch;
 name="msi-s420-sound.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msi-s420-sound.patch"

--- 2.6-rc2/sound/pci/hda/patch_realtek.c	2007-05-19 13:56:54.000000000 +0300
+++ 2.6.22-rc2/sound/pci/hda/patch_realtek.c	2007-05-25 00:42:42.000000000 +0300
@@ -6389,6 +6389,7 @@
 	SND_PCI_QUIRK(0x1462, 0x4314, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x4319, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x4324, "MSI", ALC883_TARGA_DIG),
+	SND_PCI_QUIRK(0x1462, 0x3729, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),

--------------000203050404080902080606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000203050404080902080606--
