From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH v3] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Mon, 11 Mar 2013 22:39:08 +0100
Message-ID: <20130311213908.GP20417@pvv.ntnu.no>
References: <20130305220303.GD20417@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 93729265B94
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 22:39:13 +0100 (CET)
Received: from horisont.pvv.ntnu.no ([129.241.210.175] ident=Debian-exim)
 by microbel.pvv.ntnu.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <torstehe@pvv.ntnu.no>)
 id 1UFAR2-0007Kn-DQ
 for alsa-devel@alsa-project.org; Mon, 11 Mar 2013 22:39:12 +0100
Received: from torstehe by horisont.pvv.ntnu.no with local (Exim 4.72)
 (envelope-from <torstehe@pvv.ntnu.no>) id 1UFAR2-0000pE-7A
 for alsa-devel@alsa-project.org; Mon, 11 Mar 2013 22:39:08 +0100
Content-Disposition: inline
In-Reply-To: <20130305220303.GD20417@pvv.ntnu.no>
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
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2013 at 11:03:03PM +0100, Torstein Hegge wrote:
> The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
> sample rate while the interface is active.
> 
> Reset the interface after setting the sampling frequency on sample rate
> changes, to ensure that the sample rate set by snd_usb_init_sample_rate() is
> used. Otherwise, the device will try to use the sample rate of the previous
> stream, causing distorted sound on sample rate changes.
> 
> The reset is performed for all current C-Media UAC V2.0 devices, including
> CM6610, CM6620 and CM6631, but has only been tested with CM6631.
> 
> Signed-off-by: Torstein Hegge <hegge@resisty.net>

Just to give a status update on this: I have been using this patch for a
week without sample rate change issues. It has also been tested on a
Asus Xonar Essence One, where it fixes the issue.

There are still some issues with the Schiit Bifrost as described by
Chris Hermansen in "Status of CM6631 USB" on alsa-user [1]. While the
workaround fixes the sample rate change issue in some cases, he still
sometimes get mangled audio on sample rate change.

Any ideas on what could be causing this difference between seemingly
similar hardware would be appreciated.

One difference is that 'lsusb -v' from the Schiit Bifrost [2] lists
interface 2-5, 7 and 8. My Corda [3] and the Asus card only lists
0, Audio, Control Device
1, Audio, Streaming
2, Human Interface Device (this is number 6 in the Schiit)

The extra interfaces listed by the Schiit is probably not backed by any
hardware in the CM6631.

[1] http://thread.gmane.org/gmane.linux.alsa.user/36935/focus=37267
[2] https://gist.github.com/storrgie/2897496
[3] https://gist.github.com/hegge/5133826

Torstein


> ---
> Changes since v2:
> - More USB ids covered.
> - int crate -> int cur_rate
> - unsigned int previous_rate -> int prev_rate
> 
>  sound/usb/clock.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/usb/clock.c b/sound/usb/clock.c
> index 5e634a2..98c4e26 100644
> --- a/sound/usb/clock.c
> +++ b/sound/usb/clock.c
> @@ -253,7 +253,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
>  {
>  	struct usb_device *dev = chip->dev;
>  	unsigned char data[4];
> -	int err, crate;
> +	int err, cur_rate, prev_rate;
>  	int clock = snd_usb_clock_find_source(chip, fmt->clock);
>  
>  	if (clock < 0)
> @@ -266,6 +266,18 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
>  		return -ENXIO;
>  	}
>  
> +	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
> +				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
> +				   UAC2_CS_CONTROL_SAM_FREQ << 8,
> +				   snd_usb_ctrl_intf(chip) | (clock << 8),
> +				   data, sizeof(data))) < 0) {
> +		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
> +			   dev->devnum, iface, fmt->altsetting);
> +		return err;
> +	}
> +
> +	prev_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
> +
>  	data[0] = rate;
>  	data[1] = rate >> 8;
>  	data[2] = rate >> 16;
> @@ -290,9 +302,39 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
>  		return err;
>  	}
>  
> -	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
> -	if (crate != rate)
> -		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
> +	cur_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
> +	if (cur_rate != rate) {
> +		snd_printd(KERN_WARNING
> +			   "current rate %d is different from the runtime rate %d\n",
> +			   cur_rate, rate);
> +	}
> +
> +	/* Some devices doesn't respond to sample rate changes while the
> +	 * interface is active. */
> +	if (cur_rate != prev_rate) {
> +		switch (chip->usb_id) {
> +		/* C-Media CM6610/CM6620/CM6631 */
> +		case USB_ID(0x054c, 0x06cf): /* Sony */
> +		case USB_ID(0x0b05, 0x17a8): /* Asus Xonar Essence One */
> +		case USB_ID(0x0d8c, 0x0301):
> +		case USB_ID(0x0d8c, 0x0302):
> +		case USB_ID(0x0d8c, 0x0304): /* CM6631 (Schiit) */
> +		case USB_ID(0x0d8c, 0x0305):
> +		case USB_ID(0x0d8c, 0x0306):
> +		case USB_ID(0x0d8c, 0x0309): /* CM6631 */
> +		case USB_ID(0x0d8c, 0x0310):
> +		case USB_ID(0x0d8c, 0x0311): /* CM6610A */
> +		case USB_ID(0x0d8c, 0x0312): /* CM6620A */
> +		case USB_ID(0x0d8c, 0x0313): /* CM6630A */
> +		case USB_ID(0x0d8c, 0x0314): /* CM6631A */
> +		case USB_ID(0x0d8c, 0x0315): /* CM6632A */
> +		case USB_ID(0x0d8c, 0x0319): /* CM6631A */
> +		case USB_ID(0x200c, 0x1030): /* Reloop */
> +			usb_set_interface(dev, iface, 0);
> +			usb_set_interface(dev, iface, fmt->altsetting);
> +			break;
> +		}
> +	}
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
