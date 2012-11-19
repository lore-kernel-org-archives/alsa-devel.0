From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 2/2] ALSA: hda - Fix Acer Aspire models with
	analog mics.
Date: Sun, 18 Nov 2012 22:56:40 -0800
Message-ID: <1353308200-18944-3-git-send-email-dgreid@chromium.org>
References: <1353308200-18944-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f73.google.com (mail-vb0-f73.google.com
 [209.85.212.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DF0E2650EC
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 07:56:47 +0100 (CET)
Received: by mail-vb0-f73.google.com with SMTP id b13so58222vby.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 22:56:46 -0800 (PST)
In-Reply-To: <1353308200-18944-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The Acer Aspire AO756 has an analog built-in mic on nid 0x1b and an
external mic on nid 0x19.  The BIOS doesn't set this up.

The mic detect on this Acer Aspire netbook and Acer C7 ChromeBook is
only valid when the headphone is plugged.  The detect circuit relies on
the tip detect switch being closed on the jack.  Tell hda_jack to ignore
the mic sense unless the headphones are plugged.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_realtek.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 89737ae..fe99176 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6013,6 +6013,16 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
 	}
 }
 
+static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
+				    const struct alc_fixup *fix,
+				    int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == ALC_FIXUP_ACT_PROBE)
+		snd_hda_jack_set_gating_jack(codec, spec->ext_mic_pin,
+					     spec->autocfg.hp_pins[0]);
+}
 
 enum {
 	ALC269_FIXUP_SONY_VAIO,
@@ -6035,6 +6045,8 @@ enum {
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
+	ALC271_FIXUP_AMIC_MIC2,
+	ALC271_FIXUP_HP_GATE_MIC_JACK,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -6179,6 +6191,22 @@ static const struct alc_fixup alc269_fixups[] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC271_FIXUP_AMIC_MIC2] = {
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x99130110 }, /* speaker */
+			{ 0x19, 0x01a19c20 }, /* mic */
+			{ 0x1b, 0x99a7012f }, /* int-mic */
+			{ 0x21, 0x0121401f }, /* HP out */
+			{ }
+		},
+	},
+	[ALC271_FIXUP_HP_GATE_MIC_JACK] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc271_hp_gate_mic_jack,
+		.chained = true,
+		.chain_id = ALC271_FIXUP_AMIC_MIC2,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6199,6 +6227,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
+	SND_PCI_QUIRK(0x1025, 0x0742, "Acer AO756", ALC271_FIXUP_HP_GATE_MIC_JACK),
 	SND_PCI_QUIRK_VENDOR(0x1025, "Acer Aspire", ALC271_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x10cf, 0x1475, "Lifebook", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
-- 
1.8.0
