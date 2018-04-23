From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix missing endian conversion
Date: Mon, 23 Apr 2018 15:24:04 +0200
Message-ID: <20180423132404.12633-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 90B4C266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 15:24:08 +0200 (CEST)
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
Cc: Andrew Chant <achant@google.com>
List-Id: alsa-devel@alsa-project.org

The UAC2 jack detection support introduced the bmControls checks in a
couple of places, but they forgot the endian conversion; the
bmControls of UAC2 terminal descriptor is __le16, not a byte like in
UAC1.

Fixes: 5a222e849452 ("ALSA: usb-audio: UAC2 jack detection")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61ed426..f78b500b3c0e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1859,7 +1859,7 @@ static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
 	check_input_term(state, d->bTerminalID, &iterm);
 	if (state->mixer->protocol == UAC_VERSION_2) {
 		/* Check for jack detection. */
-		if (uac_v2v3_control_is_readable(d->bmControls,
+		if (uac_v2v3_control_is_readable(le16_to_cpu(d->bmControls),
 						 UAC2_TE_CONNECTOR)) {
 			build_connector_control(state, &iterm, true);
 		}
@@ -2561,7 +2561,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 			if (err < 0 && err != -EINVAL)
 				return err;
 
-			if (uac_v2v3_control_is_readable(desc->bmControls,
+			if (uac_v2v3_control_is_readable(le16_to_cpu(desc->bmControls),
 							 UAC2_TE_CONNECTOR)) {
 				build_connector_control(&state, &state.oterm,
 							false);
-- 
2.16.3
