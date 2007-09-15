From: Tobin Davis <tdavis@dsl-only.net>
Subject: hda-codec:  Add two new systems to ALC883
Date: Sat, 15 Sep 2007 11:08:02 -0700
Message-ID: <1189879682.17677.14.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-q5gf2rFuhf3PxcNm6ZNt"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 674441037F2
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 20:08:04 +0200 (CEST)
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


--=-q5gf2rFuhf3PxcNm6ZNt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Asus M2A-VM HDMI and Abit IP35-PRO
motherboards.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-q5gf2rFuhf3PxcNm6ZNt
Content-Disposition: attachment; filename=Asus-M2A-VM.patch
Content-Type: text/x-patch; name=Asus-M2A-VM.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9fe2d7b6498b pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Wed Sep 12 13:31:47 2007 +0200
+++ b/pci/hda/patch_realtek.c	Thu Sep 13 22:18:43 2007 -0700
@@ -7041,6 +7054,8 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x17c0, 0x4071, "MEDION MD2", ALC883_MEDION_MD2),
 	SND_PCI_QUIRK(0x1991, 0x5625, "Haier W66", ALC883_HAIER_W66),
 	SND_PCI_QUIRK(0x17aa, 0x3bfc, "Lenovo NB0763", ALC883_LENOVO_NB0763),
+	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
+       SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
 	{}
 };
 

--=-q5gf2rFuhf3PxcNm6ZNt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-q5gf2rFuhf3PxcNm6ZNt--
