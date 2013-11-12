From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix Line Out automute on Realtek multifunction jacks
Date: Tue, 12 Nov 2013 11:10:57 +0100
Message-ID: <1384251057-778-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1250377@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, "3.10+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In case there is both a multifunction headset jack and a Line Out
jack, automuting was not working properly from the Line Out jack.
This patch fixes that issue.

Cc: stable@vger.kernel.org (3.10+)
BugLink: https://bugs.launchpad.net/bugs/1250377
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 24d924d..04d1e6b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3344,8 +3344,10 @@ static void alc_update_headset_mode(struct hda_codec *codec)
 	else
 		new_headset_mode = ALC_HEADSET_MODE_HEADPHONE;
 
-	if (new_headset_mode == spec->current_headset_mode)
+	if (new_headset_mode == spec->current_headset_mode) {
+		snd_hda_gen_update_outputs(codec);
 		return;
+	}
 
 	switch (new_headset_mode) {
 	case ALC_HEADSET_MODE_UNPLUGGED:
-- 
1.7.9.5
