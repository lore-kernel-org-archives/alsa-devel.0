From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: fix sigmatel dell system detection
Date: Tue, 31 Oct 2006 11:08:35 -0500
Message-ID: <20061031160835.GA15700@matthew-porters-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 541F42CA
	for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2006 17:08:42 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fixes Dell system detection on 9200 codecs. The support
to detect certain Dell machines was merged in the
9205 table where it will be unused on the various Dell
9200-based codec systems. This moves the subsystem IDs
to the correct 9200 table.

Jaroslav, can you please apply since Takashi is on holiday?

Thanks,
Matt

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r 87a5ba579e53 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Oct 26 17:12:59 2006 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Oct 27 12:48:20 2006 -0700
@@ -382,6 +382,13 @@ static struct hda_board_config stac9200_
 	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
 	  .pci_subdevice = 0x2668,	/* DFI LanParty */
 	  .config = STAC_REF },
+	/* Dell laptops have BIOS problem */
+	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01b5,
+	  .config = STAC_REF },	/* Dell Inspiron 630m */
+	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01c2,
+	  .config = STAC_REF },	/* Dell Latitude D620 */
+	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01cb,
+	  .config = STAC_REF },	/* Dell Latitude 120L */
 	{} /* terminator */
 };
 
@@ -637,13 +644,6 @@ static struct hda_board_config stac9205_
 	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
 	  .pci_subdevice = 0x2668,	/* DFI LanParty */
 	  .config = STAC_REF },		/* SigmaTel reference board */
-	/* Dell laptops have BIOS problem */
-	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01b5,
-	  .config = STAC_REF },	/* Dell Inspiron 630m */
-	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01c2,
-	  .config = STAC_REF },	/* Dell Latitude D620 */
-	{ .pci_subvendor = PCI_VENDOR_ID_DELL, .pci_subdevice = 0x01cb,
-	  .config = STAC_REF },	/* Dell Latitude 120L */
 	{} /* terminator */
 };
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
