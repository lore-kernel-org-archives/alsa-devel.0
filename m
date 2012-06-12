From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Pin fixup for Zotac Z68 motherboard
Date: Tue, 12 Jun 2012 13:15:12 +0200
Message-ID: <1339499712-4468-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 427F424453
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 13:15:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, 993162@bugs.launchpad.net
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Pin 0x1b was connected to the front panel connector, which according to
the HDA standard should contain a mic and a headphone. In this case,
the headphone was listed as "line out" by BIOS.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/993162
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 224410e..b896681 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6439,6 +6439,7 @@ enum {
 	ALC662_FIXUP_ASUS_MODE7,
 	ALC662_FIXUP_ASUS_MODE8,
 	ALC662_FIXUP_NO_JACK_DETECT,
+	ALC662_FIXUP_ZOTAC_Z68,
 };
 
 static const struct alc_fixup alc662_fixups[] = {
@@ -6588,6 +6589,13 @@ static const struct alc_fixup alc662_fixups[] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc_fixup_no_jack_detect,
 	},
+	[ALC662_FIXUP_ZOTAC_Z68] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x1b, 0x02214020 }, /* Front HP */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6601,6 +6609,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc051, "Samsung R720", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
+	SND_PCI_QUIRK(0x19da, 0xa130, "Zotac Z68", ALC662_FIXUP_ZOTAC_Z68),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 
 #if 0
-- 
1.7.9.5
