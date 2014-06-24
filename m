From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Adjust speaker HPF and add LED
	support for HP Spectre 13
Date: Tue, 24 Jun 2014 17:12:39 +0200
Message-ID: <1403622759-10170-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2CEB2656F3
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 17:12:39 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2D042AC69
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 15:12:39 +0000 (UTC)
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

HP Spectre 13 has the IDT 92HD95 codec, and BIOS seems to set the
default high-pass filter in some "safer" range, which results in the
very soft tone from the built-in speakers in contrast to Windows.
Also, the mute LED control is missing, since 92HD95 codec still has no
HP-specific fixups for GPIO setups.

This patch adds these missing features: the HPF is adjusted by the
vendor-specific verb, and the LED is set up from a DMI string (but
with the default polarity = 0 assumption due to the incomplete BIOS on
the given machine).

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=74841
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |  5 +++
 sound/pci/hda/patch_sigmatel.c               | 58 +++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 85c362d8ea34..d1ab5e17eb13 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -286,6 +286,11 @@ STAC92HD83*
   hp-inv-led	HP with broken BIOS for inverted mute LED
   auto		BIOS setup (default)
 
+STAC92HD95
+==========
+  hp-led	LED support for HP laptops
+  hp-bass	Bass HPF setup for HP Spectre 13
+
 STAC9872
 ========
   vaio		VAIO laptop without SPDIF
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 7f40a150899c..3744ea4e843d 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -122,6 +122,12 @@ enum {
 };
 
 enum {
+	STAC_92HD95_HP_LED,
+	STAC_92HD95_HP_BASS,
+	STAC_92HD95_MODELS
+};
+
+enum {
 	STAC_925x_REF,
 	STAC_M1,
 	STAC_M1_2,
@@ -4128,6 +4134,48 @@ static const struct snd_pci_quirk stac9205_fixup_tbl[] = {
 	{} /* terminator */
 };
 
+static void stac92hd95_fixup_hp_led(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	if (find_mute_led_cfg(codec, spec->default_polarity))
+		codec_dbg(codec, "mute LED gpio %d polarity %d\n",
+				spec->gpio_led,
+				spec->gpio_led_polarity);
+}
+
+static const struct hda_fixup stac92hd95_fixups[] = {
+	[STAC_92HD95_HP_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd95_fixup_hp_led,
+	},
+	[STAC_92HD95_HP_BASS] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{0x1a, 0x795, 0x00}, /* HPF to 100Hz */
+			{}
+		},
+		.chained = true,
+		.chain_id = STAC_92HD95_HP_LED,
+	},
+};
+
+static const struct snd_pci_quirk stac92hd95_fixup_tbl[] = {
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1911, "HP Spectre 13", STAC_92HD95_HP_BASS),
+	{} /* terminator */
+};
+
+static const struct hda_model_fixup stac92hd95_models[] = {
+	{ .id = STAC_92HD95_HP_LED, .name = "hp-led" },
+	{ .id = STAC_92HD95_HP_BASS, .name = "hp-bass" },
+	{}
+};
+
+
 static int stac_parse_auto_config(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -4580,10 +4628,16 @@ static int patch_stac92hd95(struct hda_codec *codec)
 	spec->gen.beep_nid = 0x19; /* digital beep */
 	spec->pwr_nids = stac92hd95_pwr_nids;
 	spec->num_pwrs = ARRAY_SIZE(stac92hd95_pwr_nids);
-	spec->default_polarity = -1; /* no default cfg */
+	spec->default_polarity = 0;
 
 	codec->patch_ops = stac_patch_ops;
 
+	snd_hda_pick_fixup(codec, stac92hd95_models, stac92hd95_fixup_tbl,
+			   stac92hd95_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
+	stac_setup_gpio(codec);
+
 	err = stac_parse_auto_config(codec);
 	if (err < 0) {
 		stac_free(codec);
@@ -4592,6 +4646,8 @@ static int patch_stac92hd95(struct hda_codec *codec)
 
 	codec->proc_widget_hook = stac92hd_proc_hook;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
2.0.0
