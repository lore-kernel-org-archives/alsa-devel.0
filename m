From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Add subwoofer quirks for Asus
	UX51VZH and N55SF
Date: Fri,  7 Feb 2014 09:31:08 +0100
Message-ID: <1391761868-4056-2-git-send-email-david.henningsson@canonical.com>
References: <1391761868-4056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F0CC2652CF
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 09:31:10 +0100 (CET)
In-Reply-To: <1391761868-4056-1-git-send-email-david.henningsson@canonical.com>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Bug reporter report that the -mode4 makes the subwoofer work.
I have simplified the quirk a bit to avoid possible regressions
with the microphones.

BugLink: https://bugs.launchpad.net/bugs/871808
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0295efe..672cc15 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4926,6 +4926,7 @@ enum {
 	ALC668_FIXUP_DELL_MIC_NO_PRESENCE,
 	ALC668_FIXUP_HEADSET_MODE,
 	ALC662_FIXUP_BASS_MODE4_CHMAP,
+	ALC662_FIXUP_BASS_16,
 	ALC662_FIXUP_BASS_1A,
 	ALC662_FIXUP_BASS_CHMAP,
 	ALC668_FIXUP_AUTO_MUTE,
@@ -5121,6 +5122,15 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_ASUS_MODE4
 	},
+	[ALC662_FIXUP_BASS_16] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x16, 0x80106111}, /* bass speaker */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_BASS_CHMAP,
+	},
 	[ALC662_FIXUP_BASS_1A] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5155,6 +5165,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
+	SND_PCI_QUIRK(0x1043, 0x15a7, "ASUS UX51VZH", ALC662_FIXUP_BASS_16),
+	SND_PCI_QUIRK(0x1043, 0x1b73, "ASUS N55SF", ALC662_FIXUP_BASS_16),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
 	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_FIXUP_ASUS_MODE2),
-- 
1.7.9.5
