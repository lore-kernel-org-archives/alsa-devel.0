From: Kailang <kailang@realtek.com>
Subject: RE: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date: Thu, 14 Mar 2019 09:22:21 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBA208@RTITMBSVM07.realtek.com.tw>
References: <20190314085933.11404-1-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314085933.11404-1-jian-hong@endlessm.com>
Content-Language: zh-TW
Sender: linux-kernel-owner@vger.kernel.org
To: Jian-Hong Pan <jian-hong@endlessm.com>, Takashi Iwai <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@endlessm.com" <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Don't do this coef setting. It will always assign it for iphone type.
You could dump alsa-info for me with dump coef bit.
Also please plugged headset to dump.

BR,
Kailang

-----Original Message-----
From: Jian-Hong Pan <jian-hong@endlessm.com> 
Sent: Thursday, March 14, 2019 5:00 PM
To: Takashi Iwai <tiwai@suse.com>
Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286

Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot record sound from headset MIC.  This patch adds the ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index a63670013943..b3fbad5a680f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5695,6 +5695,7 @@ enum {
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
 	ALC295_FIXUP_CHROME_BOOK,
+	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -6677,6 +6678,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC225_FIXUP_HEADSET_JACK
 	},
+	[ALC286_FIXUP_ACER_AIO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xd429 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -6693,9 +6704,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", 
+ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
--
2.20.1
