From: Kailang <kailang@realtek.com>
Subject: I lost one SSID for HP mute led
Date: Wed, 26 Feb 2014 15:34:55 +0800
Message-ID: <A94C2574276C453E9AEC5F1A70D56524@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_000D_01CF3308.4C919D00"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A62926536C
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 08:34:54 +0100 (CET)
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

------=_NextPart_000_000D_01CF3308.4C919D00
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,
 
I lost one SSID.
I add it as attach patch.
 
 Thanks.
 
 BR,
Kailang
------=_NextPart_000_000D_01CF3308.4C919D00
Content-Type: application/octet-stream;
	name="0000-add-more-ssid-for-hp-mute-led.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-more-ssid-for-hp-mute-led.patch"

>From f0f760a07435888a013154d6e4c7a7a3665be3ff Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 26 Feb 2014 15:23:19 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add more entry for enable HP mute =
led=0A=
=0A=
I lost this SSID. Add it into the fixup table.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 28cdbb8..4b428a9 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4360,6 +4360,7 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=

------=_NextPart_000_000D_01CF3308.4C919D00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_000D_01CF3308.4C919D00--
