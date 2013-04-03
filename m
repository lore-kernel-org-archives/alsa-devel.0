From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 10/10] ALSA: usb-audio: UAC2: support
	read-only freq control
Date: Wed,  3 Apr 2013 23:18:58 +0200
Message-ID: <1365023938-1461-11-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 063A1265E31
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:39 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id i18so1102260bkv.14
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:39 -0700 (PDT)
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

Some clocks might be read-only, e.g., external clocks (see also
UAC2 4.7.2.1).

In this case, setting the sample frequency will always fail
(even if the rate is equal to the current clock rate),
therefore do not write, but read the value and compare to the
requested rate.
If the clock is read only, avoid reading it twice.

If it doesn't match, return -ENXIO since the clock is invalid for
this configuration.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index a694e1c..ae35e7d 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -347,6 +347,8 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	__le32 data;
 	int err, cur_rate, prev_rate;
 	int clock;
+	bool writeable;
+	struct uac_clock_source_descriptor *cs_desc;
 
 	clock = snd_usb_clock_find_source(chip, fmt->clock, true);
 	if (clock < 0)
@@ -354,20 +356,33 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 
 	prev_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
 
-	data = cpu_to_le32(rate);
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8,
-				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   &data, sizeof(data))) < 0) {
-		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2): err %d\n",
-			   dev->devnum, iface, fmt->altsetting, rate, err);
-		return err;
-	}
+	cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+	writeable = uac2_control_is_writeable(cs_desc->bmControls, UAC2_CS_CONTROL_SAM_FREQ - 1);
+	if (writeable) {
+		data = cpu_to_le32(rate);
+		err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+				      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+				      UAC2_CS_CONTROL_SAM_FREQ << 8,
+				      snd_usb_ctrl_intf(chip) | (clock << 8),
+				      &data, sizeof(data));
+		if (err < 0) {
+			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2): err %d\n",
+				   dev->devnum, iface, fmt->altsetting, rate, err);
+			return err;
+		}
 
-	cur_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
+		cur_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
+	} else {
+		cur_rate = prev_rate;
+	}
 
 	if (cur_rate != rate) {
+		if (!writeable) {
+			snd_printk(KERN_WARNING
+				   "%d:%d:%d: freq mismatch (RO clock): req %d, clock runs @%d\n",
+				   dev->devnum, iface, fmt->altsetting, rate, cur_rate);
+			return -ENXIO;
+		}
 		snd_printd(KERN_WARNING
 			   "current rate %d is different from the runtime rate %d\n",
 			   cur_rate, rate);
-- 
1.8.1.5
