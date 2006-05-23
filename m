From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002150]: [PATCH] Adding functionality for Prodigy 7.1LT
Date: Tue, 23 May 2006 15:46:46 +0200
Message-ID: <9d5bf3fac0e551b365fd16a499a5ad27@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E155D16B
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 15:46:46 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2150> 
======================================================================
Reported By:                Demosthenes
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2150
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-23-2006 13:07 CEST
Last Modified:              05-23-2006 15:46 CEST
======================================================================
Summary:                    [PATCH] Adding functionality for Prodigy 7.1LT
Description: 
Hello, I would like to indicate a patch provided in another thread that has
since become idle:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1744

This patch is not written by me and the person who wrote the patch no
longer owns this sound card.  However the changes it makes are fairly
simple and add much in the way of functionality.

This patch is known to add support for useable front audio channels, user
controllable headphone channel and support for optical output.(as reported
in this thread)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2109


I have been using this patch for some time (and with the latest stable
ALSA) and have had no problems, other users have also had similar
success.

I would greatly appreciate if this patch could be adopted and added to
ALSA since it is a great improvement on the previous driver.

Thank you.

P.S. I hope that this is a suitable way to suggest this patch, I have
already tried bumping the original issue but with no success.
======================================================================

----------------------------------------------------------------------
 Demosthenes - 05-23-06 15:36 
----------------------------------------------------------------------
[Disclaimer: I did not write this but I dont know how to get in touch with
the guy that did. I have never done this before so please bear with me, do
I sign off the patch despite not writing it or can someone else do that?
The diff here I did today using ALSA CVS.]

Summary: Add functionality for Audiotrak Prodigy 7.1 LT

This patch adds support for useable front audio channels, user
controllable headphone channel and optical output.

Credit for this patch must go to Anho Ki.

(Please replace this line if neccessary)
(Signed-off-by: Matt Taylor <mwtaylor@gmail.com>)

--- alsa-kernel/pci/ice1712/aureon.c_orig	2006-05-23 14:08:17.000000000
+0100
+++ alsa-kernel/pci/ice1712/aureon.c	2006-05-23 14:11:49.000000000 +0100
@@ -1281,9 +1281,15 @@
 
 	tmp2 = tmp = snd_ice1712_gpio_read(ice);
 	if (enable)
-		tmp |= AUREON_HP_SEL;
+		if (ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71LT)
+			tmp |= AUREON_HP_SEL;
+		else
+			tmp |= PRODIGY_HP_SEL;
 	else
-		tmp &= ~ AUREON_HP_SEL;
+		if (ice->eeprom.subvendor != VT1724_SUBDEVICE_PRODIGY71LT)
+			tmp &= ~ AUREON_HP_SEL;
+		else
+			tmp &= ~ PRODIGY_HP_SEL;
 	if (tmp != tmp2) {
 		snd_ice1712_gpio_write(ice, tmp);
 		return 1;
@@ -2079,16 +2085,16 @@
 };
 
 static unsigned char prodigy71lt_eeprom[] __devinitdata = {
-	0x0b,	/* SYSCINF: clock 512, spdif-in/ADC, 4DACs */
+	0x4b,	/* SYSCINF: clock 512, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
 	0xfc,	/* I2S: vol, 96k, 24bit, 192k */
-	0xc3,	/* SPDUF: out-en, out-int */
-	0x00,	/* GPIO_DIR */
-	0x07,	/* GPIO_DIR1 */
-	0x00,	/* GPIO_DIR2 */
-	0xff,	/* GPIO_MASK */
-	0xf8,	/* GPIO_MASK1 */
-	0xff,	/* GPIO_MASK2 */
+	0xc3,	/* SPDIF: out-en, out-int */
+	0xff,	/* GPIO_DIR */
+	0xff,	/* GPIO_DIR1 */
+	0x5f,	/* GPIO_DIR2 */
+	0x00,	/* GPIO_MASK */
+	0x00,	/* GPIO_MASK1 */
+	0x00,	/* GPIO_MASK2 */
 	0x00,	/* GPIO_STATE */
 	0x00,	/* GPIO_STATE1 */
 	0x00,	/* GPIO_STATE2 */
--- alsa-kernel/pci/ice1712/aureon.h_orig	2006-05-23 14:03:26.000000000
+0100
+++ alsa-kernel/pci/ice1712/aureon.h	2006-05-23 14:05:10.000000000 +0100
@@ -58,5 +58,6 @@
 #define PRODIGY_WM_CS		(1 << 8)
 #define PRODIGY_SPI_MOSI	(1 << 10)
 #define PRODIGY_SPI_CLK		(1 << 9)
+#define PRODIGY_HP_SEL		(1 << 5)
 
 #endif /* __SOUND_AUREON_H */

----------------------------------------------------------------------
 tiwai - 05-23-06 15:46 
----------------------------------------------------------------------
Thanks, applied to HG repo now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 13:07 Demosthenes    New Issue                                    
05-23-06 14:51 tiwai          Note Added: 0009933                          
05-23-06 15:36 Demosthenes    Note Added: 0009936                          
05-23-06 15:46 tiwai          Status                   new => resolved     
05-23-06 15:46 tiwai          Resolution               open => fixed       
05-23-06 15:46 tiwai          Assigned To               => tiwai           
05-23-06 15:46 tiwai          Note Added: 0009937                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
