From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Check mixer unit bitmap yet
	more strictly
Date: Thu, 22 Aug 2019 09:14:51 +0200
Message-ID: <20190822071451.6809-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EFC5F80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 09:14:53 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BFB9DABCB
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 07:14:52 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The bmControls (for UAC1) or bmMixerControls (for UAC2/3) bitmap has a
variable size depending on both input and output pins.  Its size is to
fit with input * output bits.  The problem is that the input size
can't be determined simply from the unit descriptor itself but it
needs to parse the whole connected sources.  Although the
uac_mixer_unit_get_channels() tries to check some possible overflow of
this bitmap, it's incomplete due to the lack of the  evaluation of
input pins.

For covering possible overflows, this patch adds the bitmap overflow
check in the loop of input pins in parse_audio_mixer_unit().

Fixes: 0bfe5e434e66 ("ALSA: usb-audio: Check mixer unit descriptors more strictly")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b5927c3d5bc0..27ee68a507a2 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -739,7 +739,6 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 				       struct uac_mixer_unit_descriptor *desc)
 {
 	int mu_channels;
-	void *c;
 
 	if (desc->bLength < sizeof(*desc))
 		return -EINVAL;
@@ -762,13 +761,6 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 		break;
 	}
 
-	if (!mu_channels)
-		return 0;
-
-	c = uac_mixer_unit_bmControls(desc, state->mixer->protocol);
-	if (c - (void *)desc + (mu_channels - 1) / 8 >= desc->bLength)
-		return 0; /* no bmControls -> skip */
-
 	return mu_channels;
 }
 
@@ -2009,6 +2001,29 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
  * Mixer Unit
  */
 
+/* check whether the given in/out overflows bmMixerControls matrix */
+static bool mixer_bitmap_overflow(struct uac_mixer_unit_descriptor *desc,
+				  int protocol, int num_ins, int num_outs)
+{
+	u8 *hdr = (u8 *)desc;
+	u8 *c = uac_mixer_unit_bmControls(desc, protocol);
+	size_t rest; /* remaining bytes after bmMixerControls */
+
+	switch (protocol) {
+	case UAC_VERSION_1:
+	default:
+		rest = 1; /* iMixer */
+	case UAC_VERSION_2:
+		rest = 2; /* bmControls + iMixer */
+	case UAC_VERSION_3:
+		rest = 6; /* bmControls + wMixerDescrStr */
+		break;
+	}
+
+	/* overflow? */
+	return c + (num_ins * num_outs + 7) / 8 + rest > hdr + hdr[0];
+}
+
 /*
  * build a mixer unit control
  *
@@ -2137,6 +2152,9 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 		if (err < 0)
 			return err;
 		num_ins += iterm.channels;
+		if (mixer_bitmap_overflow(desc, state->mixer->protocol,
+					  num_ins, num_outs))
+			break;
 		for (; ich < num_ins; ich++) {
 			int och, ich_has_controls = 0;
 
-- 
2.16.4
