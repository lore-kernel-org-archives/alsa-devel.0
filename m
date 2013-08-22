From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add workarounds for pop-noise
	on Chromebook with ALC283
Date: Thu, 22 Aug 2013 10:21:09 +0200
Message-ID: <1377159669-32767-2-git-send-email-tiwai@suse.de>
References: <1377159669-32767-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 231A2265340
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:19:25 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F1AECA51FE
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:19:22 +0200 (CEST)
In-Reply-To: <1377159669-32767-1-git-send-email-tiwai@suse.de>
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

From: Kailang Yang <kailang@realtek.com>

The headphone automute on this machine triggers annoying pop noises.
It seems that only the first DAC can be used, the secondary DAC always
results in this problem.  This patch disables the secondary DAC with
a few additional workarounds.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4bdccd1..a97dbba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3394,6 +3394,45 @@ static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
 	}
 }
 
+static void alc283_hp_automute_hook(struct hda_codec *codec,
+				    struct hda_jack_tbl *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	int vref;
+
+	msleep(200);
+	snd_hda_gen_hp_automute(codec, jack);
+
+	vref = spec->gen.hp_jack_present ? PIN_VREF80 : 0;
+
+	msleep(600);
+	snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    vref);
+}
+
+static void alc283_chromebook_caps(struct hda_codec *codec)
+{
+	snd_hda_override_wcaps(codec, 0x03, 0);
+}
+
+static void alc283_fixup_chromebook(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	int val;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		alc283_chromebook_caps(codec);
+		spec->gen.hp_automute_hook = alc283_hp_automute_hook;
+		/* MIC2-VREF control */
+		/* Set to manual mode */
+		val = alc_read_coef_idx(codec, 0x06);
+		alc_write_coef_idx(codec, 0x06, val & ~0x000c);
+		break;
+	}
+}
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -3430,6 +3469,7 @@ enum {
 	ALC269_FIXUP_ACER_AC700,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
 	ALC269VB_FIXUP_ORDISSIMO_EVE2,
+	ALC283_FIXUP_CHROME_BOOK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3681,6 +3721,10 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC283_FIXUP_CHROME_BOOK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc283_fixup_chromebook,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -3729,6 +3773,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x21ed, "HP Falco ChromeBook", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
-- 
1.8.3.4
