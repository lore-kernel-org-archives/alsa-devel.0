From: Tomas Espeleta <tomas.espeleta@gmail.com>
Subject: [PATCH] make huawei matebook X right speaker work
Date: Mon, 14 Jan 2019 21:03:53 +0100
Message-ID: <20190114200353.4114-1-tomas.espeleta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B226266AD7
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 21:04:18 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id q18so310195wrx.9
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 12:04:18 -0800 (PST)
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
Cc: Kailang <kailang@realtek.com>, Tomas Espeleta <tomas.espeleta@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hard coded coefficients to make Huawuei Matebook X right speaker
work. The Matebook X has a ALC298, please refer to bug 197801 on
how these numbers were reverse engineered from the Windows driver

The reversed engineered sequence represents a repeating pattern
of verbs, and the only values that are changing periodically are
written on indexes 0x23 and 0x25:

0x500, 0x23
0x400, VALUE1
0x500, 0x25
0x400, VALUE2

* fixes bug 197801
* skipped reading sequences (0x500 - 0xc00 sequences are ignored)
* static values from reverse engineering are used

Signed-off-by: Tomas Espeleta <tomas.espeleta@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 70 +++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0b3e7a18ca78..ec3972d9e30d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3628,6 +3628,64 @@ static void alc269_x101_hp_automute_hook(struct hda_codec *codec,
 			    vref);
 }
 
+struct hda_alc298_mbxinit {
+	unsigned char value_0x23;
+	unsigned char value_0x25;
+};
+
+void alc298_stereo_seq(struct hda_codec *codec,
+				struct hda_alc298_mbxinit *initval, int first)
+{
+	snd_hda_codec_write(codec, 0x6, 0, 0x73e, 0x0);
+	alc_write_coef_idx(codec, 0x26, 0xb000);
+
+	if (first)
+		snd_hda_codec_write(codec, 0x21, 0, 0xf09, 0x0);
+
+	snd_hda_codec_write(codec, 0x6, 0, 0x73e, 0x80);
+	alc_write_coef_idx(codec, 0x26, 0xf000);
+	alc_write_coef_idx(codec, 0x23, initval->value_0x23);
+
+	if (initval->value_0x23 != 0x1e)
+		alc_write_coef_idx(codec, 0x25, initval->value_0x25);
+
+	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX, 0x26);
+	snd_hda_codec_write(codec, 0x20, 0, 0x4b0, 0x10);
+}
+
+void alc298_fixup_huawei_mbx_stereo(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	// Initialization magic
+	static struct hda_alc298_mbxinit dac_init[] = {
+		{0xc, 0x0}, {0xd, 0x0}, {0xe, 0x0}, {0xf, 0x0},
+		{0x10, 0x0}, {0x1a, 0x40}, {0x1b, 0x82}, {0x1c, 0x0},
+		{0x1d, 0x0}, {0x1e, 0x0}, {0x1f, 0x0},
+		{0x20, 0xc2}, {0x21, 0xc8}, {0x22, 0x26}, {0x23, 0x24},
+		{0x27, 0xff}, {0x28, 0xff}, {0x29, 0xff}, {0x2a, 0x8f},
+		{0x2b, 0x2}, {0x2c, 0x48}, {0x2d, 0x34}, {0x2e, 0x0},
+		{0x2f, 0x0},
+		{0x30, 0x0}, {0x31, 0x0}, {0x32, 0x0}, {0x33, 0x0},
+		{0x34, 0x0}, {0x35, 0x1}, {0x36, 0x93}, {0x37, 0xc},
+		{0x38, 0x0}, {0x39, 0x0}, {0x3a, 0xf8}, {0x38, 0x80},
+		{}
+	};
+	struct hda_alc298_mbxinit *seq = dac_init;
+
+	// Start
+	snd_hda_codec_write(codec, 0x6, 0, 0x73e, 0x0);
+	snd_hda_codec_write(codec, 0x6, 0, 0x73e, 0x80);
+	alc_write_coef_idx(codec, 0x26, 0xf000);
+	alc_write_coef_idx(codec, 0x22, 0x31);
+	alc_write_coef_idx(codec, 0x23, 0xb);
+	alc_write_coef_idx(codec, 0x25, 0x0);
+	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX, 0x26);
+	snd_hda_codec_write(codec, 0x20, 0, 0x4b0, 0x10);
+
+	for (; seq->value_0x23; seq++)
+		alc298_stereo_seq(codec, seq, seq == dac_init);
+}
+
 static void alc269_fixup_x101_headset_mic(struct hda_codec *codec,
 				     const struct hda_fixup *fix, int action)
 {
@@ -3638,7 +3696,6 @@ static void alc269_fixup_x101_headset_mic(struct hda_codec *codec,
 	}
 }
 
-
 /* update mute-LED according to the speaker mute state via mic VREF pin */
 static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 {
@@ -5582,6 +5639,7 @@ enum {
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC298_FIXUP_HUAWEI_MBX_STEREO,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
@@ -5880,6 +5938,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_MIC_MUTE_LED
 	},
+	[ALC298_FIXUP_HUAWEI_MBX_STEREO] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc298_fixup_huawei_mbx_stereo,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_MIC_MUTE_LED
+	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_x101_headset_mic,
@@ -6778,8 +6842,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC298_FIXUP_HUAWEI_MBX_STEREO),
+	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC298_FIXUP_HUAWEI_MBX_STEREO),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
-- 
2.20.1
