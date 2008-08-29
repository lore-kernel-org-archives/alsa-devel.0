From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Automatically use ALC268_TOSHIBA for Toshiba
	L305 Laptop
Date: Sat, 30 Aug 2008 04:51:04 +1000
Message-ID: <200808300451.04275.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YUEuIEuTuULSSq6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id BDFEA24440
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 20:51:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_YUEuIEuTuULSSq6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog: Added Subsystem IDs (0x1179, 0xff64) for the Toshiba Satellite L305 
laptop, so it automatically uses the ALC268_TOSHIBA quirk.

Signed-off-by: Travis Place <wishie@wishie.net>

Patch Attached.

Thanks,
Travis Place (wishie)

--Boundary-00=_YUEuIEuTuULSSq6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch_realtek.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_realtek.c.patch"

--- patch_realtek.c.orig	2008-08-30 04:45:43.000000000 +1000
+++ patch_realtek.c	2008-08-30 04:47:21.000000000 +1000
@@ -11447,6 +11447,7 @@
 	SND_PCI_QUIRK(0x1043, 0x1205, "ASUS W7J", ALC268_3ST),
 	SND_PCI_QUIRK(0x1179, 0xff10, "TOSHIBA A205", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x1179, 0xff50, "TOSHIBA A305", ALC268_TOSHIBA),
+	SND_PCI_QUIRK(0x1179, 0xff64, "TOSHIBA L305", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x14c0, 0x0025, "COMPAL IFL90/JFL-92", ALC268_TOSHIBA),
 	SND_PCI_QUIRK(0x152d, 0x0763, "Diverse (CPR2000)", ALC268_ACER),
 	SND_PCI_QUIRK(0x152d, 0x0771, "Quanta IL1", ALC267_QUANTA_IL1),

--Boundary-00=_YUEuIEuTuULSSq6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_YUEuIEuTuULSSq6--
