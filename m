From: Kailang <kailang@realtek.com>
Subject: Remove fixup list for HP
Date: Mon, 2 Dec 2013 17:20:37 +0800
Message-ID: <518AFC8C447A490197E89F86A38FA213@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0011_01CEEF82.D10F4970"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DCE1261AF7
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:20:54 +0100 (CET)
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

------=_NextPart_000_0011_01CEEF82.D10F4970
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Chrome OS was loaded driver by models.
The patch was remove the alc269 fixup entry for HP chrome book.

Thanks.
Kialang
------=_NextPart_000_0011_01CEEF82.D10F4970
Content-Type: application/octet-stream; name="0000-remove-fixup-hp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-remove-fixup-hp.patch"

>From b27aa9d5af3f92909bd336cdbd0b465731a48522 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 2 Dec 2013 14:56:38 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Remove fixup list of HP for ALC283=0A=
=0A=
Chrome OS loaded driver by models. Remove old assigned fixup table from=0A=
ALC269 fixup list entry.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 537991c..692805d 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4262,7 +4262,6 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1983, "HP Pavilion", =
ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x218b, "HP", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED),=0A=
-	SND_PCI_QUIRK(0x103c, 0x21ed, "HP Falco Chromebook", =
ALC283_FIXUP_CHROME_BOOK),=0A=
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),=0A=
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", =
ALC269_FIXUP_LIMIT_INT_MIC_BOOST),=0A=

------=_NextPart_000_0011_01CEEF82.D10F4970
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0011_01CEEF82.D10F4970--
