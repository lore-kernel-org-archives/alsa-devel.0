From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Added support to HDAIntel driver for the
	Foxconn P35AX-S mainboard
Date: Wed, 21 May 2008 00:12:02 +1000
Message-ID: <200805210012.02703.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ywtMIOoLLKqKK2H"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-102-183.dial.usertools.net
	[202.137.102.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 784392488E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 16:12:29 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 416CD31CA3
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 14:33:38 +1000 (EST)
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

--Boundary-00=_ywtMIOoLLKqKK2H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Without forcing model type to 6stack-dig, the user gets no sound.

Patch is attached, and alsa-info.sh output is at http://pastebin.ca/1023781.

Changelog: Added IDs for the Foxconn P35AX-S mainboard to patch_realtek.c, so 
that ALC883_6ST_DIG is used by default.

Signed-off-by: Travis Place <wishie at wishie dot net>

Also, on a side note, are we to use the GIT repo from now on ? I just tried to 
pull from it, and got an error. HG seems to be working for me still though.

Thanks,
Travis Place.

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_ywtMIOoLLKqKK2H
Content-Type: text/x-diff;
  charset="us-ascii";
  name="FoxconnP35AX-S.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="FoxconnP35AX-S.patch"

diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Wed May 21 00:05:49 2008 +1000
@@ -7744,6 +7744,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC883_6ST_DIG),
+	SND_PCI_QUIRK(0x105b, 0x0ce8, "Foxconn P35AX-S", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1071, 0x8253, "Mitac 8252d", ALC883_MITAC),
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x108e, 0x534d, NULL, ALC883_3ST_6ch),

--Boundary-00=_ywtMIOoLLKqKK2H
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_ywtMIOoLLKqKK2H--
