From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH] patch_realtek.c: Add new model
Date: Thu, 26 Jan 2006 11:53:28 +0100
Message-ID: <m3y813ntuf.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D78819C
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 11:51:33 +0100 (MET)
Received: from anduin.mandrakesoft.com (anduin.mandrakesoft.com [192.168.100.45])
	by office.mandriva.com (Postfix) with ESMTP id 383F95341B
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 11:51:33 +0100 (CET)
Received: from anduin.mandrakesoft.com (localhost [127.0.0.1])
	by anduin.mandrakesoft.com (Postfix) with ESMTP id ECA84FF855
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 11:53:28 +0100 (CET)
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

--=-=-=

Hi,

This little patch add the model for the motherboard K8N51 from Gigabyte
to the known models of ALC boards.


Signed-off-by: Arnaud Patard <apatard@mandriva.com>
 ---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=patch_realtek_add_gigabyte_k8n51.patch

Index: alsa-cvs/alsa-kernel/pci/hda/patch_realtek.c
===================================================================
--- a/sound/pci/hda.orig/patch_realtek.c
+++ a/sound/pci/hda/patch_realtek.c
@@ -1668,6 +1668,7 @@ static struct hda_board_config alc880_cf
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x8196, .config = ALC880_6ST }, /* ASUS P5GD1-HVM */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x81b4, .config = ALC880_6ST },
 	{ .pci_subvendor = 0x1019, .pci_subdevice = 0xa884, .config = ALC880_6ST }, /* Acer APFV */
+	{ .pci_subvendor = 0x1458, .pci_subdevice = 0xa102, .config = ALC880_6ST }, /* Gigabyte K8N51 */
 
 	{ .modelname = "6stack-digout", .config = ALC880_6ST_DIG },
 	{ .pci_subvendor = 0x2668, .pci_subdevice = 0x8086, .config = ALC880_6ST_DIG },

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
