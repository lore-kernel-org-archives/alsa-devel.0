From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 14:58:32 -0500 (EST)
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44L0.0402161447220.1490-100000@ida.rowland.org>
References: <1076956436.683.88.camel@puppeli>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <1076956436.683.88.camel@puppeli>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Sampo Savolainen <v2@iki.fi>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Feb 2004, Sampo Savolainen wrote:

> lsusb works fine, and I can read /proc/bus/usb/devices very well.
> Actually, lsbus and /proc/bus/usb still shows the Quattro, even after
> disconnecting it.
> 
> Also something I forgot: The kernel won't find ANY usb device after
> disconnecting, not even on another controller than the one that the
> Quattro was attached to.

Both of those are signs that the sound driver is hung in its disconnect 
routine.  You can verify this by doing a stack trace (Alt-SysRq-T) and 
looking where the khubd thread is executing.

> > There hasn't been much call for making the kernel allow out-of-spec
> > altsetting numbers; the vast majority of devices seem to get this right.
> > Maybe if enough people really want it, it will be added in.
> 
> I know of at least two "USB" soundcards that have this problem. At least
> M-Audios Quattro and Audiophile. Probably both of them would work if
> this patch would be applied to the kernel with a correction to the
> snd_usb_audio driver. For us audiogeeks this would be wonderful news.
> 
> On the other hand. I do not know enough about linux-usb development. So
> I don't know what kind of issues this patch could create.
> 
> I haven't asked around, so I do not know how many people need this, but
> I have been in touch with at least three others who use this hardware on
> Linux. I think I'm speaking for everyone (of us four...) when I say we
> really, really, want this feature!

The person to convince is Greg KH <greg@kroah.com>, the overall maintainer 
for the USB subsystem.  He monitors the USB-development list (although I 
haven't seen much posted by him in a while; he must be busy with other 
things).

> (Before I get really excited, this patch has to be tested more
> strenuously before adding it in)
> 
> Meanwhile, I'll try to find someone on the alsa side to help me find the
> problem in snd_usb_audio. Just to make sure, your opinion is that the
> patch is fine and the problem is on the driver side?

I haven't studied it in detail.  The general idea is fine -- perhaps the
implementation could be improved a bit.  The problem you are facing now is
almost certainly in the sound driver.  Maybe just in its disconnect
routine, maybe more widespread.

But the real obstacle to adopting your patch is that it affects _every_ 
USB device driver, since any USB device might have this issue of 
mis-numbered altsettings.  You would have to go through every single 
driver and make sure that it would work okay with the patch.  I expect 
that several of them would need to be changed.

Alan Stern



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
