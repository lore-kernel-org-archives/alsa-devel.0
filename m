From: Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH v3] ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop
Date: Mon, 26 Nov 2018 13:40:46 -0500
Message-ID: <1543257648-105480-1-git-send-email-gkumar@neverware.com>
References: <s5hefbeax39.wl-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hefbeax39.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Girija Kumar Kasinadhuni <gkumar@neverware.com>
List-Id: alsa-devel@alsa-project.org

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
Apologies for the earlier patch not being tested properly. Verified this
time, and on the actual hardware. Here' s the alsa-info output.
http://www.alsa-project.org/db/?f=16bc34d9bf8c9b2536969c125c1721fee570c9b0

 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 970bc44..c39f7f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5495,6 +5495,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC295_FIXUP_HP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5659,6 +5660,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_HP_MUTE_LED_MIC3] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led_mic3,
+		.chained = true,
+		.chain_id = ALC295_FIXUP_HP_AUTO_MUTE
 	},
 	[ALC269_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6362,6 +6365,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC295_FIXUP_HP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
-- 
2.7.4
