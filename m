From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Added another unknown card to hda-intel
	driver. ASUS P5K-E/WIFI-AP
Date: Wed, 21 May 2008 05:02:09 +1000
Message-ID: <200805210502.09909.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xAyMI3U5qpYnT5q"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-102-183.dial.usertools.net
	[202.137.102.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D0EE124346
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 21:02:39 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id C9B7831CCF
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 19:23:46 +1000 (EST)
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

--Boundary-00=_xAyMI3U5qpYnT5q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog: Added a config table entry for the ASUS P5K-E/WIFI-AP mainboard (ID 
1043:8227) to use AD1988_6STACK_DIG

Signed-off-by: Travis Place <wishie at wishie dot net>

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_xAyMI3U5qpYnT5q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ASUS_P5K-E.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ASUS_P5K-E.patch"

diff -r e2b60934d1c8 pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_analog.c	Wed May 21 04:59:59 2008 +1000
@@ -2858,6 +2858,7 @@ static struct snd_pci_quirk ad1988_cfg_t
 static struct snd_pci_quirk ad1988_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x81ec, "Asus P5B-DLX", AD1988_6STACK_DIG),
 	SND_PCI_QUIRK(0x1043, 0x81f6, "Asus M2N-SLI", AD1988_6STACK_DIG),
+	SND_PCI_QUIRK(0x1043, 0x8277, "Asus P5K-E/WIFI-AP", AD1988_6STACK_DIG),
 	{}
 };
 

--Boundary-00=_xAyMI3U5qpYnT5q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_xAyMI3U5qpYnT5q--
