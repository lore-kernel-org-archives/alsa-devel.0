From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] ALSA: hda - Pop noises fix for XPS13 9333
Date: Mon, 26 May 2014 17:11:46 +0200
Message-ID: <2583453.CzVdMf61zs@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E73A265056
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 17:11:50 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id bs8so151630wib.6
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 08:11:50 -0700 (PDT)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

When headphones are plugged in, force AFG and node 0x02
("Headphone Playback Volume") to D0 to avoid pop noises.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ce28dc4..b7a435c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3726,6 +3726,29 @@ static void alc_fixup_disable_aamix(struct hda_codec *codec,
 	}
 }
 
+static unsigned int alc_power_filter_xps13(struct hda_codec *codec,
+				hda_nid_t nid,
+				unsigned int power_state)
+{
+	struct alc_spec *spec = codec->spec;
+
+	/* Avoid pop noises when headphones are plugged in */
+	if (spec->gen.hp_jack_present)
+		if (nid == codec->afg || nid == 0x02)
+			return AC_PWRST_D0;
+	return power_state;
+}
+
+static void alc_fixup_dell_xps13(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		struct alc_spec *spec = codec->spec;
+		spec->shutup = alc_no_shutup;
+		codec->power_filter = alc_power_filter_xps13;
+	}
+}
+
 static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -5068,6 +5091,7 @@ enum {
 	ALC662_FIXUP_BASS_1A_CHMAP,
 	ALC668_FIXUP_AUTO_MUTE,
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
+	ALC668_FIXUP_DELL_XPS13,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -5228,6 +5252,12 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC668_FIXUP_DELL_XPS13] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_dell_xps13,
+		.chained = true,
+		.chain_id = ALC668_FIXUP_DELL_DISABLE_AAMIX
+	},
 	[ALC668_FIXUP_DELL_DISABLE_AAMIX] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_disable_aamix,
@@ -5285,7 +5315,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x060a, "Dell XPS 13", ALC668_FIXUP_DELL_DISABLE_AAMIX),
+	SND_PCI_QUIRK(0x1028, 0x060a, "Dell XPS 13", ALC668_FIXUP_DELL_XPS13),
 	SND_PCI_QUIRK(0x1028, 0x0623, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0624, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0625, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-- 
2.0.0.rc4
