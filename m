From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio and midisport1x1 little hack fixes
 hotplug pb
Date: Wed, 17 Mar 2004 09:03:24 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403170857070.10179-100000@studcom.urz.uni-halle.de>
References: <1079459473.2579.7.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1079459473.2579.7.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: Mathieu Geli <geli@enseirb.fr>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> I removed the quick hack from Mathieu and inserted snd_printk's in
> snd_usbmidi_disconnect.
>
> The new function:
> ...
>                 if (ep->out && ep->out->urb)
>                         usb_unlink_urb(ep->out->urb);
>                         snd_printk(KERN_INFO "usb_unlink_urb out\n");

Please note that this is C, not Python.  :-)

> The output from dmesg I got:
>
> ohci_hcd 0000:00:02.0: urb e2e2b4c0 path 2.4 ep1in 5e160000 cc 5 --> status -110
> hub 1-2:1.0: port 4, status 100, change 1, 12 Mb/s
> usb 1-2.4: USB disconnect, address 5
> usb 1-2.4: usb_disable_device nuking all URBs

It seems we don't need to unlink the URBs as the kernel does this for
us, but it doesn't hurt.

> ...
> ALSA sound/usb/usbmidi.c:723: usb_unlink_urb in
> ALSA sound/usb/usbaudio.c:2924: snd_usb_audio_disconnect called, refcount = 0

Apparently, snd_usb_audio_disconnect is called recursively, caused by
the call to usb_driver_release_interface, and then deadlocks.

The USB core will release all interfaces automatically, so we don't
need this call.  Please remove the usb_driver_release_interface line.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
