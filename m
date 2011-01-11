From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] sound: usb-audio: Digidesign Mbox 2 Duplex
	mode support FIXED
Date: Tue, 11 Jan 2011 20:29:15 +1100
Message-ID: <AANLkTi=5ezCWhVYL=0WmDQTWJn63dm+DEriZ_+_dMy6c@mail.gmail.com>
References: <1294309648-12274-1-git-send-email-damien.zammit@gmail.com>
	<s5hmxn8dh9m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 013D6245AA
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 10:29:15 +0100 (CET)
Received: by qyk34 with SMTP id 34so2305317qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 01:29:15 -0800 (PST)
In-Reply-To: <s5hmxn8dh9m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Please find my responses below, and my updated patch (hopefully) in the right
format in a second post to come.

> At Thu,  6 Jan 2011 21:27:28 +1100,
> damien.zammit at gmail.com wrote:
> >
> > From: Damien Zammit <damien.zammit at gmail.com>
> >
> > I fixed the infinite loop problem, and the tab indentation *properly* this
> > time.
> >
> > Damien Zammit (1):
> >   Support for Digidesign Mbox 2 in duplex analogue mode.
> >     Also provided a wait timeout for bootup of the device of 5 seconds,
> >     there are no more infinite loops in this code.
>
> Could you use git-format-patch or such so that I can apply the patch
> directly via git-am?  Also, your patch is missing your sign-off.
>
> Some review comments below.  I don't mention about the coding-style
> issues here.  In general, try scripts/checkpatch.pl and fix warnings
> suggested there before submission.
>
I have followed these suggestions, thanks.

> > +		bootresponse = MBOX2_BOOT_LOADING;
> > +		while ((bootresponse == MBOX2_BOOT_LOADING) && (count<5)) {
> > +			wait_event_timeout(mbox2_wait_queue, bootresponse == MBOX2_BOOT_READY, msecs_to_jiffies(1000)); /* 1 second delay */
>
> Do we really need this asynchronous wait-event?
Yes, unfortunately if the device is plugged in AFTER the module is loaded,
it takes up to 3.5 seconds to initialise and LEDs to power up, once it
receives the
'magic' boot setup packet, and before it will reply MBOX2_BOOT_READY.
I have moved the wait timeout to be at the end of each loop
so that it powers more quickly if already plugged in BEFORE the module
is loaded.

> > +			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
> > +				0x85, 0xc0, 0x0001, 0x0000, &bootresponse, 0x0012, 1000);
>
> No need for error check?
> The size is 0x12 although bootresponse is one byte?
>
I am copying the magic packet directly from the windows driver.  In
all cases which I tested, the response was 1 byte, even though the
size was specified as 0x12.
If the packet is modified to use a size of 0x01 byte, the device will
not initialise.
I suppose I could allocate 0x12 bytes for the response and only read
the first one?

> snd_printdd() should be avoided for error messages.  It's only for
> verbose debugging messages.
>
>
Thanks, I have changed this to snd_printk.

> > +			/* We want 48 kHz mode for now */
> > +			enablemagic[0]=0x80;
> > +			enablemagic[1]=0xbb;
> > +			enablemagic[2]=0x00;
> > +
> > +			/* Send the magic! */
> > +			snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
> > +				0x01, 0x22, 0x0100, 0x0085, &temp, 0x0003, 1000);
> > +			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
> > +				0x81, 0xa2, 0x0100, 0x0085, &enablemagic, 0x0003, 1000);
> > +			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
> > +				0x81, 0xa2, 0x0100, 0x0086, &enablemagic, 0x0003, 1000);
> > +			snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
> > +				0x81, 0xa2, 0x0100, 0x0003, &enablemagic, 0x0003, 1000);
>
> Hm, so these send the pointer to an array (i.e. char **)?
> Somehow I doubt whether the data handling is correct or not.
>
It works, because it sets the mode of the device correctly.
The only thing I am unsure about here is the "temp" variable, I
over-allocated it to
12 bytes because it never issues a response but I thought there might be cases
where it might send one, I have changed this down to 3 bytes long as
the size describes.

> > +	snd_printk("Invalid firmware size: %d\n",fwsize);
>
> Add KERN_ERR prefix.
Done.

> > +	if (altno != 3) return 1;
>
> Return a negative error code.
Done.

Please see my next post for the actual patch with these changes.

Regards,
Damien
