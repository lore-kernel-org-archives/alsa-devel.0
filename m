From: Kailang <kailang@realtek.com>
Subject: Enable more HP machine to enable mute led
Date: Fri, 21 Feb 2014 16:38:24 +0800
Message-ID: <6D6E0DA59F4A473884CD0501B111979F@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_007D_01CF2F23.569C5300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B94026172B
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 09:38:43 +0100 (CET)
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

------=_NextPart_000_007D_01CF2F23.569C5300
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

HP want to enable mute led functions for more machine.
I created patch as attach patch.

Thanks.

BR,
Kailang
------=_NextPart_000_007D_01CF2F23.569C5300
Content-Type: application/octet-stream; name="0000-enable-hp-mute-led.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-enable-hp-mute-led.patch"

>From a0bfe9e3e2c993fab0aa395cd098046e4a4d6db6 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 21 Feb 2014 16:23:35 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add more entry for enable HP mute =
led=0A=
=0A=
More HP machine need mute led support.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 0d80c7f..5615e17 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4320,6 +4320,53 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),=0A=
+	/* ALC282 */	=0A=
+	SND_PCI_QUIRK(0x103c, 0x220f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2213, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2266, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2267, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2268, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2269, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x227a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x227b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22a0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22b2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22b7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22bf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c1, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c2, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22cd, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22ce, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22d0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	/* ALC290 */=0A=
+	SND_PCI_QUIRK(0x103c, 0x2260, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2261, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2262, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2263, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2264, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2265, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x227d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x227e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x227f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2280, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2281, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c8, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c3, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22c4, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),=0A=
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),=0A=

------=_NextPart_000_007D_01CF2F23.569C5300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_007D_01CF2F23.569C5300--
