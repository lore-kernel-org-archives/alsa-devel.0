From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] hda-intel: fix ASUS M2V detection
Date: Sun, 20 May 2007 21:55:10 +0100 (BST)
Message-ID: <20070520205510.D46747B409F@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49]) by alsa0.perex.cz (Postfix) with ESMTP id 853E5245E2
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2007 22:55:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit f32610edab47f36946d23b883aeae91e15986121 added ALC660VD support, but
this caused a 2.6.21 regression for some users. The ASUS M2V device is
now detected as ALC660VD rather than ALC660/861 but the PCI quirk was not
carried over.

This patch allows affected users to use audio again.
http://bugzilla.kernel.org/show_bug.cgi?id=8273
https://bugs.gentoo.org/show_bug.cgi?id=178243

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/sound/pci/hda/patch_realtek.c
===================================================================
--- linux.orig/sound/pci/hda/patch_realtek.c
+++ linux/sound/pci/hda/patch_realtek.c
@@ -8384,7 +8384,6 @@ static struct snd_pci_quirk alc861_cfg_t
 	SND_PCI_QUIRK(0x1043, 0x1338, "ASUS F2/3", ALC861_ASUS_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x13d7, "ASUS A9rp", ALC861_ASUS_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x1393, "ASUS", ALC861_ASUS),
-	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660_3ST),
 	SND_PCI_QUIRK(0x1179, 0xff00, "Toshiba", ALC861_TOSHIBA),
 	SND_PCI_QUIRK(0x1179, 0xff10, "Toshiba", ALC861_TOSHIBA),
 	SND_PCI_QUIRK(0x1584, 0x9072, "Uniwill m31", ALC861_UNIWILL_M31),
@@ -8990,6 +8989,7 @@ static const char *alc861vd_models[ALC86
 static struct snd_pci_quirk alc861vd_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e2, "Asus z35m", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
+	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
 	SND_PCI_QUIRK(0x1019, 0xa88d, "Realtek ALC660 demo", ALC660VD_3ST),
