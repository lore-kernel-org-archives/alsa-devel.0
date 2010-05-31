From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 8/9] ALSA: usb-audio: clean up
	find_audio_control_unit()
Date: Mon, 31 May 2010 13:35:43 +0200
Message-ID: <1275305744-6590-8-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D5521038BF
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:36:12 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Use a struct to parse the audio units, and return usable descriptors
for all types. There's no need to limit the result set, except for some
kind of sanity check.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/mixer.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 8be6bf2..cb34536 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -165,22 +165,24 @@ static int check_mapped_selector_name(struct mixer_build *state, int unitid,
 
 /*
  * find an audio control unit with the given unit id
- * this doesn't return any clock related units, so they need to be handled elsewhere
  */
 static void *find_audio_control_unit(struct mixer_build *state, unsigned char unit)
 {
-	unsigned char *p;
+	/* we just parse the header */
+	struct uac_feature_unit_descriptor *hdr = NULL;
 
-	p = NULL;
-	while ((p = snd_usb_find_desc(state->buffer, state->buflen, p,
-				      USB_DT_CS_INTERFACE)) != NULL) {
-		if (p[0] >= 4 && p[2] >= UAC_INPUT_TERMINAL && p[2] <= UAC2_EXTENSION_UNIT_V2 && p[3] == unit)
-			return p;
+	while ((hdr = snd_usb_find_desc(state->buffer, state->buflen, hdr,
+					USB_DT_CS_INTERFACE)) != NULL) {
+		if (hdr->bLength >= 4 &&
+		    hdr->bDescriptorSubtype >= UAC_INPUT_TERMINAL &&
+		    hdr->bDescriptorSubtype <= UAC2_SAMPLE_RATE_CONVERTER &&
+		    hdr->bUnitID == unit)
+			return hdr;
 	}
+
 	return NULL;
 }
 
-
 /*
  * copy a string with the given id
  */
-- 
1.7.1
