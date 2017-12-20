From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Proper fallback at
	get_term_name()
Date: Wed, 20 Dec 2017 18:00:12 +0100
Message-ID: <20171220170012.13979-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C1AD92677EC
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 18:00:15 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B96ADAED1
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 17:00:14 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

get_term_name() calls snd_usb_copy_string_desc() for retrieving the
name when a specific ID (name field) is given.  When this returns an
error (zero), however, it simply returns as is.  This will end up in a
fixed name string in the caller side, which often is meaningless.

For giving a bit more useful name string depending on the terminal
type, change the get_term_name() function to go through the fallback
mode.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2b4ceda36291..9afb8ab524c7 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 			 unsigned char *name, int maxlen, int term_only)
 {
 	struct iterm_name_combo *names;
+	int len;
 
-	if (iterm->name)
-		return snd_usb_copy_string_desc(state, iterm->name,
+	if (iterm->name) {
+		len = snd_usb_copy_string_desc(state, iterm->name,
 						name, maxlen);
+		if (len)
+			return len;
+	}
 
 	/* virtual type - not a real terminal */
 	if (iterm->type >> 16) {
-- 
2.15.1
