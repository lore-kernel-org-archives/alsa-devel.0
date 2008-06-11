From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Vendor support in Alsa Drivers
Date: Wed, 11 Jun 2008 10:09:57 -0700
Message-ID: <1213204197.19326.132.camel@razman>
References: <484E4E24.1060509@libera.cc>  <s5h4p802ahz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D843124842
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 19:10:00 +0200 (CEST)
In-Reply-To: <s5h4p802ahz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Emmanuel Kasper <emmanuel@libera.cc>
List-Id: alsa-devel@alsa-project.org

Just an addendum to this, I have had good support for most of the
on-board Intel HD audio codec vendors, most of which have been generous
enough to send me development boards, and most of them have their codec
specs posted on their web sites.  Unfortunately, lately I have been too
overwhelmed with other activities to do much more than read emails, but
I'm almost done with my degree program so I'll be jumping back into the
developers pool soon.

Tobin

On Wed, 2008-06-11 at 18:37 +0200, Takashi Iwai wrote:

> At Tue, 10 Jun 2008 11:49:24 +0200,
> Emmanuel Kasper wrote:
> > 
> > Hello
> > With a couple of other french folks, we are building a kind of webshop
> > for Linux/FreeBSD compatible hardware. We will reference only devices
> > which work with a free driver, so no nvidia binary thingie or atheros HAL.
> > Based on the information found  on  the alsa wiki we plan to reference
> > the following sound devices:
> > 
> > M-Audio Audiophile 24/96 (  snd-ice1712 driver )
> > Terratec AUREON 5.1
> > M-Audio Fast Track usb
> > Hercules Muse Pocket LT
> > Ion TTUSB usb turnable ( these 4 working with snd-usb-driver )
> > 
> > We would be also interested to indicate on each product description, if
> > the vendor of the product, or the chipset maker for that matters had
> > been helpful with developers trying to write a free driver. So for the
> > devices mentionned above, was any of the vendor helpful by providing
> > programming documentation or sample hardware ?
> 
> We have a good contact with M-Audio.  The above two devices were
> provided once for testing by M-Audio indeed.
> 
> The datasheet is another question -- for USB devices, it's often
> harder than PCI devices (by unknown reasons).
> 
> Terratec Aureon 5.1 (which model, BTW?) isn't well tested by
> developers.  We had once good contact with Terratec, and lost again.
> 
> AFAIK, no one had a contact with Hercules.
> I don't know about Ion.  Possibly Clemens had any contact?
> But, if the USB device works "as is", then it's all fine, even without
> a datasheet or a test device.  It means that the device is compliant
> to USB-standard protocol.  The bad case is that the device requires
> special vendor-specific protocols (often called "advanced mode").
> 
> 
> HTH,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


It's the thought, if any, that counts!
