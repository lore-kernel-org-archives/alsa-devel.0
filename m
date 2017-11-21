From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: usb-audio: Fix potential
	out-of-bound access at parsing SU
Date: Tue, 21 Nov 2017 17:33:52 +0100
Message-ID: <20171121163354.2665-3-tiwai@suse.de>
References: <20171121163354.2665-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A9F426768B
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

The usb-audio driver may trigger an out-of-bound access at parsing a
malformed selector unit, as it checks the header length only after
evaluating bNrInPins field, which can be already above the given
length.  Fix it by adding the length check beforehand.

Fixes: 99fc86450c43 ("ALSA: usb-mixer: parse descriptors with structs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b8ce651e392c..61b348383de8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2098,7 +2098,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	const struct usbmix_name_map *map;
 	char **namelist;
 
-	if (!desc->bNrInPins || desc->bLength < 5 + desc->bNrInPins) {
+	if (desc->bLength < 5 || !desc->bNrInPins ||
+	    desc->bLength < 5 + desc->bNrInPins) {
 		usb_audio_err(state->chip,
 			"invalid SELECTOR UNIT descriptor %d\n", unitid);
 		return -EINVAL;
-- 
2.15.0
