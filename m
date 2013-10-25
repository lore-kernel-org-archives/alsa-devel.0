From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix silent headphone on Thinkpads
	with AD1984A codec
Date: Sat, 26 Oct 2013 00:32:15 +0200
Message-ID: <1382740335-20519-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C001E261703
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 00:29:22 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B956A57B7
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 00:29:22 +0200 (CEST)
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

AD1984A codec has a couple of pins with EAPD controls, and the generic
codec driver tries to turn each of them on/off depending on the pin
active state.  However, Thinkpads seem to use EAPD of the speaker pin
as a master EAPD for controlling the mute of all outputs, including
the headphone.  This results in the dead headphone output via the
headphone plugging because it mutes the speaker and turns off EAPD.

The fix is to simply add spec->gen.keep_on_eapd flag.

[This is a regression fix on 3.12 where we moved the AD codec parser
 to the generic parser.  3.11 and earlier didn't show this problem
 because still static quirks have been used.]

Reported-and-tested-by: Vito Caputo <vcaputo@gnugeneration.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 0cbdd87..2aa2f57 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -968,6 +968,15 @@ static void ad1884_fixup_hp_eapd(struct hda_codec *codec,
 	}
 }
 
+static void ad1884_fixup_thinkpad(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->gen.keep_eapd_on = 1;
+}
+
 /* set magic COEFs for dmic */
 static const struct hda_verb ad1884_dmic_init_verbs[] = {
 	{0x01, AC_VERB_SET_COEF_INDEX, 0x13f7},
@@ -979,6 +988,7 @@ enum {
 	AD1884_FIXUP_AMP_OVERRIDE,
 	AD1884_FIXUP_HP_EAPD,
 	AD1884_FIXUP_DMIC_COEF,
+	AD1884_FIXUP_THINKPAD,
 	AD1884_FIXUP_HP_TOUCHSMART,
 };
 
@@ -997,6 +1007,12 @@ static const struct hda_fixup ad1884_fixups[] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = ad1884_dmic_init_verbs,
 	},
+	[AD1884_FIXUP_THINKPAD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = ad1884_fixup_thinkpad,
+		.chained = true,
+		.chain_id = AD1884_FIXUP_DMIC_COEF,
+	},
 	[AD1884_FIXUP_HP_TOUCHSMART] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = ad1884_dmic_init_verbs,
@@ -1008,7 +1024,7 @@ static const struct hda_fixup ad1884_fixups[] = {
 static const struct snd_pci_quirk ad1884_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2a82, "HP Touchsmart", AD1884_FIXUP_HP_TOUCHSMART),
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", AD1884_FIXUP_HP_EAPD),
-	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo Thinkpad", AD1884_FIXUP_DMIC_COEF),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo Thinkpad", AD1884_FIXUP_THINKPAD),
 	{}
 };
 
-- 
1.8.4
