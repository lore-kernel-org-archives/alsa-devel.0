From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: [PATCH 2/2] Add support for Cyrix/NatSemi Geode
 SC5530 (VSA1)
Date: Thu, 24 May 2007 05:47:19 -0500
Message-ID: <20070524104719.9054C1158CC@ws1-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 55365243B7
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 12:47:04 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	6A54F18001A1
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 10:47:21 +0000 (GMT)
Content-Disposition: inline
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

> Avoid the style "if ((err = xx) < 0)" in new codes as much as
> possible.  Just write:
> 	err = pci_enable(pci);
> 	if (err < 0)
> 		return err;
> Now the kernel coding style recommends this.


Sorry, I wasn't aware this had changed :)


> > +	if (dma8 & 0x20)
> > +		dma16 = 5;
> > +	else if (dma8 & 0x40)
> > +		dma16 = 6;
> > +	else if (dma8 & 0x80)
> > +		dma16 = 7;
> > +	else
> > +	{
> > +		printk(KERN_ERR "CS5530: No 16bit DMA enabled\n");
> > +		snd_cs5530_free(chip);
> > +		return -ENODEV;
> > +	}
> 
> Ditto.
> (BTW, is dma16 really necessary to be zero-initialized at beginning?)
> 

It is, I think. It supresses a compiler warning, due the to fact that
the final else path does not set dma16 and so if this path is taken the
variable is uninitialied...not that we care, but we certainly don't
need a compiler warning.

> 
> Is the driver confirmed to work with the recent kernel?
> If yes, we can put cs5530.c to alsa-kernel so that it'll be merged to
> the next linux kernel.  alsa-driver tree still needs cs5530.c just
> including alsa-kernel code, though.
> Also, don't forget to add a description to ALSA-Configuration.txt.
> 
> Could you fix these issues and resend the patch?

It was devleoped on 2.6.21.1. OK, I'll make all the necessary changes.

Thanks,

Ash


=
