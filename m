From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: usb-audio: Add sanity checks in v2
	clock parsers
Date: Tue, 21 Nov 2017 17:33:54 +0100
Message-ID: <20171121163354.2665-5-tiwai@suse.de>
References: <20171121163354.2665-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D40C26768D
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

The helper functions to parse and look for the clock source, selector
and multiplier unit may return the descriptor with a too short length
than required, while there is no sanity check in the caller side.
Add some sanity checks in the parsers, at least, to guarantee the
given descriptor size, for avoiding the potential crashes.

Fixes: 79f920fbff56 ("ALSA: usb-audio: parse clock topology of UAC2 devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 26dd5f20f149..eb3396ffba4c 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -43,7 +43,7 @@ static struct uac_clock_source_descriptor *
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SOURCE))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
 			return cs;
 	}
 
@@ -59,8 +59,11 @@ static struct uac_clock_selector_descriptor *
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SELECTOR))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id) {
+			if (cs->bLength < 5 + cs->bNrInPins)
+				return NULL;
 			return cs;
+		}
 	}
 
 	return NULL;
@@ -75,7 +78,7 @@ static struct uac_clock_multiplier_descriptor *
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_MULTIPLIER))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
 			return cs;
 	}
 
-- 
2.15.0
