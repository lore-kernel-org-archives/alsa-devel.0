From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: Disable PC beep in
	passthrough on alc285
Date: Thu, 14 Feb 2019 11:41:33 +0800
Message-ID: <20190214034133.8164-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F23B267418
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 04:41:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

It is reported that there's a constant background "hum/whitenoise"
in the headset on the Lenovo X1 machines with the codec alc285, and it
is confirmed that if we run the command below, the noise will stop.
 sudo hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0

Then I consulted this issue with Kailang, he told me the pin 0x1d on
this codec is used for PC beep in, the noise probably comes from this
pin and we can also disable the PC beep in passthrough, then the PC
beep in will not affect other sound playback.

Fixes: c4cfcf6f4297 ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1660581
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ba3d4bee7f85..6cd8d392106f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5662,6 +5662,7 @@ enum {
 	ALC294_FIXUP_ASUS_SPK,
 	ALC225_FIXUP_HEADSET_JACK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6617,6 +6618,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Disable PCBEEP-IN passthrough */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x36 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x57d7 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7302,7 +7314,7 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x19, 0x03a11020},
 		{0x21, 0x0321101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0285, 0x17aa, "Lenovo", ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
+	SND_HDA_PIN_QUIRK(0x10ec0285, 0x17aa, "Lenovo", ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},
-- 
2.17.1
