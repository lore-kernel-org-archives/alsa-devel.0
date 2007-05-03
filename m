From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add support for new HP DV series laptops
Date: Thu, 03 May 2007 00:15:57 -0700
Message-ID: <1178176557.4854.8.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-IxXlH7XMJ/WdC1uKA5VU"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A33B244E9
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 09:15:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-IxXlH7XMJ/WdC1uKA5VU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for 3 new HP laptops to the Conexant "Venice"
driver.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-IxXlH7XMJ/WdC1uKA5VU
Content-Disposition: attachment; filename=conexant-test21.patch
Content-Type: text/x-patch; name=conexant-test21.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 4e09f3b9fd66 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Wed May 02 12:09:48 2007 +0200
+++ b/pci/hda/patch_conexant.c	Thu May 03 00:11:20 2007 -0700
@@ -787,6 +787,9 @@ static struct snd_pci_quirk cxt5045_cfg_
 static struct snd_pci_quirk cxt5045_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x30b7, "HP DV6000Z", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30b2, "HP DV Series", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30b5, "HP DV2120", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
 	SND_PCI_QUIRK(0x8086, 0x2111, "Conexant Reference board", CXT5045_LAPTOP),
 	{}

--=-IxXlH7XMJ/WdC1uKA5VU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-IxXlH7XMJ/WdC1uKA5VU--
