From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] miro: add missing INSTALL text for snd-miro
Date: Wed, 22 Jun 2005 21:04:31 +0200
Message-ID: <20050622190431.GA3596@tuba>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 436511EF
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 21:02:23 +0200 (MEST)
Received: from ml by tuba with local (Exim 4.50)
	id 1DlAWV-0000wM-Fm
	for alsa-devel@alsa-project.org; Wed, 22 Jun 2005 21:04:31 +0200
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The INSTALL file has no information about the miro module. This patch 
lists supported miro cards and describes all the module parameters for 
snd-miro.

Signed-off-by: Martin Langer <martin-langer@gmx.de>

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="miro.patch"

--- alsa-driver/INSTALL.orig	Wed Jun 22 20:17:56 2005
+++ alsa-driver/INSTALL	Wed Jun 22 20:51:51 2005
@@ -378,6 +378,23 @@
     For X86 only.  The kernel patch is required in advance, found in
     utils/patches/pcsp-kernel-2.6.10-03.diff
 
+  Module snd-miro
+  ---------------
+
+    Module for Miro soundcards: miroSOUND PCM 1 pro, 
+				miroSOUND PCM 12,
+				miroSOUND PCM 20 Radio.
+
+    port	- Port # (0x530,0x604,0xe80,0xf40)
+    irq		- IRQ # (5,7,9,10,11)
+    dma1	- 1st dma # (0,1,3)
+    dma2	- 2nd dma # (0,1)
+    mpu_port	- MPU-401 port # (0x300,0x310,0x320,0x330)
+    mpu_irq	- MPU-401 irq # (5,7,9,10)
+    fm_port	- FM Port # (0x388)
+    wss		- enable WSS mode
+    ide		- enable onboard ide support
+
 
 Trouble Shooting
 ================

--wRRV7LY7NUeQGEoC--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
