From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 07/10] ALSA: usb-audio: UAC2: try to find and
	switch to valid clock
Date: Wed,  3 Apr 2013 23:18:55 +0200
Message-ID: <1365023938-1461-8-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C20265E0C
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:29 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so1100903bku.26
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:29 -0700 (PDT)
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

If a selector is available on a device, it may be pointing to a
clock source which is currently invalid.
If there is a valid clock source which can be selected, switch
to it.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 0c98f52..d7ab2d7 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -99,6 +99,41 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i
 	return buf;
 }
 
+static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_id,
+					unsigned char pin)
+{
+	int ret;
+
+	ret = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+			      UAC2_CS_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			      UAC2_CX_CLOCK_SELECTOR << 8,
+			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      &pin, sizeof(pin));
+	if (ret < 0)
+		return ret;
+
+	if (ret != sizeof(pin)) {
+		snd_printk(KERN_ERR
+			"usb-audio:%d: setting selector (id %d) unexpected length %d\n",
+			chip->dev->devnum, selector_id, ret);
+		return -EINVAL;
+	}
+
+	ret = uac_clock_selector_get_val(chip, selector_id);
+	if (ret < 0)
+		return ret;
+
+	if (ret != pin) {
+		snd_printk(KERN_ERR
+			"usb-audio:%d: setting selector (id %d) to %x failed (current: %d)\n",
+			chip->dev->devnum, selector_id, pin, ret);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 {
 	int err;
@@ -161,7 +196,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 	selector = snd_usb_find_clock_selector(chip->ctrl_intf, entity_id);
 	if (selector) {
-		int ret;
+		int ret, i, cur;
 
 		/* the entity ID we are looking for is a selector.
 		 * find out what it currently selects */
@@ -179,8 +214,35 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			return -EINVAL;
 		}
 
-		return __uac_clock_find_source(chip, selector->baCSourceID[ret-1],
+		cur = ret;
+		ret = __uac_clock_find_source(chip, selector->baCSourceID[ret - 1],
 					       visited, validate);
+		if (!validate || ret > 0)
+			return ret;
+
+		/* The current clock source is invalid, try others. */
+		for (i = 1; i <= selector->bNrInPins; i++) {
+			int err;
+
+			if (i == cur)
+				continue;
+
+			ret = __uac_clock_find_source(chip, selector->baCSourceID[i - 1],
+				visited, true);
+			if (ret < 0)
+				continue;
+
+			err = uac_clock_selector_set_val(chip, entity_id, i);
+			if (err < 0)
+				continue;
+
+			snd_printk(KERN_INFO
+				"usb-audio:%d: found and selected valid clock source %d\n",
+				chip->dev->devnum, ret);
+			return ret;
+		}
+
+		return -ENXIO;
 	}
 
 	/* FIXME: multipliers only act as pass-thru element for now */
@@ -284,8 +346,9 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	__le32 data;
 	int err, cur_rate, prev_rate;
-	int clock = snd_usb_clock_find_source(chip, fmt->clock, true);
+	int clock;
 
+	clock = snd_usb_clock_find_source(chip, fmt->clock, true);
 	if (clock < 0)
 		return clock;
 
-- 
1.8.1.5
