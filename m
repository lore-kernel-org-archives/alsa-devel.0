From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, v2, RFC 1/8] usb-audio: skip UAC2 EFFECT_UNIT
Date: Tue,  6 Nov 2012 01:30:32 +0100
Message-ID: <1352161839-1455-2-git-send-email-eldad@fogrefinery.com>
References: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B76BB261672
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 01:33:15 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2096111bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 16:33:15 -0800 (PST)
In-Reply-To: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Current code mishandles the case where the device is a UAC2
and the bDescriptorSubtype is a UAC2 Effect Unit (0x07).
It tries to parse it as a Processing Unit (which is similar to two
other UAC1 units with overlapping subtypes), but since the structure
is different (See: 4.7.2.10, 4.7.2.11 in UAC2 standard), the parsing
is done incorrectly and prevents the device from initializing.
For now, just ignore the unit.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 298070e..9bbc981 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -719,8 +719,17 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 			return 0;
 		}
 		case UAC1_PROCESSING_UNIT:
-		case UAC1_EXTENSION_UNIT: {
+		case UAC1_EXTENSION_UNIT:
+		/* UAC2_PROCESSING_UNIT_V2 */
+		/* UAC2_EFFECT_UNIT */ {
 			struct uac_processing_unit_descriptor *d = p1;
+
+			if (state->mixer->protocol == UAC_VERSION_2 &&
+				hdr[2] == UAC2_EFFECT_UNIT) {
+				/* Differnt structure. Ignore this unit for now */
+				return 0;
+			}
+
 			if (d->bNrInPins) {
 				id = d->baSourceID[0];
 				break; /* continue to parse */
-- 
1.7.8.6
