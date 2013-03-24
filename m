From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH v4] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Sun, 24 Mar 2013 21:46:56 +0100
Message-ID: <20130324204656.GA776@pvv.ntnu.no>
References: <20130319214531.GD7539@pvv.ntnu.no>
 <514C7983.40904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F6202615AA
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 21:47:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <514C7983.40904@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 22, 2013 at 16:32:19 +0100, Clemens Ladisch wrote:
> Torstein Hegge wrote:
> > +	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
> > +				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
> > +				   UAC2_CS_CONTROL_SAM_FREQ << 8,
> > +				   snd_usb_ctrl_intf(chip) | (clock << 8),
> > +				   data, sizeof(data))) < 0) {
> > +		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
> > +			   dev->devnum, iface, fmt->altsetting);
> > +		return err;
> > +	}
> 
> This code requires that all devices allow reading the sample rate.
> 
> When you cannot read the current rate, just assume it needs to be set.

Good point, read failure shouldn't have to be fatal, or cause
set_sample_rate_v2() to return before actually setting the sample rate. But
set_sample_rate_v2() already depends on being able to read the sample rate, and
will propagate errors back to snd_usb_pcm_prepare(), even if the returned rate
isn't used for anything except for a snd_printd.

On the other hand, set_sample_rate_v1() does
        return 0; /* some devices don't support reading */
when it fails to read the current rate.

Both the existing sample rate read and the sample rate read added by this patch
could be replaced by

        err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
                              USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
                              UAC2_CS_CONTROL_SAM_FREQ << 8,
                              snd_usb_ctrl_intf(chip) | (clock << 8), 
                              data, sizeof(data));
        }
        if (err < 0) {
                snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
                           dev->devnum, iface, fmt->altsetting);
                cur_rate = 0;
        } else {
                cur_rate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
        }


Torstein
