From: Pascal Terjan <pterjan@mandriva.com>
Subject: [PATCH] ALC288 - Add NEC S970 to the quirk table
Date: Mon, 03 Mar 2008 20:30:25 +0100
Message-ID: <1204572625.24326.21.camel@plop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-U0KY4+nvx8TNRbhy+w7n"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ryu.zarb.org (ryu.zarb.org [212.85.153.228])
	by alsa0.perex.cz (Postfix) with ESMTP id B33BB2435A
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 20:30:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ryu.zarb.org (Postfix) with ESMTP id E64DD3F5FA
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 20:30:28 +0100 (CET)
Received: from ryu.zarb.org ([127.0.0.1])
	by localhost (ryu.zarb.org [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id QDWeomSj92Ho for <alsa-devel@alsa-project.org>;
	Mon,  3 Mar 2008 20:30:27 +0100 (CET)
Received: from [192.168.100.212] (office-abk.mandriva.com [84.55.162.90])
	by ryu.zarb.org (Postfix) with ESMTP id D6C143F5E9
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 20:30:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-U0KY4+nvx8TNRbhy+w7n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

NEC S970 has no sound in the internal speakers when autodetection is
used. 
With targa-dig model, there is sound in the speakers and it gets
correctly muted when pluging headphones.



--=-U0KY4+nvx8TNRbhy+w7n
Content-Disposition: attachment; filename=ALC288-Add-NEC-S970-to-the-quirk-table.patch
Content-Type: text/x-patch; name=ALC288-Add-NEC-S970-to-the-quirk-table.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- pci/hda/patch_realtek.c	2008-03-03 19:45:07.000000000 +0100
+++ pci/hda/patch_realtek.c.new	2008-03-03 19:44:54.000000000 +0100
@@ -7622,6 +7622,7 @@
 	SND_PCI_QUIRK(0x1462, 0x040d, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x0579, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3729, "MSI S420", ALC883_TARGA_DIG),
+	SND_PCI_QUIRK(0x1462, 0x3783, "NEC S970", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3b7f, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3ef9, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3fc1, "MSI", ALC883_TARGA_DIG),

--=-U0KY4+nvx8TNRbhy+w7n
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-U0KY4+nvx8TNRbhy+w7n--
