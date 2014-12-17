From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add quirk for Packard Bell
	EasyNote MX65
Date: Wed, 17 Dec 2014 18:04:11 +0100
Message-ID: <1418835851-11068-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C6C1126068E
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 18:04:12 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9B4B9ABCA
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 17:04:12 +0000 (UTC)
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

Packard Bell EasyNote MX65 with AD1986A codec needs a few fixups,
namely, the pin config overrides to set only the known I/O pins and
the EAPD has to be turned on.  In addition, add stereo mix input
forcibly for avoiding the weird KDE behavior by this update.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=88251
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index eb54da757407..a9d78e275138 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -257,6 +257,18 @@ static void ad1986a_fixup_eapd(struct hda_codec *codec,
 	}
 }
 
+/* enable stereo-mix input for avoiding regression on KDE (bko#88251) */
+static void ad1986a_fixup_eapd_mix_in(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		ad1986a_fixup_eapd(codec, fix, action);
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_ENABLE;
+	}
+}
+
 enum {
 	AD1986A_FIXUP_INV_JACK_DETECT,
 	AD1986A_FIXUP_ULTRA,
@@ -265,6 +277,8 @@ enum {
 	AD1986A_FIXUP_LAPTOP,
 	AD1986A_FIXUP_LAPTOP_IMIC,
 	AD1986A_FIXUP_EAPD,
+	AD1986A_FIXUP_EAPD_MIX_IN,
+	AD1986A_FIXUP_EASYNOTE,
 };
 
 static const struct hda_fixup ad1986a_fixups[] = {
@@ -329,6 +343,30 @@ static const struct hda_fixup ad1986a_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = ad1986a_fixup_eapd,
 	},
+	[AD1986A_FIXUP_EAPD_MIX_IN] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = ad1986a_fixup_eapd_mix_in,
+	},
+	[AD1986A_FIXUP_EASYNOTE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x0421402f }, /* headphone */
+			{ 0x1b, 0x90170110 }, /* speaker */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x90a70130 }, /* int mic */
+			{ 0x1e, 0x411111f0 }, /* N/A */
+			{ 0x1f, 0x04a19040 }, /* mic */
+			{ 0x20, 0x411111f0 }, /* N/A */
+			{ 0x21, 0x411111f0 }, /* N/A */
+			{ 0x22, 0x411111f0 }, /* N/A */
+			{ 0x23, 0x411111f0 }, /* N/A */
+			{ 0x24, 0x411111f0 }, /* N/A */
+			{ 0x25, 0x411111f0 }, /* N/A */
+			{}
+		},
+		.chained = true,
+		.chain_id = AD1986A_FIXUP_EAPD_MIX_IN,
+	},
 };
 
 static const struct snd_pci_quirk ad1986a_fixup_tbl[] = {
@@ -342,6 +380,7 @@ static const struct snd_pci_quirk ad1986a_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc01e, "FSC V2060", AD1986A_FIXUP_LAPTOP),
 	SND_PCI_QUIRK_MASK(0x144d, 0xff00, 0xc000, "Samsung", AD1986A_FIXUP_SAMSUNG),
 	SND_PCI_QUIRK(0x144d, 0xc027, "Samsung Q1", AD1986A_FIXUP_ULTRA),
+	SND_PCI_QUIRK(0x1631, 0xc022, "PackardBell EasyNote MX65", AD1986A_FIXUP_EASYNOTE),
 	SND_PCI_QUIRK(0x17aa, 0x2066, "Lenovo N100", AD1986A_FIXUP_INV_JACK_DETECT),
 	SND_PCI_QUIRK(0x17aa, 0x1011, "Lenovo M55", AD1986A_FIXUP_3STACK),
 	SND_PCI_QUIRK(0x17aa, 0x1017, "Lenovo A60", AD1986A_FIXUP_3STACK),
-- 
2.2.0
