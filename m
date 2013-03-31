From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 07/10] ALSA: usb-audio: UAC2: try to find and
	switch to valid clock
Date: Sun, 31 Mar 2013 17:52:29 +0200
Message-ID: <1364745152-1762-8-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBA42617AF
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:22 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so658436bkc.6
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:22 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

If a selector is available on a device, it may be pointing to a
clock source which is currently invalid.
If there is a valid clock source which can be selected, switch
to it.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 08fa345..6b79e25 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -99,6 +99,40 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i
 	return buf;
 }
 
+static int uac_clock_selector_set_val(struct snd_usb_audio *chip, int selector_id,
+					unsigned char pin)
+{
+	unsigned char buf;
+	int ret;
+
+	ret = snd_usb_ctl_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+			      UAC2_CS_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			      UAC2_CX_CLOCK_SELECTOR << 8,
+			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
+			      &pin, sizeof(pin));
+
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
+	buf = uac_clock_selector_get_val(chip, selector_id);
+	if (buf != pin) {
+		snd_printk(KERN_ERR
+			"usb-audio:%d: setting selector (id %d) failed (wanted %x, got %x)\n",
+			chip->dev->devnum, selector_id, pin, buf);
+		return -EINVAL;
+	}
+
+	return buf;
+}
+
 static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 {
 	int err;
@@ -161,7 +195,7 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 
 	selector = snd_usb_find_clock_selector(chip->ctrl_intf, entity_id);
 	if (selector) {
-		int ret;
+		int ret, i, cur;
 
 		/* the entity ID we are looking for is a selector.
 		 * find out what it currently selects */
@@ -179,8 +213,35 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
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
-- 
1.8.1.5
