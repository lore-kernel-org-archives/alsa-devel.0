From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix noise on Gigabyte Z170X mobo
Date: Tue, 24 Nov 2015 20:05:38 +0100
Message-ID: <1448391938-24989-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA0BB2615F7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 20:05:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 910F8AABB
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 19:04:12 +0000 (UTC)
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

Gigabyte Z710X mobo with ALC1150 codec gets significant noises from
the analog loopback routes even if their inputs are all muted.
Simply kill the aamix for fixing it.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=108301
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e4f80dc4704f..9bedf7c85e29 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1759,6 +1759,7 @@ enum {
 	ALC882_FIXUP_NO_PRIMARY_HP,
 	ALC887_FIXUP_ASUS_BASS,
 	ALC887_FIXUP_BASS_CHMAP,
+	ALC882_FIXUP_DISABLE_AAMIX,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -1920,6 +1921,8 @@ static void alc882_fixup_no_primary_hp(struct hda_codec *codec,
 
 static void alc_fixup_bass_chmap(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action);
+static void alc_fixup_disable_aamix(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action);
 
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
@@ -2151,6 +2154,10 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_bass_chmap,
 	},
+	[ALC882_FIXUP_DISABLE_AAMIX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_aamix,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2218,6 +2225,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1458, 0xa182, "Gigabyte Z170X-UD3", ALC882_FIXUP_DISABLE_AAMIX),
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", ALC882_FIXUP_ABIT_AW9D_MAX),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
-- 
2.6.3
