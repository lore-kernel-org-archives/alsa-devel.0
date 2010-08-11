From: Paul Zimmerman <Paul.Zimmerman-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH] sound: usb: USB3 Super Speed patch
Date: Wed, 11 Aug 2010 11:16:05 -0700
Message-ID: <F6C4814A9B336243ABC3D1FB44E08AE8012C3455D8@US01WXMBX1.internal.synopsys.com>
References: <F6C4814A9B336243ABC3D1FB44E08AE8012C2846E3@US01WXMBX1.internal.synopsys.com>
 <4C624A15.206@ladisch.de> <20100811073443.GG10432@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100811073443.GG10432-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

> From: Daniel Mack [mailto:daniel-rDUAYElUppE@public.gmane.org]
> On Wed, Aug 11, 2010 at 08:58:29AM +0200, Clemens Ladisch wrote:
> > Paul Zimmerman wrote:
> > > This patch adds Super Speed support to the USB drivers under sound/. It adds
> > > tests for USB_SPEED_SUPER to all the places that check for the USB speed.
> 
> Can we see the full patch on this list, please?

OK, when I resend the patch I will copy alsa-devel.

> 
> Just curious - did you actually test the driver with a SuperSpeed
> capable USB audio device? Which device was that?

It's the Synopsys SuperSpeed USB3 device core, on an FPGA PCI development board.
The audio device implementation is not a real product, just a test platform. To
implement it, we used the audio gadget driver with some mods to support USB3.

> Thanks,
> Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
