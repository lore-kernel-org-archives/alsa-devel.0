From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH v5] ALSA: usb: Work around CM6631 sample rate
	change bug
Date: Tue, 26 Mar 2013 22:10:05 +0100
Message-ID: <20130326211004.GD18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A6122602F9
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 22:10:12 +0100 (CET)
Content-Disposition: inline
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
Cc: tiwai@suse.de, clemens@ladisch.de, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

The C-Media CM6631 USB receiver doesn't respond to changes in sample rate
while the interface is active. The same behavior is observed in other UAC2
hardware like the VIA VT1731.

Reset the interface after setting the sampling frequency on sample rate
changes, to ensure that the sample rate set by snd_usb_init_sample_rate() is
used. Otherwise, the device will try to use the sample rate of the previous
stream, causing distorted sound on sample rate changes.

The reset is performed for all UAC2 devices, as it should not affect a
standards compliant device, but it is only necessary for C-Media CM6631,
VIA VT1731 and possibly others.

Failure to read sample rate from the device is not handled as an error in
set_sample_rate_v2(), as (permanent or intermittent) failure to read sample
rate isn't essential for a successful sample rate set.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
Changes since v4:
- Sample rate read failure is no longer fatal.

Failure to read sample rate from the device is degraded from a fatal error to
a warning message. The Schiit Bifrost has shown intermittent sample rate read
failures, and this shouldn't be a reason to abort the initialization.

- The reset is performed for all UAC2 devices.

The number of devices affected by this issue seems to be larger than just the
C-Media based devices, issues with the VIA VT1731 has been reported by Davor
Herga to alsa-user [1].

The additional reset should not affect standards compliant devices and will
hopefully improve the compatibility with future devices tested with the OS X
UAC2 driver.

This can cause problems for a theoretical device where sample rate read always
fails, causing the reset to be performed every time the sample rate is set,
*and* where repeated resets cause resume after pause to not resume properly,
like the issues seen with CM6631 in the first iteration of this patch.

[1] http://thread.gmane.org/gmane.linux.alsa.user/37312 


Changes since v3:
- Use given target rate instead of the new rate read from device when checking
  if a reset is needed. Some devices (at least Schiit Bifrost) doesn't report a
  reliable sample rate back right after setting a new rate. This appears to
  fix the issues with v3 of this patch with the Schiit, as reported by Chris
  Hermansen in http://thread.gmane.org/gmane.linux.alsa.user/36935/focus=37284


 sound/usb/clock.c |   45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 5e634a2..9e2703a 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -253,7 +253,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char data[4];
-	int err, crate;
+	int err, cur_rate, prev_rate;
 	int clock = snd_usb_clock_find_source(chip, fmt->clock);
 
 	if (clock < 0)
@@ -266,6 +266,19 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		return -ENXIO;
 	}
 
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8,
+			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      data, sizeof(data));
+	if (err < 0) {
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
+			   dev->devnum, iface, fmt->altsetting);
+		prev_rate = 0;
+	} else {
+		prev_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	}
+
 	data[0] = rate;
 	data[1] = rate >> 8;
 	data[2] = rate >> 16;
@@ -280,19 +293,31 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		return err;
 	}
 
-	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8,
-				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   data, sizeof(data))) < 0) {
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8,
+			      snd_usb_ctrl_intf(chip) | (clock << 8),
+			      data, sizeof(data));
+	if (err < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
 			   dev->devnum, iface, fmt->altsetting);
-		return err;
+		cur_rate = 0;
+	} else {
+		cur_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
 	}
 
-	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
-	if (crate != rate)
-		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
+	if (cur_rate != rate) {
+		snd_printd(KERN_WARNING
+			   "current rate %d is different from the runtime rate %d\n",
+			   cur_rate, rate);
+	}
+
+	/* Some devices doesn't respond to sample rate changes while the
+	 * interface is active. */
+	if (rate != prev_rate) {
+		usb_set_interface(dev, iface, 0);
+		usb_set_interface(dev, iface, fmt->altsetting);
+	}
 
 	return 0;
 }
-- 
1.7.10.4
