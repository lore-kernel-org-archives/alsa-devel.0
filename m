From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 06/10] ALSA: usb-audio: UAC2: do clock
	validity check earlier
Date: Wed,  3 Apr 2013 23:18:54 +0200
Message-ID: <1365023938-1461-7-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6055A265E20
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:25 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id jk13so1099509bkc.3
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:25 -0700 (PDT)
In-Reply-To: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Move the check that parse_audio_format_rates_v2() do after
receiving the clock source entity ID directly into the find
function and add a validation flag to the function.

This patch does not introduce any logic flow change.

It is provided to allow introducing automatic clock switching
easier later. By moving this uac_clock_source_is_valid callsite,
2 additional callsites can be avoided.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c  | 34 ++++++++++++++++++----------------
 sound/usb/clock.h  |  3 ++-
 sound/usb/format.c |  2 +-
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 013b346..0c98f52 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -131,7 +131,8 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip,
-				   int entity_id, unsigned long *visited)
+				   int entity_id, unsigned long *visited,
+				   bool validate)
 {
 	struct uac_clock_source_descriptor *source;
 	struct uac_clock_selector_descriptor *selector;
@@ -148,8 +149,15 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 	/* first, see if the ID we're looking for is a clock source already */
 	source = snd_usb_find_clock_source(chip->ctrl_intf, entity_id);
-	if (source)
-		return source->bClockID;
+	if (source) {
+		entity_id = source->bClockID;
+		if (validate && !uac_clock_source_is_valid(chip, entity_id)) {
+			snd_printk(KERN_ERR "usb-audio:%d: clock source %d is not valid, cannot use\n",
+				   chip->dev->devnum, entity_id);
+			return -ENXIO;
+		}
+		return entity_id;
+	}
 
 	selector = snd_usb_find_clock_selector(chip->ctrl_intf, entity_id);
 	if (selector) {
@@ -164,7 +172,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		/* Selector values are one-based */
 
 		if (ret > selector->bNrInPins || ret < 1) {
-			printk(KERN_ERR
+			snd_printk(KERN_ERR
 				"%s(): selector reported illegal value, id %d, ret %d\n",
 				__func__, selector->bClockID, ret);
 
@@ -172,14 +180,14 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		}
 
 		return __uac_clock_find_source(chip, selector->baCSourceID[ret-1],
-					       visited);
+					       visited, validate);
 	}
 
 	/* FIXME: multipliers only act as pass-thru element for now */
 	multiplier = snd_usb_find_clock_multiplier(chip->ctrl_intf, entity_id);
 	if (multiplier)
 		return __uac_clock_find_source(chip, multiplier->bCSourceID,
-						visited);
+						visited, validate);
 
 	return -EINVAL;
 }
@@ -195,11 +203,12 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
  *
  * Returns the clock source UnitID (>=0) on success, or an error.
  */
-int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id)
+int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id,
+			      bool validate)
 {
 	DECLARE_BITMAP(visited, 256);
 	memset(visited, 0, sizeof(visited));
-	return __uac_clock_find_source(chip, entity_id, visited);
+	return __uac_clock_find_source(chip, entity_id, visited, validate);
 }
 
 static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
@@ -275,18 +284,11 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	__le32 data;
 	int err, cur_rate, prev_rate;
-	int clock = snd_usb_clock_find_source(chip, fmt->clock);
+	int clock = snd_usb_clock_find_source(chip, fmt->clock, true);
 
 	if (clock < 0)
 		return clock;
 
-	if (!uac_clock_source_is_valid(chip, clock)) {
-		/* TODO: should we try to find valid clock setups by ourself? */
-		snd_printk(KERN_ERR "%d:%d:%d: clock source %d is not valid, cannot use\n",
-			   dev->devnum, iface, fmt->altsetting, clock);
-		return -ENXIO;
-	}
-
 	prev_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
 
 	data = cpu_to_le32(rate);
diff --git a/sound/usb/clock.h b/sound/usb/clock.h
index 4663093..d592e4a 100644
--- a/sound/usb/clock.h
+++ b/sound/usb/clock.h
@@ -5,6 +5,7 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 			     struct usb_host_interface *alts,
 			     struct audioformat *fmt, int rate);
 
-int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id);
+int snd_usb_clock_find_source(struct snd_usb_audio *chip, int entity_id,
+			     bool validate);
 
 #endif /* __USBAUDIO_CLOCK_H */
diff --git a/sound/usb/format.c b/sound/usb/format.c
index a695caf..20c7751 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -280,7 +280,7 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
 	int nr_triplets, data_size, ret = 0;
-	int clock = snd_usb_clock_find_source(chip, fp->clock);
+	int clock = snd_usb_clock_find_source(chip, fp->clock, false);
 
 	if (clock < 0) {
 		snd_printk(KERN_ERR "%s(): unable to find clock source (clock %d)\n",
-- 
1.8.1.5
