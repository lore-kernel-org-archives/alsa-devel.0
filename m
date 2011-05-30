From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for FTDI-based Arduinos
Date: Mon, 30 May 2011 15:42:04 +0800
Message-ID: <20110530074204.GA7806@kroah.com>
References: <4DE31FE4.4040807@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4DE31FE4.4040807-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sdaau <sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 30, 2011 at 06:41:08AM +0200, sdaau wrote:
> Hi all,
> 
> (cross-posting to alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org and
> gmane.linux.usb.general/linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; apologies if it's
> inappropriate)
> 
> 
> I'd just like to inform that the AudioArduino project has been
> posted online:
> 
> http://imi.aau.dk/~sd/phd/index.php?title=AudioArduino
> 
> It contains links to open-source Arduino microcontroller code, and
> corresponding ALSA driver source code - which can demonstrate mono,
> full-duplex, 8-bit / 44.1 kHz soundcard operation on an FTDI-based
> Arduino.
> 
> There is also a related post on the (new) Arduino Forum:
> http://arduino.cc/forum/index.php/topic,62582.0.html

Very cool stuff, nice job!

Any thoughts about submitting back your kernel driver changes so we can
add them to the main kernel tree so that people don't have to build
out-of-tree kernel drivers to use this?

It could just be an option to the existing ftdi_sio driver that is
enabled somehow for a specific device, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
