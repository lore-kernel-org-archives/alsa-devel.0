From: Kailang <kailang@realtek.com>
Subject: Enable more HP machine to enable mute led
Date: Fri, 13 Jun 2014 17:27:31 +0800
Message-ID: <AD477C06ADA84EB4A008D8EF0A900D8F@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_002E_01CF872C.C1B15990"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8902618F2
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:27:18 +0200 (CEST)
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

------=_NextPart_000_002E_01CF872C.C1B15990
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

 Hi Takashi,
 
Add more HP machine to support mute led functions.
 
 Thanks.
 
 BR,
Kailang
------=_NextPart_000_002E_01CF872C.C1B15990
Content-Type: application/octet-stream;
	name="0000-add-mute-led-for-hp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-add-mute-led-for-hp.patch"

>From f06f78fc2fd45c004ab512b77b4e1945bb52ffda Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 13 Jun 2014 17:16:31 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add more entry for enable HP mute =
led=0A=
=0A=
More HP machine need mute led support.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 9c095fa..874647c 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4774,14 +4774,24 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),=0A=
 	/* ALC282 */=0A=
+	SND_PCI_QUIRK(0x103c, 0x220d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x220e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x220f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2211, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2212, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2213, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2214, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2266, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2267, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2268, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2269, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x226a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x226b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x226f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x227a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x227b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x229e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
@@ -4821,6 +4831,10 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c8, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c3, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c4, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2334, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2335, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2336, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2337, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),=0A=
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),=0A=

------=_NextPart_000_002E_01CF872C.C1B15990
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_002E_01CF872C.C1B15990--
