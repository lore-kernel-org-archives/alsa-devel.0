From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing bass speaker on ASUS
	N550
Date: Thu, 21 Nov 2013 08:03:43 +0100
Message-ID: <1385017423-10829-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D0F11260816
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 08:03:46 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5E8EDA79B4
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 08:03:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The laptop has a built-in speaker on NID 0x1a.  It's an LFE only on
the right channel, so we need to provide an explicit chmap, too.

There might be other surround speakers, but they can fixed in addition
at later point, so let's fix the easier bass speaker at first.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=65091
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a90bfab8530f..cc1dfdc1ff74 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4723,6 +4723,8 @@ enum {
 	ALC668_FIXUP_DELL_MIC_NO_PRESENCE,
 	ALC668_FIXUP_HEADSET_MODE,
 	ALC662_FIXUP_BASS_CHMAP,
+	ALC662_FIXUP_BASS_1A,
+	ALC662_FIXUP_BASS_1A_CHMAP,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -4903,6 +4905,19 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_ASUS_MODE4
 	},
+	[ALC662_FIXUP_BASS_1A] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x1a, 0x80106111}, /* bass speaker */
+			{}
+		},
+	},
+	[ALC662_FIXUP_BASS_1A_CHMAP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc662_fixup_bass_chmap,
+		.chained = true,
+		.chain_id = ALC662_FIXUP_BASS_1A,
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -4918,6 +4933,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0625, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0626, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
+	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x1bf3, "ASUS N76VZ", ALC662_FIXUP_BASS_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
-- 
1.8.4.3
