From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v4] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Fri, 22 Mar 2013 16:32:19 +0100
Message-ID: <514C7983.40904@ladisch.de>
References: <20130319214531.GD7539@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 49853265191
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 16:32:22 +0100 (CET)
In-Reply-To: <20130319214531.GD7539@pvv.ntnu.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Torstein Hegge wrote:
> +	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
> +				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
> +				   UAC2_CS_CONTROL_SAM_FREQ << 8,
> +				   snd_usb_ctrl_intf(chip) | (clock << 8),
> +				   data, sizeof(data))) < 0) {
> +		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
> +			   dev->devnum, iface, fmt->altsetting);
> +		return err;
> +	}

This code requires that all devices allow reading the sample rate.

When you cannot read the current rate, just assume it needs to be set.


Regards,
Clemens
