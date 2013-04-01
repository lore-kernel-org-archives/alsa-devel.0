From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH 10/10] ALSA: usb-audio: UAC2: support
 read-only freq control
Date: Mon, 1 Apr 2013 10:17:21 +0200
Message-ID: <20130401081721.GI18838@pvv.ntnu.no>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-11-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2476326171F
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 10:17:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1364745152-1762-11-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 31, 2013 at 17:52:32 +0200, Eldad Zack wrote:
> Some clocks might be read-only, e.g., external clocks (see also
> UAC2 4.7.2.1).
> 
> In this case, setting the sample frequency will always fail
> (even if the rate is equal to the current clock rate),
> therefore do not write, but read the value and compare to the
> requested rate.
> 
> If it doesn't match, return -ENXIO since the clock is invalid for
> this configuration.

I think could be more readable if it was built on top of [1]. Then it
could check the target rate against the prev_rate reported by the device
and return before the sample rate set, something like:

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 9e2703a..395327c 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -254,18 +254,14 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	struct usb_device *dev = chip->dev;
 	unsigned char data[4];
 	int err, cur_rate, prev_rate;
-	int clock = snd_usb_clock_find_source(chip, fmt->clock);
+	int clock;
+	bool writeable;
+	struct uac_clock_source_descriptor *cs_desc;
 
+	clock = snd_usb_clock_find_source(chip, fmt->clock, true);
 	if (clock < 0)
 		return clock;
 
-	if (!uac_clock_source_is_valid(chip, clock)) {
-		/* TODO: should we try to find valid clock setups by ourself? */
-		snd_printk(KERN_ERR "%d:%d:%d: clock source %d is not valid, cannot use\n",
-			   dev->devnum, iface, fmt->altsetting, clock);
-		return -ENXIO;
-	}
-
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
@@ -279,6 +275,20 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		prev_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
 	}
 
+	cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
+	writeable = uac2_control_is_writeable(cs_desc->bmControls, UAC2_CS_CONTROL_SAM_FREQ - 1);
+	if (!writeable) {
+		if (prev_rate != rate) {
+			snd_printk(KERN_WARNING
+				"%d:%d:%d: freq mismatch (RO clock): req %d, clock runs @%d\n",
+				dev->devnum, iface, fmt->altsetting, rate, crate);
+			return -ENXIO;
+		}
+		else {
+			return 0;
+		}
+	}
+
 	data[0] = rate;
 	data[1] = rate >> 8;
 	data[2] = rate >> 16;

+ the other changes from the rest of your patch series.

[1] http://thread.gmane.org/gmane.linux.alsa.devel/106773

> +		err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
> +					   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
> +					   UAC2_CS_CONTROL_SAM_FREQ << 8,
> +					   snd_usb_ctrl_intf(chip) | (clock << 8),
> +					   &data, sizeof(data));

Is the indentation here intentional?

> -	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
> +	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
>  				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
>  				   UAC2_CS_CONTROL_SAM_FREQ << 8,
>  				   snd_usb_ctrl_intf(chip) | (clock << 8),
> -				   &data, sizeof(rate))) < 0) {
> +				   &data, sizeof(rate));

Same formatting comment as above.

> +	if (crate != rate) {
> +		if (!writeable) {
> +			snd_printk(KERN_WARNING "%d:%d:%d: freq mismatch (RO clock): req %d, clock runs @%d\n",
> +				dev->devnum, iface, fmt->altsetting, rate, crate);
> +			return -ENXIO;
> +		}
>  		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
> +	}

This bit didn't read very well on a narrow terminal.


Torstein
