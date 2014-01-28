From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/11] ALSA: hda/conexant - Apply cap of mix
	amp volume on CX20551 codec
Date: Tue, 28 Jan 2014 11:06:37 +0100
Message-ID: <1390903600-22772-9-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 282B12651CF
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0B283AC85
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

For the generic parser, use the standard fixup matching.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index afb76fe75dbb..e4b98d6d1fe8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2833,6 +2833,7 @@ enum {
 	CXT_FIXUP_CAP_MIX_AMP,
 	CXT_FIXUP_TOSHIBA_P105,
 	CXT_FIXUP_HP_530,
+	CXT_FIXUP_CAP_MIX_AMP_5047,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -3179,6 +3180,20 @@ static void cxt_fixup_cap_mix_amp(struct hda_codec *codec,
 				  (1 << AC_AMPCAP_MUTE_SHIFT));
 }
 
+/*
+ * Fix max input level on mixer widget to 0dB
+ * (originally it has 0x1e steps with 0 dB offset 0x17)
+ */
+static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	snd_hda_override_amp_caps(codec, 0x10, HDA_INPUT,
+				  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (1 << AC_AMPCAP_MUTE_SHIFT));
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -3289,6 +3304,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_CAP_MIX_AMP,
 	},
+	[CXT_FIXUP_CAP_MIX_AMP_5047] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_cap_mix_amp_5047,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -3311,6 +3330,18 @@ static const struct hda_model_fixup cxt5045_fixup_models[] = {
 	{}
 };
 
+static const struct snd_pci_quirk cxt5047_fixups[] = {
+	/* HP laptops have really bad sound over 0 dB on NID 0x10.
+	 */
+	SND_PCI_QUIRK_VENDOR(0x103c, "HP", CXT_FIXUP_CAP_MIX_AMP_5047),
+	{}
+};
+
+static const struct hda_model_fixup cxt5047_fixup_models[] = {
+	{ .id = CXT_FIXUP_CAP_MIX_AMP_5047, .name = "cap-mix-amp" },
+	{}
+};
+
 static const struct snd_pci_quirk cxt5051_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT_PINCFG_LENOVO_X200),
 	{}
@@ -3398,6 +3429,8 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
 		spec->gen.mixer_nid = 0x19;
+		snd_hda_pick_fixup(codec, cxt5047_fixup_models,
+				   cxt5047_fixups, cxt_fixups);
 		break;
 	case 0x14f15051:
 		add_cx5051_fake_mutes(codec);
-- 
1.8.5.2
