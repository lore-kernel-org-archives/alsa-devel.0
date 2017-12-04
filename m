From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH V2 2/2] ALSA: usb-audio: Add check return value for usb_string()
Date: Mon,  4 Dec 2017 15:31:49 +0900
Message-ID: <1512369109-23253-3-git-send-email-climbbb.kim@gmail.com>
References: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
 <1512369109-23253-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1512369109-23253-1-git-send-email-climbbb.kim@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: alsa-devel@alsa-project.org

snd_usb_copy_string_desc() returns zero if usb_string() fails.
In case of failure, we need to check the snd_usb_copy_string_desc()'s
return value and add an exception case

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---

Changes in V2:
 - change return value check.

 sound/usb/mixer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 3294e3a..84b9f9c 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2165,13 +2165,14 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	if (len)
 		;
 	else if (nameid)
-		snd_usb_copy_string_desc(state, nameid, kctl->id.name,
+		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
 					 sizeof(kctl->id.name));
-	else {
+	else
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-		if (!len)
-			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+
+	if (!len) {
+		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
-- 
2.7.4
