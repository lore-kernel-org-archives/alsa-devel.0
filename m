From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: add D975XBK support to sigmatel patch
Date: Fri, 20 Jan 2006 17:41:44 -0700
Message-ID: <20060120174144.B26939@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8946218F
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 01:41:49 +0100 (MET)
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
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add SigmaTel HDA support for the Intel D975XBK motherboard.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

Index: alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/patch_sigmatel.c,v
retrieving revision 1.13
diff -u -r1.13 patch_sigmatel.c
--- alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c	13 Jan 2006 18:46:21 -0000	1.13
+++ alsa-driver/alsa-kernel/pci/hda/patch_sigmatel.c	21 Jan 2006 00:15:11 -0000
@@ -275,6 +275,9 @@
 	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
 	  .pci_subdevice = 0x0013,
 	  .config = STAC_D945GTP5 },	/* Intel D955XBK - 5 Stack */
+	{ .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x0417,
+	  .config = STAC_D945GTP5 },	/* Intel D975XBK - 5 Stack */
 	{} /* terminator */
 };
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
