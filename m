From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Tue, 10 Sep 2002 10:58:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209100853400.12586-100000@studcom.urz.uni-halle.de>
References: <s5hn0qryq08.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hn0qryq08.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fedor Pikus <fedor_pikus@mentorg.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> is there any good text-format tool for usb descriptors except for
> humanbeing?

The /proc/asound/card?... information of snd-usb-audio ;-)

Fedor, it would be interesting to see how much got parsed with uhci.

> > There are two PCM devices, but both use the same endpoints.
> ...
> > It may be possible to fake better descriptors by adding a quirk and
> > some code to the snd-usb-audio driver. I'm not sure whether the host
> > controller driver had to be aware of the fake, too -- currently, the
> > alternate settings 1 and 2 wouldn't be found, and wMaxPacketSize
> > would be too small for 96 kHz.
>
> it seems fine: 576 = 96 * 6 and 384 = 96 * 4 ?

In interfaces 1/2, wMaxPacketSize isn't greater than 288. But I've just
realized that usb.c looks at all interfaces to determine the maximum, so
this isn't an issue.

> > The two PCM devices cannot be used at the same time anyway, so I think
> > creating a quirk for interface 0 which says "ignore this" could work.
> > Takashi, any comments?
>
> i think implementing a semaphore (or flag) for each endpoint would be
> better, so that the driver can find generally double-endpoints
> problem.

I cannot imagine anybody else would be stupid enough to design a device
with double endpoints. But then I didn't imagine Midiman would, either.
Oh well, Murphy's Law ...  :-(

Currently, both uhci and usb-uhci break in interesting ways, and I'm not
sure this could be prevented by some workaround in snd-usb-audio. I have
the feeling that all host controller drivers ([usb-]uhci, ohci, ehci,
...), or usb.c, would have to be patched to work around the problem. But I
didn't write the USB subsystem, nor do I have the device, so feel free to
ignore my opinion. :)


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
