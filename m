From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/11] ALSA: hda/conexant - Apply the amp cap
	override for CX20549 mixer
Date: Tue, 28 Jan 2014 11:06:34 +0100
Message-ID: <1390903600-22772-6-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 279C22651C7
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06F43AC83
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

Apply the amp cap override for CX20549 mixer widget in case where the
generic parser is used, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 74b829b73c35..a595746225cb 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2872,6 +2872,7 @@ enum {
 	CXT_FIXUP_GPIO1,
 	CXT_FIXUP_THINKPAD_ACPI,
 	CXT_FIXUP_OLPC_XO,
+	CXT_FIXUP_CAP_MIX_AMP,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -3204,6 +3205,19 @@ static void cxt_fixup_olpc_xo(struct hda_codec *codec,
 	}
 }
 
+/*
+ * Fix max input level on mixer widget to 0dB
+ * (originally it has 0x2b steps with 0dB offset 0x14)
+ */
+static void cxt_fixup_cap_mix_amp(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	snd_hda_override_amp_caps(codec, 0x17, HDA_INPUT,
+				  (0x14 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x14 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x05 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (1 << AC_AMPCAP_MUTE_SHIFT));
+}
 
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
@@ -3293,6 +3307,26 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_olpc_xo,
 	},
+	[CXT_FIXUP_CAP_MIX_AMP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_cap_mix_amp,
+	},
+};
+
+static const struct snd_pci_quirk cxt5045_fixups[] = {
+	/* HP, Packard Bell, Fujitsu-Siemens & Lenovo laptops have
+	 * really bad sound over 0dB on NID 0x17.
+	 */
+	SND_PCI_QUIRK_VENDOR(0x103c, "HP", CXT_FIXUP_CAP_MIX_AMP),
+	SND_PCI_QUIRK_VENDOR(0x1631, "Packard Bell", CXT_FIXUP_CAP_MIX_AMP),
+	SND_PCI_QUIRK_VENDOR(0x1734, "Fujitsu", CXT_FIXUP_CAP_MIX_AMP),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo", CXT_FIXUP_CAP_MIX_AMP),
+	{}
+};
+
+static const struct hda_model_fixup cxt5045_fixup_models[] = {
+	{ .id = CXT_FIXUP_CAP_MIX_AMP, .name = "cap-mix-amp" },
+	{}
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
@@ -3376,6 +3410,8 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	switch (codec->vendor_id) {
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
+		snd_hda_pick_fixup(codec, cxt5045_fixup_models,
+				   cxt5045_fixups, cxt_fixups);
 		break;
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
-- 
1.8.5.2
