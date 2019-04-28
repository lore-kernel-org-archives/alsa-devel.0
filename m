From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] sound: USB: line6: use dynamic buffers
Date: Sun, 28 Apr 2019 19:07:45 +0200
Message-ID: <20190428170745.GA19070@kroah.com>
References: <20190428160411.GA12815@kroah.com>
 <s5hmukakrod.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hmukakrod.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 28, 2019 at 06:42:10PM +0200, Takashi Iwai wrote:
> On Sun, 28 Apr 2019 18:04:11 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > --- a/sound/usb/line6/toneport.c
> > +++ b/sound/usb/line6/toneport.c
> > @@ -365,16 +365,21 @@ static bool toneport_has_source_select(s
> >  /*
> >  	Setup Toneport device.
> >  */
> > -static void toneport_setup(struct usb_line6_toneport *toneport)
> > +static int toneport_setup(struct usb_line6_toneport *toneport)
> >  {
> > -	u32 ticks;
> > +	u32 *ticks;
> >  	struct usb_line6 *line6 = &toneport->line6;
> >  	struct usb_device *usbdev = line6->usbdev;
> >  
> > +	ticks = kmalloc(sizeof(*ticks), GFP_KERNEL);
> > +	if (!ticks)
> > +		return -ENOMEM;
> > +
> >  	/* sync time on device with host: */
> >  	/* note: 32-bit timestamps overflow in year 2106 */
> > -	ticks = (u32)ktime_get_real_seconds();
> > -	line6_write_data(line6, 0x80c6, &ticks, 4);
> > +	*ticks = (u32)ktime_get_real_seconds();
> > +	line6_write_data(line6, 0x80c6, ticks, 4);
> > +	kfree(ticks);
> >  
> >  	/* enable device: */
> >  	toneport_send_cmd(usbdev, 0x0301, 0x0000);
> 
> This function misses the "return 0" at the end, so I fixed it up
> manually and applied now.

Ugh, sorry about that.  Odd I didn't get a build error, my fault.

thanks for the quick response.

greg k-h
