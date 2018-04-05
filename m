From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 3/3] ALSA: usb-audio: Add sanity checks in
	UAC3 clock parsers
Date: Thu,  5 Apr 2018 14:11:13 +0200
Message-ID: <20180405121113.551-4-tiwai@suse.de>
References: <20180405121113.551-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A897C26767C
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 14:11:15 +0200 (CEST)
In-Reply-To: <20180405121113.551-1-tiwai@suse.de>
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

The UAC3 clock parser codes lack of the sanity checks for malformed
descriptors like UAC2 parser does.  Without it, the driver may lead to
a potential crash.

Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index cbf68ab01836..29b7c85635e3 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -58,7 +58,7 @@ static bool validate_clock_source_v2(void *p, int id)
 static bool validate_clock_source_v3(void *p, int id)
 {
 	struct uac3_clock_source_descriptor *cs = p;
-	return cs->bClockID == id;
+	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
 }
 
 static bool validate_clock_selector_v2(void *p, int id)
@@ -71,7 +71,8 @@ static bool validate_clock_selector_v2(void *p, int id)
 static bool validate_clock_selector_v3(void *p, int id)
 {
 	struct uac3_clock_selector_descriptor *cs = p;
-	return cs->bClockID == id;
+	return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
+		cs->bLength == 11 + cs->bNrInPins;
 }
 
 static bool validate_clock_multiplier_v2(void *p, int id)
@@ -83,7 +84,7 @@ static bool validate_clock_multiplier_v2(void *p, int id)
 static bool validate_clock_multiplier_v3(void *p, int id)
 {
 	struct uac3_clock_multiplier_descriptor *cs = p;
-	return cs->bClockID == id;
+	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
 }
 
 #define DEFINE_FIND_HELPER(name, obj, validator, type)		\
-- 
2.16.2
