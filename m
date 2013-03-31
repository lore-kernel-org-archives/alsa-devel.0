From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 10/10] ALSA: usb-audio: UAC2: support read-only
	freq control
Date: Sun, 31 Mar 2013 17:52:32 +0200
Message-ID: <1364745152-1762-11-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B062625E9
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:34 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id w12so678001bku.36
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:34 -0700 (PDT)
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

Some clocks might be read-only, e.g., external clocks (see also
UAC2 4.7.2.1).

In this case, setting the sample frequency will always fail
(even if the rate is equal to the current clock rate),
therefore do not write, but read the value and compare to the
requested rate.

If it doesn't match, return -ENXIO since the clock is invalid for
this configuration.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 1c0ec82..6ad9951 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -325,35 +325,50 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	u32 data;
 	int err, crate;
 	int clock;
+	bool writeable;
+	struct uac_clock_source_descriptor *cs_desc;
 
 	clock = snd_usb_clock_find_source(chip, fmt->clock, true);
 	if (clock < 0)
 		return clock;
 
-	data = cpu_to_le32(rate);
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8,
-				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   &data, sizeof(data))) < 0) {
-		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2): err %d\n",
-			   dev->devnum, iface, fmt->altsetting, rate, err);
-		return err;
+	cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+
+	writeable = uac2_control_is_writeable(cs_desc->bmControls, UAC2_CS_CONTROL_SAM_FREQ - 1);
+	if (writeable) {
+		data = cpu_to_le32(rate);
+		err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+					   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+					   UAC2_CS_CONTROL_SAM_FREQ << 8,
+					   snd_usb_ctrl_intf(chip) | (clock << 8),
+					   &data, sizeof(data));
+		if (err < 0) {
+			snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2): err %d\n",
+				   dev->devnum, iface, fmt->altsetting, rate, err);
+			return err;
+		}
 	}
 
-	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 				   UAC2_CS_CONTROL_SAM_FREQ << 8,
 				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   &data, sizeof(rate))) < 0) {
+				   &data, sizeof(rate));
+	if (err < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2): err %d\n",
 			   dev->devnum, iface, fmt->altsetting, err);
 		return err;
 	}
 
 	crate = le32_to_cpu(data);
-	if (crate != rate)
+	if (crate != rate) {
+		if (!writeable) {
+			snd_printk(KERN_WARNING "%d:%d:%d: freq mismatch (RO clock): req %d, clock runs @%d\n",
+				dev->devnum, iface, fmt->altsetting, rate, crate);
+			return -ENXIO;
+		}
 		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+	}
 
 	return 0;
 }
-- 
1.8.1.5
