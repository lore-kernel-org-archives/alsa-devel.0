From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH] cleanup pci init routines
Date: Sat, 20 Mar 2004 21:15:41 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405CFACD.4060106@rogers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600020603080701030806"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
--------------080600020603080701030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch basically does this for the pci drivers in alsa-kernel

   static int __init alsa_card_mychip_init(void)
   {
-          int err;
-
-          if ((err = pci_module_init(&driver)) < 0) {
-  #ifdef MODULE
-                  printk(KERN_ERR "My chip soundcard not found "
-                                  "or device busy\n");
-  #endif
-                  return err;
-          }
-          return 0;
+          return pci_module_init(&driver);
   }

the added message does not really give any additional information. The 
patch also improves the consistency with the majority of the drivers in 
the kernel that just use return pci_module_init(&driver); with out 
giving any message.

-Jeff

--------------080600020603080701030806
Content-Type: text/x-patch;
 name="cleanup-pci-module-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-pci-module-init.patch"

diff -ur alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl alsa-kernel-mod-init/Documentation/DocBook/writing-an-alsa-driver.tmpl
--- alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	2004-03-20 19:33:32.000000000 -0500
+++ alsa-kernel-mod-init/Documentation/DocBook/writing-an-alsa-driver.tmpl	2004-03-20 19:57:12.000000000 -0500
@@ -1355,16 +1355,7 @@
   // initialization of the module
   static int __init alsa_card_mychip_init(void)
   {
-          int err;
-
-          if ((err = pci_module_init(&driver)) < 0) {
-  #ifdef MODULE
-                  printk(KERN_ERR "My chip soundcard not found "
-                                  "or device busy\n");
-  #endif
-                  return err;
-          }
-          return 0;
+          return pci_module_init(&driver);
   }
 
   // clean up the module
@@ -1781,16 +1772,7 @@
 <![CDATA[
   static int __init alsa_card_mychip_init(void)
   {
-          int err;
-
-          if ((err = pci_module_init(&driver)) < 0) {
-  #ifdef MODULE
-                  printk(KERN_ERR "My chip soundcard not found"
-                                  " or device busy\n");
-  #endif
-                  return err;
-          }
-          return 0;
+          return pci_module_init(&driver);
   }
 
   static void __exit alsa_card_mychip_exit(void)
diff -ur alsa-kernel/pci/ali5451/ali5451.c alsa-kernel-mod-init/pci/ali5451/ali5451.c
--- alsa-kernel/pci/ali5451/ali5451.c	2004-03-20 19:33:36.000000000 -0500
+++ alsa-kernel-mod-init/pci/ali5451/ali5451.c	2004-03-20 19:47:12.000000000 -0500
@@ -2289,15 +2289,7 @@
 
 static int __init alsa_card_ali_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ALi pci audio not found or device busy.\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_ali_exit(void)
diff -ur alsa-kernel/pci/als4000.c alsa-kernel-mod-init/pci/als4000.c
--- alsa-kernel/pci/als4000.c	2004-03-20 19:33:34.000000000 -0500
+++ alsa-kernel-mod-init/pci/als4000.c	2004-03-20 19:38:26.000000000 -0500
@@ -755,15 +755,7 @@
 
 static int __init alsa_card_als4000_init(void)
 {
-	int err;
-	
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "no ALS4000 based soundcards found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_als4000_exit(void)
diff -ur alsa-kernel/pci/atiixp.c alsa-kernel-mod-init/pci/atiixp.c
--- alsa-kernel/pci/atiixp.c	2004-03-11 08:14:56.000000000 -0500
+++ alsa-kernel-mod-init/pci/atiixp.c	2004-03-20 19:55:05.000000000 -0500
@@ -1524,16 +1524,7 @@
 
 static int __init alsa_card_atiixp_init(void)
 {
-	int err;
-
-        if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ATI IXP AC97 controller not found or device busy\n");
-#endif
-                return err;
-        }
-
-        return 0;
+        return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_atiixp_exit(void)
diff -ur alsa-kernel/pci/au88x0/au88x0.c alsa-kernel-mod-init/pci/au88x0/au88x0.c
--- alsa-kernel/pci/au88x0/au88x0.c	2004-03-16 10:25:16.000000000 -0500
+++ alsa-kernel-mod-init/pci/au88x0/au88x0.c	2004-03-20 19:54:47.000000000 -0500
@@ -403,16 +403,7 @@
 // initialization of the module
 static int __init alsa_card_vortex_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Aureal soundcard not found "
-		       "or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 // clean up the module
diff -ur alsa-kernel/pci/azt3328.c alsa-kernel-mod-init/pci/azt3328.c
--- alsa-kernel/pci/azt3328.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/azt3328.c	2004-03-20 19:59:26.000000000 -0500
@@ -1573,18 +1573,11 @@
 static int __init alsa_card_azf3328_init(void)
 {
 	int err;
-	
-	snd_azf3328_dbgcallenter();
 
-	if ((err = pci_module_init(&driver)) < 0)
-	{
-#ifdef MODULE
-		printk(KERN_ERR "azt3328: no AZF3328 based soundcards found or device busy\n");
-#endif
-		return err;
-	}
+	snd_azf3328_dbgcallenter();
+	err = pci_module_init(&driver);
 	snd_azf3328_dbgcallleave();
-	return 0;
+	return err;
 }
 
 static void __exit alsa_card_azf3328_exit(void)
diff -ur alsa-kernel/pci/bt87x.c alsa-kernel-mod-init/pci/bt87x.c
--- alsa-kernel/pci/bt87x.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/bt87x.c	2004-03-20 19:40:20.000000000 -0500
@@ -851,16 +851,7 @@
 
 static int __init alsa_card_bt87x_init(void)
 {
-	int err;
-
-	err = pci_module_init(&driver);
-	if (err < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Bt87x soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_bt87x_exit(void)
diff -ur alsa-kernel/pci/cmipci.c alsa-kernel-mod-init/pci/cmipci.c
--- alsa-kernel/pci/cmipci.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/cmipci.c	2004-03-20 19:40:44.000000000 -0500
@@ -3264,15 +3264,7 @@
 	
 static int __init alsa_card_cmipci_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "C-Media PCI soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_cmipci_exit(void)
diff -ur alsa-kernel/pci/cs4281.c alsa-kernel-mod-init/pci/cs4281.c
--- alsa-kernel/pci/cs4281.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/cs4281.c	2004-03-20 19:41:06.000000000 -0500
@@ -2160,15 +2160,7 @@
 	
 static int __init alsa_card_cs4281_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "CS4281 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_cs4281_exit(void)
diff -ur alsa-kernel/pci/cs46xx/cs46xx.c alsa-kernel-mod-init/pci/cs46xx/cs46xx.c
--- alsa-kernel/pci/cs46xx/cs46xx.c	2003-08-12 10:10:14.000000000 -0400
+++ alsa-kernel-mod-init/pci/cs46xx/cs46xx.c	2004-03-20 19:47:44.000000000 -0500
@@ -198,15 +198,7 @@
 
 static int __init alsa_card_cs46xx_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Sound Fusion CS46xx soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_cs46xx_exit(void)
diff -ur alsa-kernel/pci/emu10k1/emu10k1.c alsa-kernel-mod-init/pci/emu10k1/emu10k1.c
--- alsa-kernel/pci/emu10k1/emu10k1.c	2004-03-20 19:33:39.000000000 -0500
+++ alsa-kernel-mod-init/pci/emu10k1/emu10k1.c	2004-03-20 19:50:10.000000000 -0500
@@ -211,15 +211,7 @@
 
 static int __init alsa_card_emu10k1_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "EMU10K1/Audigy soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_emu10k1_exit(void)
diff -ur alsa-kernel/pci/ens1370.c alsa-kernel-mod-init/pci/ens1370.c
--- alsa-kernel/pci/ens1370.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/ens1370.c	2004-03-20 19:41:39.000000000 -0500
@@ -2368,18 +2368,10 @@
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
 };
-	
+
 static int __init alsa_card_ens137x_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Ensoniq AudioPCI soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_ens137x_exit(void)
diff -ur alsa-kernel/pci/es1938.c alsa-kernel-mod-init/pci/es1938.c
--- alsa-kernel/pci/es1938.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/es1938.c	2004-03-20 19:42:12.000000000 -0500
@@ -1700,15 +1700,7 @@
 
 static int __init alsa_card_es1938_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ESS Solo-1 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_es1938_exit(void)
diff -ur alsa-kernel/pci/es1968.c alsa-kernel-mod-init/pci/es1968.c
--- alsa-kernel/pci/es1968.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/es1968.c	2004-03-20 19:42:36.000000000 -0500
@@ -2789,15 +2789,7 @@
 
 static int __init alsa_card_es1968_init(void)
 {
-	int err;
-
-        if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ESS Maestro soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+        return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_es1968_exit(void)
diff -ur alsa-kernel/pci/fm801.c alsa-kernel-mod-init/pci/fm801.c
--- alsa-kernel/pci/fm801.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/fm801.c	2004-03-20 19:43:03.000000000 -0500
@@ -1482,15 +1482,7 @@
 
 static int __init alsa_card_fm801_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ForteMedia FM801 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_fm801_exit(void)
diff -ur alsa-kernel/pci/ice1712/ice1712.c alsa-kernel-mod-init/pci/ice1712/ice1712.c
--- alsa-kernel/pci/ice1712/ice1712.c	2004-03-20 19:33:40.000000000 -0500
+++ alsa-kernel-mod-init/pci/ice1712/ice1712.c	2004-03-20 19:50:40.000000000 -0500
@@ -2661,15 +2661,7 @@
 
 static int __init alsa_card_ice1712_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ICE1712 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_ice1712_exit(void)
diff -ur alsa-kernel/pci/ice1712/ice1724.c alsa-kernel-mod-init/pci/ice1712/ice1724.c
--- alsa-kernel/pci/ice1712/ice1724.c	2004-03-20 19:33:40.000000000 -0500
+++ alsa-kernel-mod-init/pci/ice1712/ice1724.c	2004-03-20 19:51:02.000000000 -0500
@@ -2141,15 +2141,7 @@
 
 static int __init alsa_card_ice1724_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "ICE1724 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_ice1724_exit(void)
diff -ur alsa-kernel/pci/intel8x0.c alsa-kernel-mod-init/pci/intel8x0.c
--- alsa-kernel/pci/intel8x0.c	2004-03-20 19:33:35.000000000 -0500
+++ alsa-kernel-mod-init/pci/intel8x0.c	2004-03-20 19:45:17.000000000 -0500
@@ -2816,9 +2816,6 @@
 	int err;
 
         if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Intel ICH soundcard not found or device busy\n");
-#endif
                 return err;
         }
 #if defined(SUPPORT_JOYSTICK) || defined(SUPPORT_MIDI)
diff -ur alsa-kernel/pci/intel8x0m.c alsa-kernel-mod-init/pci/intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c	2004-03-11 13:32:39.000000000 -0500
+++ alsa-kernel-mod-init/pci/intel8x0m.c	2004-03-20 19:55:27.000000000 -0500
@@ -1463,16 +1463,7 @@
 
 static int __init alsa_card_intel8x0m_init(void)
 {
-	int err;
-
-        if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Intel ICH modemcard not found or device busy\n");
-#endif
-                return err;
-        }
-
-        return 0;
+        return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_intel8x0m_exit(void)
diff -ur alsa-kernel/pci/korg1212/korg1212.c alsa-kernel-mod-init/pci/korg1212/korg1212.c
--- alsa-kernel/pci/korg1212/korg1212.c	2004-03-20 19:33:40.000000000 -0500
+++ alsa-kernel-mod-init/pci/korg1212/korg1212.c	2004-03-20 19:51:19.000000000 -0500
@@ -2525,15 +2525,7 @@
 
 static int __init alsa_card_korg1212_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "No Korg 1212IO cards found\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_korg1212_exit(void)
diff -ur alsa-kernel/pci/maestro3.c alsa-kernel-mod-init/pci/maestro3.c
--- alsa-kernel/pci/maestro3.c	2004-03-20 19:33:36.000000000 -0500
+++ alsa-kernel-mod-init/pci/maestro3.c	2004-03-20 19:45:46.000000000 -0500
@@ -2761,18 +2761,10 @@
 	.resume = snd_m3_resume,
 #endif
 };
-	
+
 static int __init alsa_card_m3_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Maestro3/Allegro soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_m3_exit(void)
diff -ur alsa-kernel/pci/mixart/mixart.c alsa-kernel-mod-init/pci/mixart/mixart.c
--- alsa-kernel/pci/mixart/mixart.c	2004-03-06 11:51:30.000000000 -0500
+++ alsa-kernel-mod-init/pci/mixart/mixart.c	2004-03-20 19:55:49.000000000 -0500
@@ -1432,15 +1432,7 @@
 
 static int __init alsa_card_mixart_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		snd_printk(KERN_ERR "Digigram miXart soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_mixart_exit(void)
diff -ur alsa-kernel/pci/nm256/nm256.c alsa-kernel-mod-init/pci/nm256/nm256.c
--- alsa-kernel/pci/nm256/nm256.c	2004-01-21 13:32:48.000000000 -0500
+++ alsa-kernel-mod-init/pci/nm256/nm256.c	2004-03-20 19:51:58.000000000 -0500
@@ -1669,14 +1669,7 @@
 
 static int __init alsa_card_nm256_init(void)
 {
-	int err;
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "NeoMagic 256 audio soundchip not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_nm256_exit(void)
diff -ur alsa-kernel/pci/rme32.c alsa-kernel-mod-init/pci/rme32.c
--- alsa-kernel/pci/rme32.c	2004-03-20 19:33:36.000000000 -0500
+++ alsa-kernel-mod-init/pci/rme32.c	2004-03-20 19:46:06.000000000 -0500
@@ -1995,15 +1995,7 @@
 
 static int __init alsa_card_rme32_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		snd_printk("No RME Digi32 cards found\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_rme32_exit(void)
diff -ur alsa-kernel/pci/rme9652/hdsp.c alsa-kernel-mod-init/pci/rme9652/hdsp.c
--- alsa-kernel/pci/rme9652/hdsp.c	2004-03-20 19:33:41.000000000 -0500
+++ alsa-kernel-mod-init/pci/rme9652/hdsp.c	2004-03-20 19:52:27.000000000 -0500
@@ -5198,14 +5198,7 @@
 
 static int __init alsa_card_hdsp_init(void)
 {
-	if (pci_module_init(&driver) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "RME Hammerfall-DSP: no cards found\n");
-#endif
-		return -ENODEV;
-	}
-
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_hdsp_exit(void)
diff -ur alsa-kernel/pci/rme9652/rme9652.c alsa-kernel-mod-init/pci/rme9652/rme9652.c
--- alsa-kernel/pci/rme9652/rme9652.c	2004-03-20 19:33:41.000000000 -0500
+++ alsa-kernel-mod-init/pci/rme9652/rme9652.c	2004-03-20 19:52:51.000000000 -0500
@@ -2748,14 +2748,7 @@
 
 static int __init alsa_card_hammerfall_init(void)
 {
-	if (pci_module_init(&driver) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "RME Digi9652/Digi9636: no cards found\n");
-#endif
-		return -ENODEV;
-	}
-
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_hammerfall_exit(void)
diff -ur alsa-kernel/pci/sonicvibes.c alsa-kernel-mod-init/pci/sonicvibes.c
--- alsa-kernel/pci/sonicvibes.c	2004-03-20 19:33:36.000000000 -0500
+++ alsa-kernel-mod-init/pci/sonicvibes.c	2004-03-20 19:46:25.000000000 -0500
@@ -1535,15 +1535,7 @@
 
 static int __init alsa_card_sonicvibes_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "S3 SonicVibes soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_sonicvibes_exit(void)
diff -ur alsa-kernel/pci/trident/trident.c alsa-kernel-mod-init/pci/trident/trident.c
--- alsa-kernel/pci/trident/trident.c	2004-01-26 09:27:13.000000000 -0500
+++ alsa-kernel-mod-init/pci/trident/trident.c	2004-03-20 19:53:16.000000000 -0500
@@ -210,15 +210,7 @@
 
 static int __init alsa_card_trident_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Trident 4DWave PCI soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_trident_exit(void)
diff -ur alsa-kernel/pci/via82xx.c alsa-kernel-mod-init/pci/via82xx.c
--- alsa-kernel/pci/via82xx.c	2004-03-20 19:33:36.000000000 -0500
+++ alsa-kernel-mod-init/pci/via82xx.c	2004-03-20 19:46:46.000000000 -0500
@@ -2182,15 +2182,7 @@
 
 static int __init alsa_card_via82xx_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "VIA 82xx soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_via82xx_exit(void)
diff -ur alsa-kernel/pci/vx222/vx222.c alsa-kernel-mod-init/pci/vx222/vx222.c
--- alsa-kernel/pci/vx222/vx222.c	2004-01-21 13:32:48.000000000 -0500
+++ alsa-kernel-mod-init/pci/vx222/vx222.c	2004-03-20 19:53:43.000000000 -0500
@@ -272,15 +272,7 @@
 
 static int __init alsa_card_vx222_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Digigram VX222 soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_vx222_exit(void)
diff -ur alsa-kernel/pci/ymfpci/ymfpci.c alsa-kernel-mod-init/pci/ymfpci/ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	2004-01-26 09:27:13.000000000 -0500
+++ alsa-kernel-mod-init/pci/ymfpci/ymfpci.c	2004-03-20 19:54:11.000000000 -0500
@@ -352,15 +352,7 @@
 
 static int __init alsa_card_ymfpci_init(void)
 {
-	int err;
-
-	if ((err = pci_module_init(&driver)) < 0) {
-#ifdef MODULE
-		printk(KERN_ERR "Yamaha DS-XG PCI soundcard not found or device busy\n");
-#endif
-		return err;
-	}
-	return 0;
+	return pci_module_init(&driver);
 }
 
 static void __exit alsa_card_ymfpci_exit(void)

--------------080600020603080701030806--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
