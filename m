From: Kailang <kailang@realtek.com>
Subject: Add support for ALC293 UAJ
Date: Mon, 28 Apr 2014 16:55:25 +0800
Message-ID: <9C1E8383A2304E8398F4E791B6EF8DF3@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_1B7C_01CF6302.A6D86E40"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3190D26167E
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:55:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_1B7C_01CF6302.A6D86E40
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,
 
Attach is support alc293 UAJ patch.
 
 BR,
Kailang
------=_NextPart_000_1B7C_01CF6302.A6D86E40
Content-Type: application/octet-stream;
	name="0000-add-alc293-uaj-supported.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-alc293-uaj-supported.patch"

>From 604cece67acd332a965f8490d3a847d0b98d4081 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 23 Apr 2014 17:34:28 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add new codec ALC293/ALC3235 UAJ=0A=
 supported=0A=
=0A=
New codec ALC293/ALC3235 support multifunction jacks.=0A=
It used for menual select the input device.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index c643dfc..b89755e 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -3538,6 +3538,25 @@ static void alc_headset_mode_unplugged(struct =
hda_codec *codec)=0A=
 		alc_write_coef_idx(codec, 0x18, 0x7308);=0A=
 		alc_write_coef_idx(codec, 0x6b, 0xc429);=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* SET Line1 JD to 0 */=0A=
+		val =3D alc_read_coef_idx(codec, 0x10);=0A=
+		alc_write_coef_idx(codec, 0x10, (val & ~(7<<8)) | 6<<8);=0A=
+		/* SET charge pump by verb */=0A=
+		val =3D alc_read_coefex_idx(codec, 0x57, 0x05);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x05, (val & ~(1<<15|1<<13)) | 0x0);=0A=
+		/* SET EN_OSW to 1 */=0A=
+		val =3D alc_read_coefex_idx(codec, 0x57, 0x03);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, (val & ~(1<<10)) | (1<<10) );=0A=
+		/* Combo JD gating with LINE1-VREFO */=0A=
+		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
+		alc_write_coef_idx(codec, 0x1a, (val & ~(1<<3)) | (1<<3));=0A=
+		/* Set to TRS type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
+		/* Combo Jack auto detect */=0A=
+		val =3D alc_read_coef_idx(codec, 0x4a);=0A=
+		alc_write_coef_idx(codec, 0x4a, (val & 0xfff0) | 0x000e);=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x15, 0x0d40);=0A=
 		alc_write_coef_idx(codec, 0xb7, 0x802b);=0A=
@@ -3576,6 +3595,21 @@ static void alc_headset_mode_mic_in(struct =
hda_codec *codec, hda_nid_t hp_pin,=0A=
 		alc_write_coef_idx(codec, 0x19, 0xa208);=0A=
 		alc_write_coef_idx(codec, 0x2e, 0xacf0);=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* Set to TRS mode */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);=0A=
+		/* SET charge pump by verb */=0A=
+		val =3D alc_read_coefex_idx(codec, 0x57, 0x05);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x05, (val & ~(1<<15|1<<13)) | =
(1<<15|1<<13));=0A=
+		/* SET EN_OSW to 0 */=0A=
+		val =3D alc_read_coefex_idx(codec, 0x57, 0x03);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, (val & ~(1<<10)) | 0x0);=0A=
+		/* Combo JD gating without LINE1-VREFO */=0A=
+		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
+		alc_write_coef_idx(codec, 0x1a, (val & ~(1<<3)) | 0x0);=0A=
+		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x11, 0x0001);=0A=
 		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);=0A=
@@ -3591,6 +3625,8 @@ static void alc_headset_mode_mic_in(struct =
hda_codec *codec, hda_nid_t hp_pin,=0A=
 =0A=
 static void alc_headset_mode_default(struct hda_codec *codec)=0A=
 {=0A=
+	int val;=0A=
+=0A=
 	switch (codec->vendor_id) {=0A=
 	case 0x10ec0255:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xc089);=0A=
@@ -3608,6 +3644,16 @@ static void alc_headset_mode_default(struct =
hda_codec *codec)=0A=
 		alc_write_coef_idx(codec, 0x6b, 0xc429);=0A=
 		alc_write_coef_idx(codec, 0x18, 0x7308);=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* Combo Jack auto detect */=0A=
+		val =3D alc_read_coef_idx(codec, 0x4a);=0A=
+		alc_write_coef_idx(codec, 0x4a, (val & 0xfff0) | 0x000e);=0A=
+		/* Set to TRS type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xC429);=0A=
+		/* Combo JD gating without LINE1-VREFO */=0A=
+		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
+		alc_write_coef_idx(codec, 0x1a, (val & ~(1<<3)) | 0x0);=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x11, 0x0041);=0A=
 		alc_write_coef_idx(codec, 0x15, 0x0d40);=0A=
@@ -3620,6 +3666,8 @@ static void alc_headset_mode_default(struct =
hda_codec *codec)=0A=
 /* Iphone type */=0A=
 static void alc_headset_mode_ctia(struct hda_codec *codec)=0A=
 {=0A=
+	int val;=0A=
+=0A=
 	switch (codec->vendor_id) {=0A=
 	case 0x10ec0255:=0A=
 		/* Set to CTIA type */=0A=
@@ -3637,6 +3685,13 @@ static void alc_headset_mode_ctia(struct =
hda_codec *codec)=0A=
 		alc_write_coef_idx(codec, 0x76, 0x0008);=0A=
 		alc_write_coef_idx(codec, 0x18, 0x7388);=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* Set to ctia type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xd429);=0A=
+		/* SET Line1 JD to 1 */=0A=
+		val =3D alc_read_coef_idx(codec, 0x10);=0A=
+		alc_write_coef_idx(codec, 0x10, (val & ~(7<<8)) | 7<<8);=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x11, 0x0001);=0A=
 		alc_write_coef_idx(codec, 0x15, 0x0d60);=0A=
@@ -3649,6 +3704,8 @@ static void alc_headset_mode_ctia(struct hda_codec =
*codec)=0A=
 /* Nokia type */=0A=
 static void alc_headset_mode_omtp(struct hda_codec *codec)=0A=
 {=0A=
+	int val;=0A=
+=0A=
 	switch (codec->vendor_id) {=0A=
 	case 0x10ec0255:=0A=
 		/* Set to OMTP Type */=0A=
@@ -3666,6 +3723,13 @@ static void alc_headset_mode_omtp(struct =
hda_codec *codec)=0A=
 		alc_write_coef_idx(codec, 0x76, 0x0008);=0A=
 		alc_write_coef_idx(codec, 0x18, 0x7388);=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* Set to omtp type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xe429);=0A=
+		/* SET Line1 JD to 1 */=0A=
+		val =3D alc_read_coef_idx(codec, 0x10);=0A=
+		alc_write_coef_idx(codec, 0x10, (val & ~(7<<8)) | 7<<8);=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x11, 0x0001);=0A=
 		alc_write_coef_idx(codec, 0x15, 0x0d50);=0A=
@@ -3703,6 +3767,16 @@ static void alc_determine_headset_type(struct =
hda_codec *codec)=0A=
 		val =3D alc_read_coef_idx(codec, 0x6c);=0A=
 		is_ctia =3D (val & 0x001c) =3D=3D 0x001c;=0A=
 		break;=0A=
+	case 0x10ec0293:=0A=
+		/* Combo Jack auto detect */=0A=
+		val =3D alc_read_coef_idx(codec, 0x4a);=0A=
+		alc_write_coef_idx(codec, 0x4a, (val & 0xfff0) | 0x0008);=0A=
+		/* Set to ctia type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xD429);=0A=
+		msleep(300);=0A=
+		val =3D alc_read_coef_idx(codec, 0x46);=0A=
+		is_ctia =3D (val & 0x0070) =3D=3D 0x0070;=0A=
+		break;=0A=
 	case 0x10ec0668:=0A=
 		alc_write_coef_idx(codec, 0x11, 0x0001);=0A=
 		alc_write_coef_idx(codec, 0xb7, 0x802b);=0A=
@@ -4159,6 +4233,7 @@ enum {=0A=
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,=0A=
 	ALC255_FIXUP_HEADSET_MODE,=0A=
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,=0A=
+	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,=0A=
 };=0A=
 =0A=
 static const struct hda_fixup alc269_fixups[] =3D {=0A=
@@ -4552,6 +4627,16 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.type =3D HDA_FIXUP_FUNC,=0A=
 		.v.func =3D alc_fixup_headset_mode_alc255_no_hp_mic,=0A=
 	},=0A=
+	[ALC293_FIXUP_DELL1_MIC_NO_PRESENCE] =3D {=0A=
+		.type =3D HDA_FIXUP_PINS,=0A=
+		.v.pins =3D (const struct hda_pintbl[]) {=0A=
+			{ 0x18, 0x01a1913d }, /* use as headphone mic, without its own jack =
detect */=0A=
+			{ 0x1a, 0x01a1913c }, /* use as headset mic, without its own jack =
detect */=0A=
+			{ }=0A=
+		},=0A=
+		.chained =3D true,=0A=
+		.chain_id =3D ALC269_FIXUP_HEADSET_MODE=0A=
+	},=0A=
 };=0A=
 =0A=
 static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {=0A=
@@ -4609,6 +4694,8 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x1028, 0x0638, "Dell Inspiron 5439", =
ALC290_FIXUP_MONO_SPEAKERS_HSJACK),=0A=
 	SND_PCI_QUIRK(0x1028, 0x063e, "Dell", =
ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x064a, "Dell", =
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x064b, "Dell", =
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x0640, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x064d, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x0651, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
@@ -4624,6 +4711,8 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x1028, 0x067f, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", =
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", =
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", =
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", =
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),=0A=
 	SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=

------=_NextPart_000_1B7C_01CF6302.A6D86E40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_1B7C_01CF6302.A6D86E40--
