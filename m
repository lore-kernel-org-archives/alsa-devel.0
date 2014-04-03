From: Kailang <kailang@realtek.com>
Subject: Fixed single output empty pin_sense issue for alc283
Date: Thu, 3 Apr 2014 17:32:52 +0800
Message-ID: <4CBE02BCC899412BBCE708F173975C01@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0095_01CF4F62.BDA6AC80"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C34D265678
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 11:32:58 +0200 (CEST)
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

------=_NextPart_000_0095_01CF4F62.BDA6AC80
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Some machine with single output. It has only one HP out on it.
alc283_init and alc283_shutup will get empty hp_pin value.
I add the check for the attachment patch.
Thanks.

BR,
Kailang
------=_NextPart_000_0095_01CF4F62.BDA6AC80
Content-Type: application/octet-stream;
	name="0000-solve-hp-pins-empty.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-solve-hp-pins-empty.patch"

>From bd51a4611d373c5e4895023cb658ae1371783d94 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Thu, 3 Apr 2014 17:28:39 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Fixed single output machine get =
empty hp=0A=
 sense=0A=
=0A=
If it only has single output of HP out of machine.=0A=
The driver parser will copy hp_pins to line_out_pins.=0A=
hp_pins will empty for alc283_init and alc283_shutup functions.=0A=
This will cause not have value for hp_pin_sense.=0A=
Add check line_out_type code will solve it .=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index d6e4230..cd8ca1d 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -3026,6 +3026,11 @@ static void alc283_init(struct hda_codec *codec)=0A=
 	bool hp_pin_sense;=0A=
 	int val;=0A=
 =0A=
+	if (!spec->gen.autocfg.hp_outs) {=0A=
+		if (spec->gen.autocfg.line_out_type =3D=3D AC_JACK_HP_OUT)=0A=
+			hp_pin =3D spec->gen.autocfg.line_out_pins[0];=0A=
+	}=0A=
+=0A=
 	alc283_restore_default_value(codec);=0A=
 =0A=
 	if (!hp_pin)=0A=
@@ -3062,6 +3067,11 @@ static void alc283_shutup(struct hda_codec *codec)=0A=
 	bool hp_pin_sense;=0A=
 	int val;=0A=
 =0A=
+	if (!spec->gen.autocfg.hp_outs) {=0A=
+		if (spec->gen.autocfg.line_out_type =3D=3D AC_JACK_HP_OUT)=0A=
+			hp_pin =3D spec->gen.autocfg.line_out_pins[0];=0A=
+	}=0A=
+=0A=
 	if (!hp_pin) {=0A=
 		alc269_shutup(codec);=0A=
 		return;=0A=

------=_NextPart_000_0095_01CF4F62.BDA6AC80
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0095_01CF4F62.BDA6AC80--
