From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: usb-audio: Avoid access before
	bLength check in build_audio_procunit()
Date: Wed,  2 Jan 2019 17:31:25 +0100
Message-ID: <20190102163126.5639-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 60AB4267B32
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 17:31:30 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D7620AEB4
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 16:31:28 +0000 (UTC)
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

The parser for the processing unit reads bNrInPins field before the
bLength sanity check, which may lead to an out-of-bound access when a
malformed descriptor is given.  Fix it by assignment after the bLength
check.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c63c84b54969..0131de348cf6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2314,7 +2314,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 				char *name)
 {
 	struct uac_processing_unit_descriptor *desc = raw_desc;
-	int num_ins = desc->bNrInPins;
+	int num_ins;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
 	int i, err, nameid, type, len;
@@ -2329,7 +2329,13 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 		0, NULL, default_value_info
 	};
 
-	if (desc->bLength < 13 || desc->bLength < 13 + num_ins ||
+	if (desc->bLength < 13) {
+		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
+		return -EINVAL;
+	}
+
+	num_ins = desc->bNrInPins;
+	if (desc->bLength < 13 + num_ins ||
 	    desc->bLength < num_ins + uac_processing_unit_bControlSize(desc, state->mixer->protocol)) {
 		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
 		return -EINVAL;
-- 
2.19.2
