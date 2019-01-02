From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb-audio: Check mixer unit
	descriptors more strictly
Date: Wed,  2 Jan 2019 17:31:26 +0100
Message-ID: <20190102163126.5639-2-tiwai@suse.de>
References: <20190102163126.5639-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DFA82679EF
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 17:31:30 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DCBF2AEB7
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 16:31:28 +0000 (UTC)
In-Reply-To: <20190102163126.5639-1-tiwai@suse.de>
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

We've had some sanity checks of the mixer unit descriptors but they
are too loose and some corner cases are overlooked.  Add more strict
checks in uac_mixer_unit_get_channels() for avoiding possible OOB
accesses by malformed descriptors.

This also changes the semantics of uac_mixer_unit_get_channels()
slightly.  Now it returns zero for the cases where the descriptor
lacks of bmControls instead of -EINVAL.  Then the caller side skips
the mixer creation for such unit while it keeps parsing it.
This corresponds to the case like Maya44.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 0131de348cf6..dfd918891e69 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -753,8 +753,9 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 				       struct uac_mixer_unit_descriptor *desc)
 {
 	int mu_channels;
+	void *c;
 
-	if (desc->bLength < 11)
+	if (desc->bLength < sizeof(*desc))
 		return -EINVAL;
 	if (!desc->bNrInPins)
 		return -EINVAL;
@@ -763,6 +764,8 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 	case UAC_VERSION_1:
 	case UAC_VERSION_2:
 	default:
+		if (desc->bLength < sizeof(*desc) + desc->bNrInPins + 1)
+			return 0; /* no bmControls -> skip */
 		mu_channels = uac_mixer_unit_bNrChannels(desc);
 		break;
 	case UAC_VERSION_3:
@@ -772,7 +775,11 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 	}
 
 	if (!mu_channels)
-		return -EINVAL;
+		return 0;
+
+	c = uac_mixer_unit_bmControls(desc, state->mixer->protocol);
+	if (c - (void *)desc + (mu_channels - 1) / 8 >= desc->bLength)
+		return 0; /* no bmControls -> skip */
 
 	return mu_channels;
 }
@@ -944,7 +951,7 @@ static int check_input_term(struct mixer_build *state, int id,
 				struct uac_mixer_unit_descriptor *d = p1;
 
 				err = uac_mixer_unit_get_channels(state, d);
-				if (err < 0)
+				if (err <= 0)
 					return err;
 
 				term->channels = err;
@@ -2118,7 +2125,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 		if (err < 0)
 			continue;
 		/* no bmControls field (e.g. Maya44) -> ignore */
-		if (desc->bLength <= 10 + input_pins)
+		if (!num_outs)
 			continue;
 		err = check_input_term(state, desc->baSourceID[pin], &iterm);
 		if (err < 0)
-- 
2.19.2
