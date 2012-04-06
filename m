From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 4/6] ALSA: hda - Remove CD control from model=benq for CX20549
Date: Fri,  6 Apr 2012 15:34:18 +0200
Message-ID: <1333719260-14504-5-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
References: <s5hk41ufe2j.wl%tiwai@suse.de>
 <1333719260-14504-1-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1333719260-14504-1-git-send-email-kernel@mkarcher.dialup.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ID used for detection of the BenQ R55E actually identifies the
Quanta TW3 ODM design, which is also used for the Gigabyte W551 laptop
series. Schematics on the internet clearly indicate that the "Port C"
(analog input connected to record source #4 and mixer input #4) is
unconnected.

Playing an audio CD through analog playback (using cdplay from cdtools)
produces no sound, even with the mixer input labelled "CD" enabled, and
the volume control in the CD drive set to maximum. This indicates the
connection is really not present.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 sound/pci/hda/patch_conexant.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c36441c..ad5da16 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -692,9 +692,8 @@ static const struct hda_input_mux cxt5045_capture_source = {
 };
 
 static const struct hda_input_mux cxt5045_capture_source_benq = {
-	.num_items = 5,
+	.num_items = 4,
 	.items = {
-		{ "CD",           0x4 },
 		{ "Internal Mic", 0x1 },
 		{ "Mic",          0x2 },
 		{ "Line",         0x3 },
@@ -819,9 +818,6 @@ static const struct snd_kcontrol_new cxt5045_mixers[] = {
 };
 
 static const struct snd_kcontrol_new cxt5045_benq_mixers[] = {
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x17, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x17, 0x4, HDA_INPUT),
-
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x17, 0x3, HDA_INPUT),
 
-- 
1.7.9.1
