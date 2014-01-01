From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Disable Front HP jack detection on
	Gigabyte Z87X-UD3H
Date: Wed,  1 Jan 2014 14:01:34 +0100
Message-ID: <1388581294-3390-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 375E72610A5
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 14:01:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, 1248116@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

This motherboard seems to have a flaky jack detection - when the
front HP is not present, the jack state quickly switches on and off.

This has been reported by three people in the bug, so I doubt it's
a user error this time.

BugLink: https://bugs.launchpad.net/bugs/1248116
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 16c0caa..6a705a8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1810,6 +1810,7 @@ enum {
 	ALC882_FIXUP_ACER_ASPIRE_7736,
 	ALC882_FIXUP_ASUS_W90V,
 	ALC889_FIXUP_CD,
+	ALC889_FIXUP_FRONT_HP_NO_PRESENCE,
 	ALC889_FIXUP_VAIO_TT,
 	ALC888_FIXUP_EEE1601,
 	ALC882_FIXUP_EAPD,
@@ -2027,6 +2028,15 @@ static const struct hda_fixup alc882_fixups[] = {
 			{ }
 		}
 	},
+	[ALC889_FIXUP_FRONT_HP_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x02214120 }, /* Front HP jack is flaky, disable jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC889_FIXUP_CD,
+	},
 	[ALC889_FIXUP_VAIO_TT] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -2258,7 +2268,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
-	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3", ALC889_FIXUP_CD),
+	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", ALC882_FIXUP_ABIT_AW9D_MAX),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
-- 
1.7.9.5
