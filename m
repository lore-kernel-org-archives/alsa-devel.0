From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA - Change default configuration for Fujitsu Si3515.
Date: Thu, 21 Jun 2007 10:50:21 -0700
Message-ID: <1182448221.15219.251.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6VnCmjbQ/7HEAauu41y6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D31710384B
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 19:50:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-6VnCmjbQ/7HEAauu41y6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes the default configuration for the Fujitsu Siemens
Si3515 Laptop.
 

Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-6VnCmjbQ/7HEAauu41y6
Content-Disposition: attachment; filename=conexant-FS3515-2.patch
Content-Type: text/x-patch; name=conexant-FS3515-2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r deaa182aebd8 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Wed Jun 20 15:46:13 2007 +0200
+++ b/pci/hda/patch_conexant.c	Thu Jun 21 10:48:49 2007 -0700
@@ -802,7 +802,7 @@ static struct snd_pci_quirk cxt5045_cfg_
 	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
-	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_FUJITSU),
+	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
 	{}
 };

--=-6VnCmjbQ/7HEAauu41y6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-6VnCmjbQ/7HEAauu41y6--
