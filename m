From: Joachim Deguara <dga@idmt.fraunhofer.de>
Subject: [PATCH] RME HDSP MADI  pci naming bug
Date: Tue, 31 May 2005 16:19:40 +0200
Message-ID: <429C727C.9050709@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080503060904000303070101"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080503060904000303070101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
	I discovered a trivial bug where the snd-hdsp and snd-hdspm do not play 
together.  They cannot be loaded as modules simultaneously and create 
detection problems if compiled as static modules in a kernel.  The 
problem come from the sysfs while registering their PCI names, which 
happens to be the same (oops).  Therefore the first module to get loaded 
stayed in, but the secound one would be blocked...not anymore ;)

-joachim

-- 
Joachim Deguara				Email: dga@idmt.fraunhofer.de
Fraunhofer IDMT, Langewiesener St. 22, 98693 Ilmenau, Germany
Phone: +49 3677/69-4851 		Fax:   +49 3677/69-4399

--------------080503060904000303070101
Content-Type: text/x-patch;
 name="hdspm.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdspm.c.diff"

--- hdspm.c_orig	2005-05-31 14:17:12.291154000 +0200
+++ hdspm.c	2005-05-31 14:18:03.017251000 +0200
@@ -1,6 +1,6 @@
 /*   -*- linux-c -*-
  *
- *   ALSA driver for RME Hammerfall DSP audio interface(s)
+ *   ALSA driver for RME Hammerfall DSP MADI audio interface(s)
  *
  *      Copyright (c) 2003 Winfried Ritsch (IEM)
  *      code based on hdsp.c   Paul Davis
@@ -3732,7 +3732,7 @@
 }
 
 static struct pci_driver driver = {
-	.name = "RME Hammerfall DSP",
+	.name = "RME Hammerfall DSP MADI",
 	.id_table = snd_hdspm_ids,
 	.probe = snd_hdspm_probe,
 	.remove = __devexit_p(snd_hdspm_remove),
@@ -3746,7 +3746,7 @@
 		return 0;
 	}
 #ifdef MODULE
-	printk(KERN_ERR "RME Hammerfall-DSP: no HDSPM\n");
+	printk(KERN_ERR "RME Hammerfall-DSP MADI: no HDSPM\n");
 #endif
 	return -ENODEV;
 }
@@ -3755,7 +3755,7 @@
 {
 	pci_unregister_driver(&driver);
 #ifdef MODULE
-	snd_printdd("RME Hammerfall-DSP: HDSPM unloaded\n");
+	snd_printdd("RME Hammerfall-DSP MADI: HDSPM unloaded\n");
 #endif
 
 }

--------------080503060904000303070101--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
