From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix pin config and mapping on
	Alienware 15
Date: Mon, 10 Aug 2015 17:00:11 +0200
Message-ID: <1439218811-829-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F291265993
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 17:00:12 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1E225AD2F
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 15:00:11 +0000 (UTC)
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

Alienware 15 has CA0132 codec for its onboard sound, but the pin
config and mapping seem quite different from other Creative boards.
This patch corrects them, at least, for providing the right headphone
and mic jack notification, as well as removing the non-existing SPDIF
pins.

Even with this fix, not all stuff works perfectly yet, mainly because
of the badly written ca0132 driver code -- it has too many implicit
assumptions of pin configs and maps.  Nevertheless, this is a small
good step forward.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=101981
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 87 ++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0f039abe9673..186792fe226e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -763,6 +763,20 @@ enum {
 	QUIRK_ALIENWARE,
 };
 
+static const struct hda_pintbl alienware_pincfgs[] = {
+	{ 0x0b, 0x90170110 }, /* Builtin Speaker */
+	{ 0x0c, 0x411111f0 }, /* N/A */
+	{ 0x0d, 0x411111f0 }, /* N/A */
+	{ 0x0e, 0x411111f0 }, /* N/A */
+	{ 0x0f, 0x0321101f }, /* HP */
+	{ 0x10, 0x411111f0 }, /* Headset?  disabled for now */
+	{ 0x11, 0x03a11021 }, /* Mic */
+	{ 0x12, 0xd5a30140 }, /* Builtin Mic */
+	{ 0x13, 0x411111f0 }, /* N/A */
+	{ 0x18, 0x411111f0 }, /* N/A */
+	{}
+};
+
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
 	{}
@@ -3147,7 +3161,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
 
 	if (auto_jack)
-		jack_present = snd_hda_jack_detect(codec, spec->out_pins[1]);
+		jack_present = snd_hda_jack_detect(codec, spec->unsol_tag_hp);
 	else
 		jack_present =
 			spec->vnode_lswitch[VNID_HP_SEL - VNODE_START_NID];
@@ -3309,7 +3323,7 @@ static int ca0132_select_mic(struct hda_codec *codec)
 	auto_jack = spec->vnode_lswitch[VNID_AMIC1_ASEL - VNODE_START_NID];
 
 	if (auto_jack)
-		jack_present = snd_hda_jack_detect(codec, spec->input_pins[0]);
+		jack_present = snd_hda_jack_detect(codec, spec->unsol_tag_amic1);
 	else
 		jack_present =
 			spec->vnode_lswitch[VNID_AMIC1_SEL - VNODE_START_NID];
@@ -4617,37 +4631,54 @@ static void ca0132_config(struct hda_codec *codec)
 	spec->multiout.num_dacs = 3;
 	spec->multiout.max_channels = 2;
 
-	spec->num_outputs = 2;
-	spec->out_pins[0] = 0x0b; /* speaker out */
 	if (spec->quirk == QUIRK_ALIENWARE) {
 		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
+		snd_hda_apply_pincfgs(codec, alienware_pincfgs);
+
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0b; /* speaker out */
 		spec->out_pins[1] = 0x0f;
-	} else{
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = 0x0f;
+
+		spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
+		spec->adcs[1] = 0x8; /* analog mic2 */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 3;
+		spec->input_pins[0] = 0x12;
+		spec->input_pins[1] = 0x11;
+		spec->input_pins[2] = 0x13;
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = 0x11;
+	} else {
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0b; /* speaker out */
 		spec->out_pins[1] = 0x10; /* headphone out */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+
+		spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
+		spec->adcs[1] = 0x8; /* analog mic2 */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 3;
+		spec->input_pins[0] = 0x12;
+		spec->input_pins[1] = 0x11;
+		spec->input_pins[2] = 0x13;
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+
+		/* SPDIF I/O */
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+		cfg->dig_out_pins[0] = 0x0c;
+		cfg->dig_outs = 1;
+		cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
+		spec->dig_in = 0x09;
+		cfg->dig_in_pin = 0x0e;
+		cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 	}
-	spec->shared_out_nid = 0x2;
-	spec->unsol_tag_hp = spec->out_pins[1];
-
-	spec->adcs[0] = 0x7; /* digital mic / analog mic1 */
-	spec->adcs[1] = 0x8; /* analog mic2 */
-	spec->adcs[2] = 0xa; /* what u hear */
-
-	spec->num_inputs = 3;
-	spec->input_pins[0] = 0x12;
-	spec->input_pins[1] = 0x11;
-	spec->input_pins[2] = 0x13;
-	spec->shared_mic_nid = 0x7;
-	spec->unsol_tag_amic1 = spec->input_pins[0];
-
-	/* SPDIF I/O */
-	spec->dig_out = 0x05;
-	spec->multiout.dig_out_nid = spec->dig_out;
-	cfg->dig_out_pins[0] = 0x0c;
-	cfg->dig_outs = 1;
-	cfg->dig_out_type[0] = HDA_PCM_TYPE_SPDIF;
-	spec->dig_in = 0x09;
-	cfg->dig_in_pin = 0x0e;
-	cfg->dig_in_type = HDA_PCM_TYPE_SPDIF;
 }
 
 static int ca0132_prepare_verbs(struct hda_codec *codec)
-- 
2.5.0
