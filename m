From: David Henningsson <david.henningsson@canonical.com>
Subject: ALSA: HDA: Enable subwoofer on Asus G73Jw
Date: Wed, 15 Dec 2010 09:23:44 +0100
Message-ID: <4D087B10.8000809@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000209010007070307000106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 61739243D8
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 09:23:47 +0100 (CET)
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
--------------000209010007070307000106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Set default association/sequence right on pin 0x17 in order for
the automatic parser to recognize the subwoofer correctly.

Patch rewritten to fit with the patch applied earlier today; let me know 
if you want the original as well (might suit stable better?).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------000209010007070307000106
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Enable-subwoofer-on-Asus-G73Jw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Enable-subwoofer-on-Asus-G73Jw.patch"

>From caa3fbacba497e402468acdc7df96e647efe903c Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 15 Dec 2010 09:18:18 +0100
Subject: [PATCH] ALSA: HDA: Enable subwoofer on Asus G73Jw

Set default association/sequence right on pin 0x17 in order for
the automatic parser to recognize the subwoofer correctly.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3aeda3a..3cfce09 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14809,6 +14809,7 @@ enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC269_FIXUP_DELL_M101Z,
 	ALC269_FIXUP_LENOVO_EDGE14,
+	ALC269_FIXUP_ASUS_G73JW,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -14829,12 +14830,19 @@ static const struct alc_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_LENOVO_EDGE14] = {
 		.sku = ALC_FIXUP_SKU_IGNORE,
 	},
+	[ALC269_FIXUP_ASUS_G73JW] = {
+		.pins = (const struct alc_pincfg[]) {
+			{ 0x17, 0x99130111 }, /* subwoofer */
+			{ }
+		}
+	},
 };
 
 static struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_LENOVO_EDGE14),
+	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	{}
 };
 
-- 
1.7.1


--------------000209010007070307000106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000209010007070307000106--
