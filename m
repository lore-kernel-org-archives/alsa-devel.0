From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add multifunction jack support for
	ALC255
Date: Thu,  7 Nov 2013 14:08:41 +0100
Message-ID: <1383829721-3220-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 031FC2616E1
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 14:08:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1248949@bugs.launchpad.net, kailang@realtek.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Kailang Yang <kailang@realtek.com>

The new codec ALC255 needs its own set of verbs to enable
multifunction jacks.

(Context and whitespace adjustments by David Henningsson)

BugLink: https://bugs.launchpad.net/bugs/1248949
Tested-by: Doro Wu <doro.wu@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   91 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index daf7205..ceadd65 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -588,6 +588,18 @@ static int alc_read_coef_idx(struct hda_codec *codec,
 	return val;
 }
 
+static int alc_read_coefex_idx(struct hda_codec *codec,
+					hda_nid_t nid,
+					unsigned int coef_idx)
+{
+	unsigned int val;
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
+			    coef_idx);
+	val = snd_hda_codec_read(codec, nid, 0,
+				 AC_VERB_GET_PROC_COEF, 0);
+	return val;
+}
+
 static void alc_write_coef_idx(struct hda_codec *codec, unsigned int coef_idx,
 							unsigned int coef_val)
 {
@@ -597,6 +609,15 @@ static void alc_write_coef_idx(struct hda_codec *codec, unsigned int coef_idx,
 			    coef_val);
 }
 
+static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
+				 unsigned int coef_idx, unsigned int coef_val)
+{
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
+			    coef_idx);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF,
+			    coef_val);
+}
+
 /* a special bypass for COEF 0; read the cached value at the second time */
 static unsigned int alc_get_coef0(struct hda_codec *codec)
 {
@@ -3109,6 +3130,14 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	int val;
 
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x1b, 0x0c0b);
+		alc_write_coef_idx(codec, 0x45, 0xd089);
+		val = alc_read_coefex_idx(codec, 0x57, 0x05);
+		alc_write_coefex_idx(codec, 0x57, 0x05, val & ~(1<<14));
+		alc_write_coef_idx(codec, 0x06, 0x6104);
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x1b, 0x0c0b);
 		alc_write_coef_idx(codec, 0x45, 0xc429);
@@ -3140,6 +3169,13 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 	int val;
 
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x45, 0xc489);
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);
+		alc_write_coef_idx(codec, 0x06, 0x6100);
+		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x45, 0xc429);
 		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
@@ -3171,6 +3207,12 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
 static void alc_headset_mode_default(struct hda_codec *codec)
 {
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x45, 0xc089);
+		alc_write_coef_idx(codec, 0x45, 0xc489);
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);
+		alc_write_coef_idx(codec, 0x49, 0x0049);
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x06, 0x2100);
 		alc_write_coef_idx(codec, 0x32, 0x4ea3);
@@ -3194,6 +3236,11 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 static void alc_headset_mode_ctia(struct hda_codec *codec)
 {
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x45, 0xd489);
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x45, 0xd429);
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
@@ -3216,6 +3263,11 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 static void alc_headset_mode_omtp(struct hda_codec *codec)
 {
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x45, 0xe489);
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x45, 0xe429);
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
@@ -3241,6 +3293,13 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 
 	switch (codec->vendor_id) {
+	case 0x10ec0255:
+		alc_write_coef_idx(codec, 0x45, 0xd089);
+		alc_write_coef_idx(codec, 0x49, 0x0149);
+		msleep(300);
+		val = alc_read_coef_idx(codec, 0x46);
+		is_ctia = (val & 0x0070) == 0x0070;
+		break;
 	case 0x10ec0283:
 		alc_write_coef_idx(codec, 0x45, 0xd029);
 		msleep(300);
@@ -3387,6 +3446,20 @@ static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
 		alc_fixup_headset_mode(codec, fix, action);
 }
 
+static void alc_fixup_headset_mode_alc255(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		alc_write_coef_idx(codec, 0x1b, 0x880b);
+		alc_write_coef_idx(codec, 0x45, 0xd089);
+		alc_write_coef_idx(codec, 0x1b, 0x080b);
+		alc_write_coef_idx(codec, 0x46, 0x0004);
+		alc_write_coef_idx(codec, 0x1b, 0x0c0b);
+		msleep(30);
+	}
+	alc_fixup_headset_mode(codec, fix, action);
+}
+
 static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -3686,6 +3759,8 @@ enum {
 	ALC283_FIXUP_INT_MIC,
 	ALC290_FIXUP_MONO_SPEAKERS,
 	ALC269_FIXUP_THINKPAD_ACPI,
+	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC255_FIXUP_HEADSET_MODE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -3995,6 +4070,20 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
 	},
+	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ 0x1a, 0x01a1913d }, /* use as headphone mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_HEADSET_MODE
+	},
+	[ALC255_FIXUP_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode_alc255,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -4037,6 +4126,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0609, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0613, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", ALC290_FIXUP_MONO_SPEAKERS),
+	SND_PCI_QUIRK(0x1028, 0x061f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
1.7.9.5
