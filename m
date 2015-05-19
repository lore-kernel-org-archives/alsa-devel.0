From: Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] USB headset cannot get freq
Date: Tue, 19 May 2015 15:18:36 +0200
Message-ID: <20150519131836.GA1583@fritha.org>
References: <20150516142523.GE1794@fritha.org>
 <20150516152557.GA14206@kroah.com>
 <s5h617p0x3a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5h617p0x3a.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Heinz Diehl <htd+ml-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 19.05.2015, Takashi Iwai wrote: 

> Try to add the USB ID of your device to
> snd_usb_get_sample_rate_quirk() in sound/usb/quirks.c.  This should
> suppress the sample rate inquiries.

The problem resolved today, the headset was defective. The replacement
works out of the box. Sorry for the noise!

Thanks,
 Heinz
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
