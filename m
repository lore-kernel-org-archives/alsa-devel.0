From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: usb - Don't create "Speaker" mixer
	controls on headphones and headsets
Date: Fri, 23 Nov 2012 13:48:55 +0100
Message-ID: <1353674935-4215-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 65A3A261647
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 13:48:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, zonque@gmail.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

A lot of headsets/headphones have a "Speaker" mixer control. This confuses
PulseAudio to think it is a speaker instead of a headphone/headset.
Therfore, we rename it to "Headphone".

We determine if something is a headphone similar to how udev determines
form factor (see 78-sound-card.rules).

BugLink: https://bugs.launchpad.net/bugs/1082357
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/mixer.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

I tried to find a better way of doing this using the existing quirk or
map infrastructure but it didn't seem to fit, so added a new
explicit check.


diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 298070e..63fd758 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1094,6 +1094,32 @@ static size_t append_ctl_name(struct snd_kcontrol *kctl, const char *str)
 	return strlcat(kctl->id.name, str, sizeof(kctl->id.name));
 }
 
+/* A lot of headsets/headphones have a "Speaker" mixer. Make sure we
+   rename it to "Headphone". We determine if something is a headphone
+   similar to how udev determines form factor. */
+static void check_no_speaker_on_headset(struct snd_kcontrol *kctl,
+					struct snd_card *card)
+{
+	const char *names_to_check[] = {
+		"Headset", "headset", "Headphone", "headphone", NULL};
+	const char **s;
+	bool found = 0;
+
+	if (strcmp("Speaker", kctl->id.name))
+		return;
+
+	for (s = names_to_check; *s; s++)
+		if (strstr(card->shortname, *s)) {
+			found = 1;
+			break;
+		}
+
+	if (!found)
+		return;
+
+	strlcpy(kctl->id.name, "Headphone", sizeof(kctl->id.name));
+}
+
 static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 			      unsigned int ctl_mask, int control,
 			      struct usb_audio_term *iterm, int unitid,
@@ -1180,6 +1206,10 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 				len = snprintf(kctl->id.name, sizeof(kctl->id.name),
 					       "Feature %d", unitid);
 		}
+
+		if (!mapped_name)
+			check_no_speaker_on_headset(kctl, state->mixer->chip->card);
+
 		/* determine the stream direction:
 		 * if the connected output is USB stream, then it's likely a
 		 * capture stream.  otherwise it should be playback (hopefully :)
-- 
1.7.9.5
