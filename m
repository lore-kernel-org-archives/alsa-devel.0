From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] fixes au88x0 problem with older kernel
Date: Sat, 17 Jan 2004 00:47:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040116234715.GA535@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


This will fix a problem with undeclared PCI_DEVICE_ID_VIA_8365_1


Index: alsa-driver/pci/au88x0/au88x0.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/au88x0/au88x0.c,v
retrieving revision 1.6
diff -u -r1.6 au88x0.c
--- alsa-driver/pci/au88x0/au88x0.c	13 Jan 2004 08:39:14 -0000	1.6
+++ alsa-driver/pci/au88x0/au88x0.c	16 Jan 2004 23:40:00 -0000
@@ -46,6 +46,13 @@
 MODULE_LICENSE("GPL");
 MODULE_DEVICES("{{Aureal Semiconductor Inc., Aureal Vortex Sound Processor}}");
 
+#ifndef PCI_VENDOR_ID_VIA 
+#define PCI_VENDOR_ID_VIA 0x1106
+#endif
+#ifndef PCI_DEVICE_ID_VIA_8365_1
+#define PCI_DEVICE_ID_VIA_8365_1 0x8305
+#endif
+
 #ifndef MODULE
 /* format is: snd-mychip=enable,index,id */
 static int __init alsa_card_vortex_setup(char *str) {


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
