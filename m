From: Kailang <kailang@realtek.com>
Subject: Add support for headset Mic of Dell
Date: Wed, 16 Apr 2014 16:24:23 +0800
Message-ID: <A78531D31FD94EBAB83CEFE9680CF095@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_00EA_01CF5990.53D1BA10"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E401E261A66
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 10:24:27 +0200 (CEST)
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

------=_NextPart_000_00EA_01CF5990.53D1BA10
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Add support for Dell machine for Headset Mic support.
SSID: 0x0696 and 0x0698

Thanks.

BR,
Kailang
------=_NextPart_000_00EA_01CF5990.53D1BA10
Content-Type: application/octet-stream;
	name="0000-add-headset-mic-support-for-dell.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-headset-mic-support-for-dell.patch"

>From d6c4406f4824bb04a12aebc49c106e5f9b22c9a7 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 16 Apr 2014 15:53:12 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add headset Mic support for Dell =
machine=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 26895d1..c643dfc 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -5541,6 +5541,8 @@ static const struct snd_pci_quirk =
alc662_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x1028, 0x0626, "Dell", =
ALC668_FIXUP_DELL_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x0628, "Dell", ALC668_FIXUP_AUTO_MUTE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x064e, "Dell", ALC668_FIXUP_AUTO_MUTE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x0696, "Dell", =
ALC668_FIXUP_DELL_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", =
ALC668_FIXUP_DELL_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),=0A=
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A),=0A=
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", =
ALC662_FIXUP_BASS_MODE4_CHMAP),=0A=

------=_NextPart_000_00EA_01CF5990.53D1BA10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_00EA_01CF5990.53D1BA10--
