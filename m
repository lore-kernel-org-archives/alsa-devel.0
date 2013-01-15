From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/20] ALSA: hda/realtek - Add a fixup for FSC
	S7020 laptop
Date: Tue, 15 Jan 2013 12:05:42 +0100
Message-ID: <1358247947-13992-16-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D802326532C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A4F06A5233
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Try to recover from the regression: set the HP amp for the speaker and
add the hp jack mode enum as default.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c8fcfa8..42fc05c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1436,6 +1436,7 @@ enum {
 	ALC260_FIXUP_REPLACER,
 	ALC260_FIXUP_HP_B1900,
 	ALC260_FIXUP_KN1,
+	ALC260_FIXUP_FSC_S7020,
 };
 
 static void alc260_gpio1_automute(struct hda_codec *codec)
@@ -1493,6 +1494,17 @@ static void alc260_fixup_kn1(struct hda_codec *codec,
 	}
 }
 
+static void alc260_fixup_fsc_s7020(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->gen.add_out_jack_modes = 1;
+	else if (action == HDA_FIXUP_ACT_PROBE)
+		snd_hda_set_pin_ctl_cache(codec, 0x10, PIN_HP);
+}
+
 static const struct hda_fixup alc260_fixups[] = {
 	[ALC260_FIXUP_HP_DC5750] = {
 		.type = HDA_FIXUP_PINS,
@@ -1548,6 +1560,10 @@ static const struct hda_fixup alc260_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc260_fixup_kn1,
 	},
+	[ALC260_FIXUP_FSC_S7020] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc260_fixup_fsc_s7020,
+	},
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
@@ -1556,6 +1572,7 @@ static const struct snd_pci_quirk alc260_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
 	SND_PCI_QUIRK(0x103c, 0x30ba, "HP Presario B1900", ALC260_FIXUP_HP_B1900),
+	SND_PCI_QUIRK(0x10cf, 0x1326, "FSC LifeBook S7020", ALC260_FIXUP_FSC_S7020),
 	SND_PCI_QUIRK(0x1509, 0x4540, "Favorit 100XS", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x152d, 0x0729, "Quanta KN1", ALC260_FIXUP_KN1),
 	SND_PCI_QUIRK(0x161f, 0x2057, "Replacer 672V", ALC260_FIXUP_REPLACER),
-- 
1.8.1
