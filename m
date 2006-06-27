From: Henrik Kretzschmar <henrik.kretzschmar@gmx.net>
Subject: [PATCH] Prodif Plus device-ID cleanup and
 MODULE_DEVICE_TABLE() - macro
Date: Tue, 27 Jun 2006 19:43:22 +0200
Message-ID: <44A16E3A.3050806@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there!

This week I got a Prodif Plus and tried it out with ALSA.
There seems to be some work to do to get it run again,
 so here is the first patch.
Is there somebody else using this driver?
---
From: Henrik Kretzschmar <henrik.kretzschmar@gmx.net>

Some pci_device_id cleanups and adding MODULE_DEVICE_ID() macro.
Signed-off-by: Henrik Kretzschmar <henrik.kretzschmar@gmx.net>
---

--- alsa-driver-1.0.12rc1.orig/pci/pdplus/pdplus.c	2006-06-22 18:24:22.000000000 +0200
+++ alsa-driver-1.0.12rc1/pci/pdplus/pdplus.c	2006-06-27 19:31:45.000000000 +0200
@@ -6174,16 +6174,13 @@
         LEAVE_VOID;
 }

-static struct pci_device_id pdplus_ids[] = {
-        {
-                PCI_VENDOR_ID_MARIAN,
-                PCI_DEVICE_ID_MARIAN_PRODIF_PLUS,
-                PCI_ANY_ID, PCI_ANY_ID,
-                0, 0, 0,
-        },
+static struct pci_device_id pdplus_ids[] __devinitdata = {
+        { 0x1382, 0x2048, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
         { 0, }
 };

+MODULE_DEVICE_TABLE(pci, pdplus_ids);
+
 /* ********************************************************************** */

 static struct pci_driver driver = {

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
