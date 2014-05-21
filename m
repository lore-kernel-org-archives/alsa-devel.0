From: Kailang <kailang@realtek.com>
Subject: Add support headset mode for alc233
Date: Wed, 21 May 2014 16:55:14 +0800
Message-ID: <63BEDABFE2C64AB9A79D9D9A63810BCF@realtek.com.tw>
References: <3143A3763CC94AB9AAD48E43EA2B4DFC@realtek.com.tw><s5h8upw6gf6.wl%tiwai@suse.de><72897913D05F4C12BCED9FF890C77D61@realtek.com.tw><s5hha4kbz4q.wl%tiwai@suse.de><66A4EBB5FA74484E9FB040780F3C8965@realtek.com.tw><s5hd2f8bxns.wl%tiwai@suse.de><AC509D0AEA71499FB3503597855A4B0A@realtek.com.tw><s5h4n0kbw0e.wl%tiwai@suse.de><DA522F18DEB345498651505F8E1E9873@realtek.com.tw>
 <s5hwqdf4qd5.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_00A0_01CF7515.6FD38590"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CF4A9261B11
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 10:55:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_00A0_01CF7515.6FD38590
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Attach is support headset mode for alc233 patch.

BR,
Kailang
------=_NextPart_000_00A0_01CF7515.6FD38590
Content-Type: application/octet-stream;
	name="0000-add-support-headset-mode-for-alc233.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-support-headset-mode-for-alc233.patch"

>From f84879b9898a582319b15076562f1758028e1263 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 21 May 2014 16:49:48 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add support headset mode for ALC233=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index c6c35f7..069767b 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -3525,6 +3525,7 @@ static void alc_headset_mode_unplugged(struct =
hda_codec *codec)=0A=
 		/* Direct Drive HP Amp control */=0A=
 		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c0b);=0A=
 		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
@@ -3596,6 +3597,7 @@ static void alc_headset_mode_mic_in(struct =
hda_codec *codec, hda_nid_t hp_pin,=0A=
 		alc_write_coef_idx(codec, 0x06, 0x6100);=0A=
 		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
 		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);=0A=
@@ -3667,6 +3669,7 @@ static void alc_headset_mode_default(struct =
hda_codec *codec)=0A=
 		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
 		alc_write_coef_idx(codec, 0x49, 0x0049);=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x06, 0x2100);=0A=
 		alc_write_coef_idx(codec, 0x32, 0x4ea3);=0A=
@@ -3721,6 +3724,7 @@ static void alc_headset_mode_ctia(struct hda_codec =
*codec)=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
 		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xd429);=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
@@ -3773,6 +3777,7 @@ static void alc_headset_mode_omtp(struct hda_codec =
*codec)=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
 		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xe429);=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
@@ -3829,6 +3834,7 @@ static void alc_determine_headset_type(struct =
hda_codec *codec)=0A=
 		val =3D alc_read_coef_idx(codec, 0x46);=0A=
 		is_ctia =3D (val & 0x0070) =3D=3D 0x0070;=0A=
 		break;=0A=
+	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xd029);=0A=
 		msleep(300);=0A=

------=_NextPart_000_00A0_01CF7515.6FD38590
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_00A0_01CF7515.6FD38590--
