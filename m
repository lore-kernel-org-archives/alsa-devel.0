From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 7/7] sound: Use kzalloc for allocating only one thing
Date: Sat, 19 Dec 2009 08:18:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0912190817460.30546@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752734AbZLSHSR@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/isa/msnd/msnd_midi.c    |    2 +-
 sound/pci/hda/patch_realtek.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/sound/isa/msnd/msnd_midi.c b/sound/isa/msnd/msnd_midi.c
--- a/sound/isa/msnd/msnd_midi.c 2009-03-28 23:34:55.000000000 +0100
+++ b/sound/isa/msnd/msnd_midi.c 2009-12-19 07:52:27.000000000 +0100
@@ -162,7 +162,7 @@ int snd_msndmidi_new(struct snd_card *ca
 	err = snd_rawmidi_new(card, "MSND-MIDI", device, 1, 1, &rmidi);
 	if (err < 0)
 		return err;
-	mpu = kcalloc(1, sizeof(*mpu), GFP_KERNEL);
+	mpu = kzalloc(sizeof(*mpu), GFP_KERNEL);
 	if (mpu == NULL) {
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
diff -u -p a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c 2009-12-17 08:30:15.000000000 +0100
+++ b/sound/pci/hda/patch_realtek.c 2009-12-19 07:52:50.000000000 +0100
@@ -12857,7 +12857,7 @@ static int patch_alc268(struct hda_codec
 	int board_config;
 	int i, has_beep, err;
 
-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
 
