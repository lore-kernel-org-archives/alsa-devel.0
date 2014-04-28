From: Kailang <kailang@realtek.com>
Subject: Add two codecs alias for Dell
Date: Mon, 28 Apr 2014 16:53:35 +0800
Message-ID: <0283243B719E4DCF92BA54FAE764B547@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_1B70_01CF6302.6542BA30"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 012342608D3
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 10:53:37 +0200 (CEST)
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

------=_NextPart_000_1B70_01CF6302.6542BA30
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Two codecs alias name for Dell.

BR,
Kailang
------=_NextPart_000_1B70_01CF6302.6542BA30
Content-Type: application/octet-stream;
	name="0000-add-two-codecs-alias-for-dell.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-two-codecs-alias-for-dell.patch"

>From eaef33716b02642afef9c6ea9a011050c06dd20e Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 23 Apr 2014 16:06:13 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add two codecs alias name for Dell=0A=
=0A=
Add ALC3235 ALC3263.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index c643dfc..bce3698 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -951,7 +951,9 @@ static struct alc_codec_rename_pci_table =
rename_pci_tbl[] =3D {=0A=
 	{ 0x10ec0280, 0x1028, 0, "ALC3220" },=0A=
 	{ 0x10ec0282, 0x1028, 0, "ALC3221" },=0A=
 	{ 0x10ec0283, 0x1028, 0, "ALC3223" },=0A=
+	{ 0x10ec0288, 0x1028, 0, "ALC3263" },=0A=
 	{ 0x10ec0292, 0x1028, 0, "ALC3226" },=0A=
+	{ 0x10ec0293, 0x1028, 0, "ALC3235" },=0A=
 	{ 0x10ec0255, 0x1028, 0, "ALC3234" },=0A=
 	{ 0x10ec0668, 0x1028, 0, "ALC3661" },=0A=
 	{ } /* terminator */=0A=

------=_NextPart_000_1B70_01CF6302.6542BA30
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_1B70_01CF6302.6542BA30--
