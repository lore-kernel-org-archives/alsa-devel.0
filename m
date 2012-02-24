From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/38] ALSA: hda/realtek - Rewrite ALC880
	model=futjisu with auto-parser
Date: Fri, 24 Feb 2012 17:36:15 +0100
Message-ID: <1330101391-8788-23-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 59A0010431E
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8CC0C91EDB
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

Now adding the support for the volume-knob widget, we can move the static
quirk for ALC880 model=fujitsu to the auto-parser completely.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   76 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 895113e..6a6436a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -651,15 +651,51 @@ static void alc_exec_unsol_event(struct hda_codec *codec, int action)
 	snd_hda_jack_report_sync(codec);
 }
 
+/* update the master volume per volume-knob's unsol event */
+static void alc_update_knob_master(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int val;
+	struct snd_kcontrol *kctl;
+	struct snd_ctl_elem_value *uctl;
+
+	kctl = snd_hda_find_mixer_ctl(codec, "Master Playback Volume");
+	if (!kctl)
+		return;
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return;
+	val = snd_hda_codec_read(codec, nid, 0,
+				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
+	val &= HDA_AMP_VOLMASK;
+	uctl->value.integer.value[0] = val;
+	uctl->value.integer.value[1] = val;
+	kctl->put(kctl, uctl);
+	kfree(uctl);
+}
+
 /* unsolicited event for HP jack sensing */
 static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
 {
+	int action;
+
 	if (codec->vendor_id == 0x10ec0880)
 		res >>= 28;
 	else
 		res >>= 26;
-	res = snd_hda_jack_get_action(codec, res);
-	alc_exec_unsol_event(codec, res);
+	action = snd_hda_jack_get_action(codec, res);
+	if (res == ALC_DCVOL_EVENT) {
+		/* Execute the dc-vol event here as it requires the NID
+		 * but we don't pass NID to alc_exec_unsol_event().
+		 * Once when we convert all static quirks to the auto-parser,
+		 * this can be integerated into there.
+		 */
+		struct hda_jack_tbl *jack;
+		jack = snd_hda_jack_tbl_get_from_tag(codec, res);
+		if (jack)
+			alc_update_knob_master(codec, jack->nid);
+		return;
+	}
+	alc_exec_unsol_event(codec, action);
 }
 
 /* call init functions of standard auto-mute helpers */
@@ -4408,8 +4444,18 @@ enum {
 	ALC880_FIXUP_W810,
 	ALC880_FIXUP_EAPD_COEF,
 	ALC880_FIXUP_TCL_S700,
+	ALC880_FIXUP_VOL_KNOB,
+	ALC880_FIXUP_FUJITSU,
 };
 
+/* enable the volume-knob widget support on NID 0x21 */
+static void alc880_fixup_vol_knob(struct hda_codec *codec,
+				  const struct alc_fixup *fix, int action)
+{
+	if (action == ALC_FIXUP_ACT_PROBE)
+		snd_hda_jack_detect_enable(codec, 0x21, ALC_DCVOL_EVENT);
+}
+
 static const struct alc_fixup alc880_fixups[] = {
 	[ALC880_FIXUP_GPIO2] = {
 		.type = ALC_FIXUP_VERBS,
@@ -4465,6 +4511,30 @@ static const struct alc_fixup alc880_fixups[] = {
 		.chained = true,
 		.chain_id = ALC880_FIXUP_GPIO2,
 	},
+	[ALC880_FIXUP_VOL_KNOB] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc880_fixup_vol_knob,
+	},
+	[ALC880_FIXUP_FUJITSU] = {
+		/* override all pins as BIOS on old Amilo is broken */
+		.type = ALC_FIXUP_PINS,
+		.v.pins = (const struct alc_pincfg[]) {
+			{ 0x14, 0x0121411f }, /* HP */
+			{ 0x15, 0x99030120 }, /* speaker */
+			{ 0x16, 0x99030130 }, /* bass speaker */
+			{ 0x17, 0x411111f0 }, /* N/A */
+			{ 0x18, 0x411111f0 }, /* N/A */
+			{ 0x19, 0x01a19950 }, /* mic-in */
+			{ 0x1a, 0x411111f0 }, /* N/A */
+			{ 0x1b, 0x411111f0 }, /* N/A */
+			{ 0x1c, 0x411111f0 }, /* N/A */
+			{ 0x1d, 0x411111f0 }, /* N/A */
+			{ 0x1e, 0x01454140 }, /* SPDIF out */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC880_FIXUP_VOL_KNOB,
+	},
 };
 
 static const struct snd_pci_quirk alc880_fixup_tbl[] = {
@@ -4472,6 +4542,8 @@ static const struct snd_pci_quirk alc880_fixup_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo", ALC880_FIXUP_EAPD_COEF),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_FIXUP_W810),
 	SND_PCI_QUIRK(0x161f, 0x205d, "Medion Rim 2150", ALC880_FIXUP_MEDION_RIM),
+	SND_PCI_QUIRK(0x1734, 0x1094, "FSC Amilo M1451G", ALC880_FIXUP_FUJITSU),
+	SND_PCI_QUIRK(0x1734, 0x10b0, "FSC Amilo Pi1556", ALC880_FIXUP_FUJITSU),
 	SND_PCI_QUIRK(0x1854, 0x003b, "LG", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x005f, "LG P1 Express", ALC880_FIXUP_LG),
 	SND_PCI_QUIRK(0x1854, 0x0068, "LG w1", ALC880_FIXUP_LG),
-- 
1.7.9
