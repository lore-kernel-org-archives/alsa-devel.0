From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] ALSA: usb-audio: Fix a memory leak bug
Date: Sat, 27 Apr 2019 01:06:46 -0500
Message-ID: <1556345208-1210-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In parse_audio_selector_unit(), the string array 'namelist' is allocated
through kmalloc_array(), and each string pointer in this array, i.e.,
'namelist[]', is allocated through kmalloc() in the following for loop.
Then, a control instance 'kctl' is created by invoking snd_ctl_new1(). If
an error occurs during the creation process, the string array 'namelist',
including all string pointers in the array 'namelist[]', should be freed,
before the error code ENOMEM is returned. However, the current code does
not free 'namelist[]', resulting in memory leaks.

To fix the above issue, free all string pointers 'namelist[]' in a loop.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/mixer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 73d7dff..53dccbf 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2675,6 +2675,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (! kctl) {
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		for (i = 0; i < desc->bNrInPins; i++)
+			kfree(namelist[i]);
 		kfree(namelist);
 		kfree(cval);
 		return -ENOMEM;
-- 
2.7.4
