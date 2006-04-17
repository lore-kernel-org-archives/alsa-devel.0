From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/pci/: remove duplicate #include's
Date: Mon, 17 Apr 2006 03:03:41 +0200
Message-ID: <20060417010341.GA7429@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 4743D19F
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 03:03:41 +0200 (MEST)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There's no reason for #include'ing linux/dma-mapping.h more than once.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ad1889.c           |    1 -
 sound/pci/emu10k1/emu10k1x.c |    1 -
 sound/pci/es1968.c           |    1 -
 sound/pci/ice1712/ice1712.c  |    1 -
 sound/pci/maestro3.c         |    1 -
 sound/pci/mixart/mixart.c    |    1 -
 sound/pci/pcxhr/pcxhr.c      |    1 -
 7 files changed, 7 deletions(-)

--- linux-2.6.17-rc1-mm2-full/sound/pci/ad1889.c.old	2006-04-17 02:51:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/ad1889.c	2006-04-17 02:51:55.000000000 +0200
@@ -37,11 +37,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/emu10k1/emu10k1x.c.old	2006-04-17 02:52:04.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/emu10k1/emu10k1x.c	2006-04-17 02:52:07.000000000 +0200
@@ -34,11 +34,10 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/es1968.c.old	2006-04-17 02:52:16.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/es1968.c	2006-04-17 02:52:27.000000000 +0200
@@ -102,11 +102,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/ice1712/ice1712.c.old	2006-04-17 02:52:31.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/ice1712/ice1712.c	2006-04-17 02:52:34.000000000 +0200
@@ -54,11 +54,10 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 
 #include <sound/core.h>
 #include <sound/cs8427.h>
 #include <sound/info.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/maestro3.c.old	2006-04-17 02:52:43.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/maestro3.c	2006-04-17 02:52:47.000000000 +0200
@@ -39,11 +39,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
-#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/mixart/mixart.c.old	2006-04-17 02:53:06.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/mixart/mixart.c	2006-04-17 02:53:09.000000000 +0200
@@ -26,11 +26,10 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/control.h>
--- linux-2.6.17-rc1-mm2-full/sound/pci/pcxhr/pcxhr.c.old	2006-04-17 02:53:18.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/pci/pcxhr/pcxhr.c	2006-04-17 02:53:21.000000000 +0200
@@ -28,11 +28,10 @@
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
-#include <linux/dma-mapping.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/info.h>
 #include <sound/control.h>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
