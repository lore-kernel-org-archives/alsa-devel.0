From: Kailang <kailang@realtek.com>
Subject: Re: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and
	headset-mode fixups for ASUS X542UN
Date: Wed, 5 Dec 2018 08:36:23 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id B449A267BEF
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 09:36:34 +0100 (CET)
In-Reply-To: <20181205074212.31104-2-jian-hong@endlessm.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jian-Hong Pan <jian-hong@endlessm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Chris Chiu <chiu@endlessm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, "linux@endlessm.com" <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi Jian-Hong,

Could you test to change the model to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC?

.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC


BR,
Kailang
-----Original Message-----
From: Jian-Hong Pan <jian-hong@endlessm.com> 
Sent: Wednesday, December 5, 2018 3:42 PM
To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>
Cc: Kailang <kailang@realtek.com>; Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Chris Chiu <chiu@endlessm.com>; Jian-Hong Pan <jian-hong@endlessm.com>; Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

From: Chris Chiu <chiu@endlessm.com>

The known ALC256_FIXUP_ASUS_MIC fixup can fix the headphone jack sensing and enable use of the internal microphone on this laptop X542UN. However, it's ALC294 so create a new fixup named ALC294_FIXUP_ASUS_MIC to avoid confusion.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index bb40624fb6d5..bbae06267054 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5517,6 +5517,7 @@ enum {
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -6403,6 +6404,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x13, 0x90a60160 }, /* use as internal mic */
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -7152,6 +7163,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
+		{0x14, 0x90170110},
+		{0x1b, 0x90a70130},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
--
2.11.0
