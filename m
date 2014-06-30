From: Kailang <kailang@realtek.com>
Subject: ALC286 recording delay
Date: Mon, 30 Jun 2014 16:25:46 +0800
Message-ID: <EF9E26FF321C429281C88C574F0373A6@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_014B_01CF947F.F2280460"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E46262617B6
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 10:25:50 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_014B_01CF947F.F2280460
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,
 
It will be recording voice delay for resume back recording for Headset Mic.
This patch doesn't disable pin for suspend state. The issue was fixed.
This is follow ALC286 programing guide.
 
Thanks.
 
BR,
Kailang
------=_NextPart_000_014B_01CF947F.F2280460
Content-Type: application/octet-stream;
	name="0000-alc286-fixed-recording-delay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-alc286-fixed-recording-delay.patch"

>From 5d7ae195257daaffa1497d2c79d06aa01b9754b0 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 30 Jun 2014 16:10:37 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Fixed ALC286/ALC288 recording delay =
for=0A=
 Headset Mic=0A=
=0A=
It will be recording voice delay for resume back recording for Headset =
Mic.=0A=
This patch doesn't disable pin for suspend state. The issue was fixed.=0A=
This is follow ALC286 programing guide.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 60bf5ee..13cdefb 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -2782,6 +2782,25 @@ static int alc269_parse_auto_config(struct =
hda_codec *codec)=0A=
 	return alc_parse_auto_config(codec, alc269_ignore, ssids);=0A=
 }=0A=
 =0A=
+void alc_snd_hda_shutup_pins(struct hda_codec *codec)=0A=
+{=0A=
+	int i;=0A=
+	int mic_pin =3D find_ext_mic_pin(codec);=0A=
+	/* don't shut up pins when unloading the driver; otherwise it breaks=0A=
+	 * the default pin setup at the next load of the driver=0A=
+	 */=0A=
+	if (codec->bus->shutdown)=0A=
+		return;=0A=
+	for (i =3D 0; i < codec->init_pins.used; i++) {=0A=
+		struct hda_pincfg *pin =3D snd_array_elem(&codec->init_pins, i);=0A=
+		/* use read here for syncing after issuing each verb */=0A=
+		if (pin->nid !=3D mic_pin)=0A=
+			snd_hda_codec_read(codec, pin->nid, 0,=0A=
+					AC_VERB_SET_PIN_WIDGET_CONTROL, 0);=0A=
+	}=0A=
+	codec->pins_shutup =3D 1;=0A=
+}=0A=
+=0A=
 static void alc269vb_toggle_power_output(struct hda_codec *codec, int =
power_up)=0A=
 {=0A=
 	int val =3D alc_read_coef_idx(codec, 0x04);=0A=
@@ -5326,6 +5345,7 @@ static int patch_alc269(struct hda_codec *codec)=0A=
 	case 0x10ec0286:=0A=
 	case 0x10ec0288:=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC286;=0A=
+		spec->shutup =3D alc_snd_hda_shutup_pins;=0A=
 		break;=0A=
 	case 0x10ec0255:=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC255;=0A=

------=_NextPart_000_014B_01CF947F.F2280460
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_014B_01CF947F.F2280460--
