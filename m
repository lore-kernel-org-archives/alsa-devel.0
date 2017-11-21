From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: usb-audio: Add sanity checks to FE
	parser
Date: Tue, 21 Nov 2017 17:33:51 +0100
Message-ID: <20171121163354.2665-2-tiwai@suse.de>
References: <20171121163354.2665-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2FE26768C
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 17:33:58 +0100 (CET)
In-Reply-To: <20171121163354.2665-1-tiwai@suse.de>
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
Cc: Andrey Konovalov <andreyknvl@google.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: alsa-devel@alsa-project.org

When the usb-audio descriptor contains the malformed feature unit
description with a too short length, the driver may access
out-of-bounds.  Add a sanity check of the header size at the beginning
of parse_audio_feature_unit().

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 1beb5b4d027e..b8ce651e392c 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1469,6 +1469,12 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 	__u8 *bmaControls;
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
+		if (hdr->bLength < 7) {
+			usb_audio_err(state->chip,
+				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				      unitid);
+			return -EINVAL;
+		}
 		csize = hdr->bControlSize;
 		if (!csize) {
 			usb_audio_dbg(state->chip,
@@ -1486,6 +1492,12 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		}
 	} else {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;
+		if (hdr->bLength < 6) {
+			usb_audio_err(state->chip,
+				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				      unitid);
+			return -EINVAL;
+		}
 		csize = 4;
 		channels = (hdr->bLength - 6) / 4 - 1;
 		bmaControls = ftr->bmaControls;
-- 
2.15.0
