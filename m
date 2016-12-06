From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Gate the mic jack on HP Z1 Gen3 AiO
Date: Tue,  6 Dec 2016 12:30:13 +0100
Message-ID: <20161206113013.21828-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CFE22667F9
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 12:30:16 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 080EDAAB7
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 11:30:14 +0000 (UTC)
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

HP Z1 Gen3 AiO with Conexant codec doesn't give an unsolicited event
to the headset mic pin upon the jack plugging, it reports only to the
headphone pin.  It results in the missing mic switching.  Let's fix up
by simply gating the jack event.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ed62748a6d55..c15c51bea26d 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -262,6 +262,7 @@ enum {
 	CXT_FIXUP_CAP_MIX_AMP_5047,
 	CXT_FIXUP_MUTE_LED_EAPD,
 	CXT_FIXUP_HP_SPECTRE,
+	CXT_FIXUP_HP_GATE_MIC,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -633,6 +634,17 @@ static void cxt_fixup_cap_mix_amp_5047(struct hda_codec *codec,
 				  (1 << AC_AMPCAP_MUTE_SHIFT));
 }
 
+static void cxt_fixup_hp_gate_mic_jack(struct hda_codec *codec,
+				       const struct hda_fixup *fix,
+				       int action)
+{
+	/* the mic pin (0x19) doesn't give an unsolicited event;
+	 * probe the mic pin together with the headphone pin (0x16)
+	 */
+	if (action == HDA_FIXUP_ACT_PROBE)
+		snd_hda_jack_set_gating_jack(codec, 0x19, 0x16);
+}
+
 /* ThinkPad X200 & co with cxt5051 */
 static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
@@ -774,6 +786,10 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ }
 		}
 	},
+	[CXT_FIXUP_HP_GATE_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_hp_gate_mic_jack,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -824,6 +840,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
+	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
-- 
2.11.0
