From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 12:50:43 -0500 (EST)
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44L0.0402161233140.1490-100000@ida.rowland.org>
References: <1076950250.683.38.camel@puppeli>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <1076950250.683.38.camel@puppeli>
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

> Hello to both alsa-devel and linux-usb-devel,
> 
> 
> As most of you who have seen the words "USB Quattro" and "2.6.x"
> together know, these two don't mix well. I have been investigating this
> issue for some time and here are a few conclusions:
> 
>  1. The Quattro's alternate settings (usb jargon) are wrong
>     (not-in-spec), and kernel doesn't accept the device.
>  2. M-Audio says that it has done nothing wrong and haven't issued
>     firmware updates (which as far as I know, are not possible on
>     the Quattro).
>  3. USB-IF says that M-Audio are violating the specs, but they can't
>     force them to correct these issues because the USB logo is not
>     on the device (that requires licensing and compliance). Only the
>     USB trident is on the box, and that doesn't apply.
> 
> USB-IF has said, that these kinds of misinterpretations of the spec are
> normal, and most operating systems just work around them. This isn't
> 'the right way to do it', but at the moment it seems like the only way
> to do it.

You didn't say exactly what the Quattro is doing wrong.  I can guess that 
it doesn't number its altsettings sequentially starting from 0.  Is that 
right?

> To remedy this situation I've been working on a patch to the usb core.
> The patch is attached as a part of this mail. This patch is not finished
> yet, it has an unloading issue! This is why I'm writing this mail to you
> all.
> 
> This patch is for Linux 2.6.2, it patches drivers/usb/core/config.c
> (cd linux-2.6.2; patch -p0 < ../whereisit?/usbconfig.patch)
> 
> The changes I've made are commented, but here's a short list:
> (All changes are for the code that configures new USB devices)
> 
> - Instead of counting how many alternate settings each interface has, it
>   sets the number of alternate settings to (largest found altsetting)+1.
> - Thus all the alternate settings are saved at the corresponding cell of
>   the interface->altsetting pointer. If an altsetting is missing, that
>   cell will be left blank.
> - After parsing each alternate setting, instead of reporting an error
>   for unset altsettings, the code truncates the list. If the list
>   was modified, a new pointer will be allocated and the old one will be
>   freed.
> 
> With this patch, I've got my Quattro working.
> The problem is this:
> If snd_usb_audio finds the soundcard, the card works well, until it is
> removed. The kernel will see the device disconnect, but after that you
> cannot reconnect the device. Nothing comes in the logs from connecting
> the cable. Also, removing the snd_usb_audio module will result in the
> command hanging. Not even 'kill -KILL [pid]' as root will kill the
> process.
> 
> If snd_usb_audio isn't loaded, the soundcard can be reconnected again
> and again and again without any problems-
> 
> I can think of a few things that could go wrong
>  - I've missed something that the USB drivers do with the descriptor
>    afterwards, especially when the descirptor is given to the
>    approriate registered driver. Some checks aren't done because all
>    devices should have all alternate settings?... 

Yes, although in your case the only driver in question is snd_usb_audio.  
You might also have trouble trying to read /proc/bus/usb/devices.

>  - The snd_usb_audio driver does something wild when all alternative
>    settings aren't set.
>  - Not much testing has been done on snd_usb_audio on 2.[56].x because
>    the Quattro hasn't worked at all.
> 
> Could someone with more experience in this area help me?
> 
> 
>  Thank you,
>    Sampo Savolainen

As you've seen, the problem isn't so easy to solve.  Yes, the USB core can
be patched as you've done to accept devices that number their altsettings
incorrectly.  Unforunately, there are many device drivers that assume the
numbering is done right.  They try to access the data for altsetting n by
looking at position n in the array of altsettings -- with your alterations
that won't work.  Unless you can change those drivers as well as the core,
you will run into exactly the sort of thing you're seeing here.

There hasn't been much call for making the kernel allow out-of-spec
altsetting numbers; the vast majority of devices seem to get this right.
Maybe if enough people really want it, it will be added in.

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
