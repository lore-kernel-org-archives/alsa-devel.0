From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Make the HP EliteBook 8530p use AD1884A model
	'laptop' by default.
Date: Tue, 11 Nov 2008 02:54:02 +1000
Message-ID: <200811110254.02476.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qcGGJxbOPs3U0bW"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 0302224373
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 17:54:07 +0100 (CET)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 9F8DAEC1E1
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 17:16:13 +1000 (EST)
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

--Boundary-00=_qcGGJxbOPs3U0bW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog:

Added a QUIRK to patch_analog.c for the HP Elitebook 8530p (IDs 0x103c:0x30e7) 
to use AD1884A model 'laptop' by default. Playback and Capture confirmed 
working.

Signed-off-by: Travis Place

--Boundary-00=_qcGGJxbOPs3U0bW
Content-Type: text/x-diff;
  charset="utf-8";
  name="patch_analog.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch_analog.c.patch"

--- patch_analog.c	2008-11-11 02:46:21.000000000 +1000
+++ patch_analog.c.new	2008-11-11 02:49:28.000000000 +1000
@@ -3859,6 +3859,7 @@
 static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x3030, "HP", AD1884A_MOBILE),
 	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
+	SND_PCI_QUIRK(0x103c, 0x30e7, "HP EliteBook 8530p", AD1884A_LAPTOP),
 	SND_PCI_QUIRK(0x17aa, 0x20ac, "Thinkpad X300", AD1884A_THINKPAD),
 	{}
 };

--Boundary-00=_qcGGJxbOPs3U0bW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_qcGGJxbOPs3U0bW--
