From: Kailang <kailang@realtek.com>
Subject: Restore default value for alc283
Date: Mon, 17 Mar 2014 14:23:24 +0800
Message-ID: <D81AAF74416842738C1CABAFD266B47A@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0048_01CF41EC.74AAC670"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CE7D1261691
 for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2014 07:23:29 +0100 (CET)
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

------=_NextPart_000_0048_01CF41EC.74AAC670
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Hi Takashi,

Attachment is the patch for fix below issue.

Restore the registers to prevent the abnormal digital power supply
rising ratio/sequence to the codec and causing the incorrect default
codec register restoration during initialization.

Many Thanks.

BR,
Kailang
------=_NextPart_000_0048_01CF41EC.74AAC670
Content-Type: application/octet-stream;
	name="0000-restore-default-for-alc283.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-restore-default-for-alc283.patch"

>From 54cb00f4f0d73cfbb450e17e264c4a72de45912a Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 17 Mar 2014 13:51:27 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Restore default value for ALC283=0A=
=0A=
Restore the registers to prevent the abnormal digital power supply=0A=
rising ratio/sequence to the codec and causing the incorrect default=0A=
codec register restoration during initialization.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 42b4f4d..56c7648 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -2787,6 +2787,89 @@ static void alc269_shutup(struct hda_codec *codec)=0A=
 	snd_hda_shutup_pins(codec);=0A=
 }=0A=
 =0A=
+static void alc283_restore_default_value(struct hda_codec *codec)=0A=
+{=0A=
+	int val;=0A=
+=0A=
+	/* Power Down Control */=0A=
+	alc_write_coef_idx(codec, 0x03, 0x0002);=0A=
+	/* FIFO and filter clock */=0A=
+	alc_write_coef_idx(codec, 0x05, 0x0700);=0A=
+	/* DMIC control */=0A=
+	alc_write_coef_idx(codec, 0x07, 0x0200);=0A=
+	/* Analog clock */=0A=
+	val =3D alc_read_coef_idx(codec, 0x06);=0A=
+	alc_write_coef_idx(codec, 0x06, (val & ~0x00f0) | 0x0);=0A=
+	/* JD */=0A=
+	val =3D alc_read_coef_idx(codec, 0x08);=0A=
+	alc_write_coef_idx(codec, 0x08, (val & ~0xfffc) | 0x0c2c);=0A=
+	/* JD offset1 */=0A=
+	alc_write_coef_idx(codec, 0x0a, 0xcccc);=0A=
+	/* JD offset2 */=0A=
+	alc_write_coef_idx(codec, 0x0b, 0xcccc);=0A=
+	/* LDO1/2/3, DAC/ADC */=0A=
+	alc_write_coef_idx(codec, 0x0e, 0x6fc0);=0A=
+	/* JD */=0A=
+	val =3D alc_read_coef_idx(codec, 0x0f);=0A=
+	alc_write_coef_idx(codec, 0x0f, (val & ~0xf800) | 0x1000);=0A=
+	/* Capless */=0A=
+	val =3D alc_read_coef_idx(codec, 0x10);=0A=
+	alc_write_coef_idx(codec, 0x10, (val & ~0xfc00) | 0x0c00);=0A=
+	/* Class D test 4 */=0A=
+	alc_write_coef_idx(codec, 0x3a, 0x0);=0A=
+	/* IO power down directly */=0A=
+	val =3D alc_read_coef_idx(codec, 0x0c);=0A=
+	alc_write_coef_idx(codec, 0x0c, (val & ~0xfe00) | 0x0);=0A=
+	/* ANC */=0A=
+	alc_write_coef_idx(codec, 0x22, 0xa0c0);=0A=
+	/* AGC MUX */=0A=
+	val =3D alc_read_coefex_idx(codec, 0x53, 0x01);=0A=
+	alc_write_coefex_idx(codec, 0x53, 0x01, (val & ~0x000f) | 0x0008 );=0A=
+	/* DAC simple content protection */=0A=
+	val =3D alc_read_coef_idx(codec, 0x1d);=0A=
+	alc_write_coef_idx(codec, 0x1d, (val & ~0x00e0) | 0x0);=0A=
+	/* ADC simple content protection */=0A=
+	val =3D alc_read_coef_idx(codec, 0x1f);=0A=
+	alc_write_coef_idx(codec, 0x1f, (val & ~0x00e0) | 0x0);=0A=
+	/* DAC ADC Zero Detection */=0A=
+	alc_write_coef_idx(codec, 0x21, 0x8804);=0A=
+	/* PLL */=0A=
+	alc_write_coef_idx(codec, 0x2e, 0x2902);=0A=
+	/* capless control 2 */=0A=
+	alc_write_coef_idx(codec, 0x33, 0xa080);=0A=
+	/* capless control 3 */=0A=
+	alc_write_coef_idx(codec, 0x34, 0x3400);=0A=
+	/* capless control 4 */=0A=
+	alc_write_coef_idx(codec, 0x35, 0x2f3e);=0A=
+	/* capless control 5 */=0A=
+	alc_write_coef_idx(codec, 0x36, 0x0);=0A=
+	/* class D test 2 */=0A=
+	val =3D alc_read_coef_idx(codec, 0x38);=0A=
+	alc_write_coef_idx(codec, 0x38, (val & ~0x0fff) | 0x0900);=0A=
+	/* class D test 3 */=0A=
+	alc_write_coef_idx(codec, 0x39, 0x110a);=0A=
+	/* class D test 5 */=0A=
+	val =3D alc_read_coef_idx(codec, 0x3b);=0A=
+	alc_write_coef_idx(codec, 0x3b, (val & ~0x00f8) | 0x00d8);=0A=
+	/* class D test 6 */=0A=
+	alc_write_coef_idx(codec, 0x3c, 0x0014);=0A=
+	/* classD OCP */=0A=
+	alc_write_coef_idx(codec, 0x3d, 0xc2ba);=0A=
+	/* classD pure DC test */=0A=
+	val =3D alc_read_coef_idx(codec, 0x42);=0A=
+	alc_write_coef_idx(codec, 0x42, (val & ~0x0f80) | 0x0);=0A=
+	/* test mode */=0A=
+	alc_write_coef_idx(codec, 0x49, 0x0);=0A=
+	/* Class D DC enable */=0A=
+	val =3D alc_read_coef_idx(codec, 0x40);=0A=
+	alc_write_coef_idx(codec, 0x40, (val & ~0xf800) | 0x9800);=0A=
+	/* DC offset */=0A=
+	val =3D alc_read_coef_idx(codec, 0x42);=0A=
+	alc_write_coef_idx(codec, 0x42, (val & ~0xf000) | 0x2000);=0A=
+	/* Class D amp control */=0A=
+	alc_write_coef_idx(codec, 0x37, 0xfc06);=0A=
+}=0A=
+=0A=
 static void alc283_init(struct hda_codec *codec)=0A=
 {=0A=
 	struct alc_spec *spec =3D codec->spec;=0A=
@@ -2794,6 +2877,8 @@ static void alc283_init(struct hda_codec *codec)=0A=
 	bool hp_pin_sense;=0A=
 	int val;=0A=
 =0A=
+	alc283_restore_default_value(codec);=0A=
+=0A=
 	if (!hp_pin)=0A=
 		return;=0A=
 	hp_pin_sense =3D snd_hda_jack_detect(codec, hp_pin);=0A=

------=_NextPart_000_0048_01CF41EC.74AAC670
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0048_01CF41EC.74AAC670--
