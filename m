From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/3] ALSA: usb-audio: More strict sanity
	checks for clock parsers
Date: Wed,  4 Apr 2018 07:36:20 +0200
Message-ID: <20180404053621.32539-3-tiwai@suse.de>
References: <20180404053621.32539-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B28F326762E
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 07:36:23 +0200 (CEST)
In-Reply-To: <20180404053621.32539-1-tiwai@suse.de>
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
Cc: Andrew Chant <achant@google.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
List-Id: alsa-devel@alsa-project.org

The sanity checks introduced for malformed descriptors loosely check
the given descriptor size, although the size greater than the defined
description is invalid.  It was due to a concern of any funky firmware
in the actual products.  But this doesn't look hitting, and any sane
products must have the defined descriptors.

So in this patch, we make the validators more strict, allowing only
with the defined descriptor sizes.

Suggested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 27c2275a2505..5e533edfb092 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -52,7 +52,7 @@ static void *find_uac_clock_desc(struct usb_host_interface *iface, int id,
 static bool validate_clock_source_v2(void *p, int id)
 {
 	struct uac_clock_source_descriptor *cs = p;
-	return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
+	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
 }
 
 static bool validate_clock_source_v3(void *p, int id)
@@ -64,8 +64,8 @@ static bool validate_clock_source_v3(void *p, int id)
 static bool validate_clock_selector_v2(void *p, int id)
 {
 	struct uac_clock_selector_descriptor *cs = p;
-	return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
-		cs->bLength >= 5 + cs->bNrInPins;
+	return cs->bLength == sizeof(*cs) && cs->bClockID == id &&
+		cs->bLength == 5 + cs->bNrInPins;
 }
 
 static bool validate_clock_selector_v3(void *p, int id)
@@ -77,7 +77,7 @@ static bool validate_clock_selector_v3(void *p, int id)
 static bool validate_clock_multiplier_v2(void *p, int id)
 {
 	struct uac_clock_multiplier_descriptor *cs = p;
-	return cs->bLength >= sizeof(*cs) && cs->bClockID == id;
+	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
 }
 
 static bool validate_clock_multiplier_v3(void *p, int id)
-- 
2.16.2
