From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/2] ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags
Date: Thu, 19 Apr 2018 13:29:04 +0800
Message-ID: <1524115745-7868-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Otherwise, the pin will be regarded as microphone, and the jack name
is "Mic Phantom", it is always on in the pulseaudio even nothing is
plugged into the jack. So the UI is confusing to users since the
microphone always shows up in the UI even there is no microphone
plugged.

After adding this flag, the jack name is "Headset Mic Phantom", then
the pulseaudio can handle its detection correctly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aef1f52..c3b63b7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6370,6 +6370,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
 };
 
-- 
2.7.4
