From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - avoid non-standard "Docking" name
	in mixers
Date: Wed, 19 Sep 2012 12:19:47 +0200
Message-ID: <1348049987-6150-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EC582262626
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 12:19:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The standard name (and what PulseAudio picks up) is "Dock Mic",
not "Docking Mic" or "Docking-Station".

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_analog.c   |   14 +++++++-------
 sound/pci/hda/patch_conexant.c |    4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 1a82cce..cdd43ea 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1810,7 +1810,7 @@ static const struct hda_input_mux ad1981_hp_capture_source = {
 	.num_items = 3,
 	.items = {
 		{ "Mic", 0x0 },
-		{ "Docking-Station", 0x1 },
+		{ "Dock Mic", 0x1 },
 		{ "Mix", 0x2 },
 	},
 };
@@ -1834,8 +1834,8 @@ static const struct snd_kcontrol_new ad1981_hp_mixers[] = {
 	 */
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x12, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME("Docking-Station Playback Volume", 0x13, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Docking-Station Playback Switch", 0x13, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x13, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x13, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x1c, 0x0, HDA_OUTPUT),
 	/* FIXME: does this laptop have analog CD connection? */
@@ -3565,7 +3565,7 @@ static const struct hda_amp_list ad1884_loopbacks[] = {
 
 static const char * const ad1884_slave_vols[] = {
 	"PCM", "Mic", "Mono", "Front Mic", "Mic", "CD",
-	"Internal Mic", "Docking Mic", /* "Beep", */ "IEC958",
+	"Internal Mic", "Dock Mic", /* "Beep", */ "IEC958",
 	NULL
 };
 
@@ -3626,7 +3626,7 @@ static const struct hda_input_mux ad1984_thinkpad_capture_source = {
 		{ "Mic", 0x0 },
 		{ "Internal Mic", 0x1 },
 		{ "Mix", 0x3 },
-		{ "Docking-Station", 0x4 },
+		{ "Dock Mic", 0x4 },
 	},
 };
 
@@ -3655,8 +3655,8 @@ static const struct snd_kcontrol_new ad1984_thinkpad_mixers[] = {
 	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x20, 0x01, HDA_INPUT),
 	HDA_CODEC_VOLUME("Beep Playback Volume", 0x20, 0x03, HDA_INPUT),
 	HDA_CODEC_MUTE("Beep Playback Switch", 0x20, 0x03, HDA_INPUT),
-	HDA_CODEC_VOLUME("Docking Mic Playback Volume", 0x20, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("Docking Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Playback Volume", 0x20, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("Dock Mic Playback Switch", 0x20, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost Volume", 0x14, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Boost Volume", 0x15, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Dock Mic Boost Volume", 0x25, 0x0, HDA_OUTPUT),
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7d70210..b871b013 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1710,8 +1710,8 @@ static const struct snd_kcontrol_new cxt5051_capture_mixers[] = {
 	HDA_CODEC_MUTE("Internal Mic Switch", 0x14, 0x00, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Docking Mic Volume", 0x15, 0x00, HDA_INPUT),
-	HDA_CODEC_MUTE("Docking Mic Switch", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Dock Mic Volume", 0x15, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Dock Mic Switch", 0x15, 0x00, HDA_INPUT),
 	{}
 };
 
-- 
1.7.9.5
