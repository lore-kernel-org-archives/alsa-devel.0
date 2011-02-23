From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: HDA: Add ideapad quirk for two Dell
	machines
Date: Wed, 23 Feb 2011 13:23:20 +0100
Message-ID: <4D64FC38.7040604@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070408030205050402080201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BC78103800
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 13:23:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070408030205050402080201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070408030205050402080201
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Add-ideapad-quirk-for-two-Dell-machines.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Add-ideapad-quirk-for-two-Dell-machines.patch"

>From 2b56e004fc05bf01d19010f30a1f888678a4a729 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 23 Feb 2011 13:15:56 +0100
Subject: [PATCH 2/2] ALSA: HDA: Add ideapad quirk for two Dell machines

These two Dell machines have been reported working well with
the ideapad model.

BugLink: http://bugs.launchpad.net/bugs/723676
Cc: stable@kernel.org
Tested-by: David Chen <david.chen@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 909ce9e..4d5004e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3114,6 +3114,8 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0401, "Dell Vostro 1014", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0402, "Dell Vostro", CXT5066_DELL_VOSTRO),
 	SND_PCI_QUIRK(0x1028, 0x0408, "Dell Inspiron One 19T", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x1028, 0x050f, "Dell Inspiron", CXT5066_IDEAPAD),
+	SND_PCI_QUIRK(0x1028, 0x0510, "Dell Vostro", CXT5066_IDEAPAD),
 	SND_PCI_QUIRK(0x103c, 0x360b, "HP G60", CXT5066_HP_LAPTOP),
 	SND_PCI_QUIRK(0x1043, 0x13f3, "Asus A52J", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1643, "Asus K52JU", CXT5066_ASUS),
-- 
1.7.1


--------------070408030205050402080201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070408030205050402080201--
