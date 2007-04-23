From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add support for Asus A8JN Laptop
Date: Mon, 23 Apr 2007 07:38:28 -0700
Message-ID: <1177339108.4274.9.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Bi3Xy6NB5E7/R09K9iQq"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D2E3E24858
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 16:38:30 +0200 (CEST)
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


--=-Bi3Xy6NB5E7/R09K9iQq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Asus A8JN Laptop.  


Other modes were tested, this one worked best.

Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-Bi3Xy6NB5E7/R09K9iQq
Content-Disposition: attachment; filename=Asus-A8J.patch
Content-Type: text/x-patch; name=Asus-A8J.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 202af90f8e68 pci/hda/patch_analog.c
--- a/pci/hda/patch_analog.c	Thu Apr 19 15:22:56 2007 +0200
+++ b/pci/hda/patch_analog.c	Sat Apr 21 10:38:57 2007 -0700
@@ -834,6 +834,7 @@ static struct snd_pci_quirk ad1986a_cfg_
 	SND_PCI_QUIRK(0x1043, 0x1297, "ASUS Z62F", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x12b3, "ASUS V1j", AD1986A_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x1302, "ASUS W3j", AD1986A_LAPTOP_EAPD),
+	SND_PCI_QUIRK(0x1043, 0x1447, "ASUS A8J", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x817f, "ASUS P5", AD1986A_3STACK),
 	SND_PCI_QUIRK(0x1043, 0x818f, "ASUS P5", AD1986A_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x81b3, "ASUS P5", AD1986A_3STACK),

--=-Bi3Xy6NB5E7/R09K9iQq
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-Bi3Xy6NB5E7/R09K9iQq--
