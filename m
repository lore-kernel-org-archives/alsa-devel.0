From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - add dock support for Thinkpad X230
	Tablet
Date: Fri, 20 Jul 2012 10:37:25 +0200
Message-ID: <1342773445-6660-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7243F26021A
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 10:37:26 +0200 (CEST)
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
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Also add a model/fixup string "lenovo-dock", so that other Thinkpad
users will be able to test this fixup easily, to see if it enables
dock I/O for them as well.

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/1026953
Tested-by: John McCarron <john.mccarron@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    3 ++-
 sound/pci/hda/patch_realtek.c                |   27 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 2ea8cf2..7456360 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -21,13 +21,14 @@ ALC267/268
 ==========
   inv-dmic	Inverted internal mic workaround
 
-ALC269
+ALC269/270/275/276/280/282
 ======
   laptop-amic	Laptops with analog-mic input
   laptop-dmic	Laptops with digital-mic input
   alc269-dmic	Enable ALC269(VA) digital mic workaround
   alc271-dmic	Enable ALC271X digital mic workaround
   inv-dmic	Inverted internal mic workaround
+  lenovo-dock   Enables docking station I/O for some Lenovos
 
 ALC662/663/272
 ==============
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 537c365..f141395 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5881,6 +5881,15 @@ static int alc269_resume(struct hda_codec *codec)
 }
 #endif /* CONFIG_PM */
 
+static void alc269_fixup_pincfg_no_hp_to_lineout(struct hda_codec *codec,
+						 const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == ALC_FIXUP_ACT_PRE_PROBE)
+		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
+}
+
 static void alc269_fixup_hweq(struct hda_codec *codec,
 			       const struct alc_fixup *fix, int action)
 {
@@ -6007,6 +6016,8 @@ enum {
 	ALC269VB_FIXUP_DMIC,
 	ALC269_FIXUP_MIC2_MUTE_LED,
 	ALC269_FIXUP_INV_DMIC,
+	ALC269_FIXUP_LENOVO_DOCK,
+	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -6135,6 +6146,20 @@ static const struct alc_fixup alc269_fixups[] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC269_FIXUP_LENOVO_DOCK] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x19, 0x23a11040 }, /* dock mic */
+			{ 0x1b, 0x2121103f }, /* dock headphone */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT
+	},
+	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6161,6 +6186,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21ca, "Thinkpad L412", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21e9, "Thinkpad Edge 15", ALC269_FIXUP_SKU_IGNORE),
+	SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet", ALC269_FIXUP_LENOVO_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_QUANTA_MUTE),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Lenovo Ideapd", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
@@ -6222,6 +6248,7 @@ static const struct alc_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_STEREO_DMIC, .name = "alc269-dmic"},
 	{.id = ALC271_FIXUP_DMIC, .name = "alc271-dmic"},
 	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
 	{}
 };
 
-- 
1.7.9.5
