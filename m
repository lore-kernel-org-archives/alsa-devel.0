From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix auto-mute on Lenovo Edge 14
Date: Wed, 15 Dec 2010 08:14:55 +0100
Message-ID: <4D086AEF.2090608@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070009030306060104090905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 41D5D243D3
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 08:14:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070009030306060104090905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The SKU value of this machine dictates that auto-mute should be
disabled. Since the SKU value is similar to the PCI SSID, the most
likely conclusion is that the SKU value should be ignored.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070009030306060104090905
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-auto-mute-on-Lenovo-Edge-14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Fix-auto-mute-on-Lenovo-Edge-14.patch"

>From 84d84db7dbcbf0ceaad3ed016bde6446629566b7 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 15 Dec 2010 08:01:46 +0100
Subject: [PATCH] ALSA: HDA: Fix auto-mute on Lenovo Edge 14

BugLink: http://launchpad.net/bugs/690530

The SKU value of this machine dictates that auto-mute should be
disabled. Since the SKU value is similar to the PCI SSID, the most
likely conclusion is that the SKU value should be ignored.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cd2d3a5..3aeda3a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14808,6 +14808,7 @@ static int alc269_resume(struct hda_codec *codec)
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC269_FIXUP_DELL_M101Z,
+	ALC269_FIXUP_LENOVO_EDGE14,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -14825,11 +14826,15 @@ static const struct alc_fixup alc269_fixups[] = {
 			{}
 		}
 	},
+	[ALC269_FIXUP_LENOVO_EDGE14] = {
+		.sku = ALC_FIXUP_SKU_IGNORE,
+	},
 };
 
 static struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
+	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_LENOVO_EDGE14),
 	{}
 };
 
-- 
1.7.1


--------------070009030306060104090905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070009030306060104090905--
