From: Kailang <kailang@realtek.com>
Subject: Improve hp pop noise
Date: Mon, 7 Apr 2014 16:59:23 +0800
Message-ID: <00A5C335971D4A02A0E52B6C7F5C64CF@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw>
 <s5hmwfxmt5o.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_008E_01CF5282.BA0639B0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC7726007E
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 10:59:31 +0200 (CEST)
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_008E_01CF5282.BA0639B0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

In our test, it is better to set Mic2-vref control to manual mode.
It will have better result for HP pop noise.
So, I fill it back in this patch.

BR,
Kailang
------=_NextPart_000_008E_01CF5282.BA0639B0
Content-Type: application/octet-stream;
	name="0000-improve-hp-pop-noise.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-improve-hp-pop-noise.patch"

>From 91b5643db5db060f21808e22a416540d061181de Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 7 Apr 2014 16:41:52 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Improve HP depop when system change =
power=0A=
 state=0A=
=0A=
It is better to change Mic2-Vref to manual mode.=0A=
Manual control Mic2-Vref will solve pop noise issue.=0A=
It will improve pop noise for power on, power off=0A=
,S3 and resume.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 4ce744b..b36be20 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4005,6 +4005,10 @@ static void alc283_fixup_chromebook(struct =
hda_codec *codec,=0A=
 		spec->gen.mixer_nid =3D 0;=0A=
 		break;=0A=
 	case HDA_FIXUP_ACT_INIT:=0A=
+		/* MIC2-VREF control */=0A=
+		/* Set to manual mode */=0A=
+		val =3D alc_read_coef_idx(codec, 0x06);=0A=
+		alc_write_coef_idx(codec, 0x06, val & ~0x000c);=0A=
 		/* Enable Line1 input control by verb */=0A=
 		val =3D alc_read_coef_idx(codec, 0x1a);=0A=
 		alc_write_coef_idx(codec, 0x1a, val | (1 << 4));=0A=

------=_NextPart_000_008E_01CF5282.BA0639B0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_008E_01CF5282.BA0639B0--
