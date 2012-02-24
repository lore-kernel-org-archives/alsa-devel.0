From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/38] ALSA: hda/realtek - Replace ALC260
	model=replacer with the auto-parser
Date: Fri, 24 Feb 2012 17:35:59 +0100
Message-ID: <1330101391-8788-7-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id BE10E1042EF
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5A75190182
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The support for Replacer 627V in the auto-parser needs the unique unsol
event handling: although the machine has a single output pin 0x0f, it's
used for both the headphone and the speaker, and the driver needs to
toggle the output route via GPIO 1.

In addition, it needs a special COEF setup with 0x3050.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   44 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 95ef722..cfa6ad7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4211,8 +4211,35 @@ enum {
 	ALC260_FIXUP_HP_PIN_0F,
 	ALC260_FIXUP_COEF,
 	ALC260_FIXUP_GPIO1,
+	ALC260_FIXUP_GPIO1_TOGGLE,
+	ALC260_FIXUP_REPLACER,
 };
 
+static void alc260_gpio1_automute(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+			    spec->hp_jack_present);
+}
+
+static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
+				      const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == ALC_FIXUP_ACT_PROBE) {
+		/* although the machine has only one output pin, we need to
+		 * toggle GPIO1 according to the jack state
+		 */
+		spec->automute_hook = alc260_gpio1_automute;
+		spec->detect_hp = 1;
+		spec->automute_speaker = 1;
+		spec->autocfg.hp_pins[0] = 0x0f; /* copy it for automute */
+		snd_hda_jack_detect_enable(codec, 0x0f, ALC_HP_EVENT);
+		spec->unsol_event = alc_sku_unsol_event;
+		add_verb(codec->spec, alc_gpio1_init_verbs);
+	}
+}
+
 static const struct alc_fixup alc260_fixups[] = {
 	[ALC260_FIXUP_HP_DC5750] = {
 		.type = ALC_FIXUP_PINS,
@@ -4242,6 +4269,22 @@ static const struct alc_fixup alc260_fixups[] = {
 		.type = ALC_FIXUP_VERBS,
 		.v.verbs = alc_gpio1_init_verbs,
 	},
+	[ALC260_FIXUP_GPIO1_TOGGLE] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc260_fixup_gpio1_toggle,
+		.chained = true,
+		.chain_id = ALC260_FIXUP_HP_PIN_0F,
+	},
+	[ALC260_FIXUP_REPLACER] = {
+		.type = ALC_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x07 },
+			{ 0x20, AC_VERB_SET_PROC_COEF,  0x3050 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC260_FIXUP_GPIO1_TOGGLE,
+	},
 };
 
 static const struct snd_pci_quirk alc260_fixup_tbl[] = {
@@ -4249,6 +4292,7 @@ static const struct snd_pci_quirk alc260_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x007f, "Acer Aspire 9500", ALC260_FIXUP_COEF),
 	SND_PCI_QUIRK(0x1025, 0x008f, "Acer", ALC260_FIXUP_GPIO1),
 	SND_PCI_QUIRK(0x103c, 0x280a, "HP dc5750", ALC260_FIXUP_HP_DC5750),
+	SND_PCI_QUIRK(0x161f, 0x2057, "Replacer 672V", ALC260_FIXUP_REPLACER),
 	SND_PCI_QUIRK(0x1631, 0xc017, "PB V7900", ALC260_FIXUP_COEF),
 	{}
 };
-- 
1.7.9
