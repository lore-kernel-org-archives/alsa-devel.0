From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ALSA: snd-usb: mixer: propagate errors up
	the call chain
Date: Tue, 19 Mar 2013 21:09:24 +0100
Message-ID: <1363723765-9197-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5B12615DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 21:09:32 +0100 (CET)
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
Cc: tiwai@suse.de, hegge@resisty.net, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In check_input_term() and parse_audio_feature_unit(), propagate the
error value that has been returned by a failing function instead of
-EINVAL. That helps cleaning up the error pathes in the mixer.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/mixer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 638e7f7..db30d02 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -715,8 +715,9 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 		case UAC2_CLOCK_SELECTOR: {
 			struct uac_selector_unit_descriptor *d = p1;
 			/* call recursively to retrieve the channel info */
-			if (check_input_term(state, d->baSourceID[0], term) < 0)
-				return -ENODEV;
+			err = check_input_term(state, d->baSourceID[0], term);
+			if (err < 0)
+				return err;
 			term->type = d->bDescriptorSubtype << 16; /* virtual type */
 			term->id = id;
 			term->name = uac_selector_unit_iSelector(d);
@@ -1356,8 +1357,9 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		return err;
 
 	/* determine the input source type and name */
-	if (check_input_term(state, hdr->bSourceID, &iterm) < 0)
-		return -EINVAL;
+	err = check_input_term(state, hdr->bSourceID, &iterm);
+	if (err < 0)
+		return err;
 
 	master_bits = snd_usb_combine_bytes(bmaControls, csize);
 	/* master configuration quirks */
-- 
1.8.1.4
