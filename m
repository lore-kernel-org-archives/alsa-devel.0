From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 3/3] ALSA: usb-audio: Add check return value for usb_string()
Date: Tue, 28 Nov 2017 09:36:28 +0900
Message-ID: <1511829388-5245-4-git-send-email-climbbb.kim@gmail.com>
References: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_usb_copy_string_desc() returns a negative number if usb_string() fails.
In case of failure, we need to check the snd_usb_copy_string_desc()'s
return value and add an exception case

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 sound/usb/mixer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 8a434b7..3501eb5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2162,13 +2162,14 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	if (len)
 		;
 	else if (nameid)
-		snd_usb_copy_string_desc(state, nameid, kctl->id.name,
-					 sizeof(kctl->id.name));
-	else {
+		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
+					       sizeof(kctl->id.name));
+	else
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-		if (len <= 0)
-			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+
+	if (len <= 0) {
+		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
@@ -2177,7 +2178,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 		else
 			append_ctl_name(kctl, " Playback Source");
 	}
-
 	usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
 		    cval->head.id, kctl->id.name, desc->bNrInPins);
 	return snd_usb_mixer_add_control(&cval->head, kctl);
-- 
2.7.4
