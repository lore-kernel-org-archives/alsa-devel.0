From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 01/11] ALSA: hda/ca0132 - Fix AE-5 control type
Date: Sat, 29 Sep 2018 23:03:16 -0400
Message-ID: <1538276607-30234-2-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch corrects the control type of the additional AE-5 controls
added in a previous patch from HDA_INPUT to HDA_OUTPUT.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 225aa05..aebc592 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6109,7 +6109,7 @@ static int ae5_add_headphone_gain_enum(struct hda_codec *codec)
 {
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_MUTE_MONO("AE-5: Headphone Gain",
-				    AE5_HEADPHONE_GAIN_ENUM, 1, 0, HDA_INPUT);
+				    AE5_HEADPHONE_GAIN_ENUM, 1, 0, HDA_OUTPUT);
 	knew.info = ae5_headphone_gain_info;
 	knew.get = ae5_headphone_gain_get;
 	knew.put = ae5_headphone_gain_put;
@@ -6126,7 +6126,7 @@ static int ae5_add_sound_filter_enum(struct hda_codec *codec)
 {
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_MUTE_MONO("AE-5: Sound Filter",
-				    AE5_SOUND_FILTER_ENUM, 1, 0, HDA_INPUT);
+				    AE5_SOUND_FILTER_ENUM, 1, 0, HDA_OUTPUT);
 	knew.info = ae5_sound_filter_info;
 	knew.get = ae5_sound_filter_get;
 	knew.put = ae5_sound_filter_put;
-- 
2.7.4
