From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Problem with USB Class 2 Audio Driver
Date: Tue, 24 Aug 2010 10:56:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008241050320.1652-100000@iolanthe.rowland.org>
References: <20100823191209.GF17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100823191209.GF17833-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Demian Martin <demianm_1-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "'J. Gordon Rankin'" <waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Aug 2010, Daniel Mack wrote:

> Hi,
> 
> FWIW, I currently have no clue what could be the reason for this issue.
> I copied the linux-usb mailing list, maybe anyone over there has an
> idea.
> 
> Summary is: Demian is trying to play back an audio file over an USB
> connected soundcard, and the file itself is also stored on a media
> connected via USB. The transfer alone seems to be reasonably fast
> (tested with 'dd'), and the card itself also works fine (tested with a
> file stored on a different media), but the combination of them both
> fails. At least for high sample rates - iow, high data throughput.
> 
> Could there be anything wrong with the isochronous bandwith reservation?

I doubt it.  But we have seen reports of problems before from people 
trying to do high-bandwidth transfers to multiple devices concurrently.

To start, let's see the "lsusb -v" output for the audio card and the
storage device, together with the dmesg log showing the two devices
being plugged in.

For tracking down the exact problem, it will help to have a usbmon
trace showing what happens during playback.  (Stop the playback after
the first underrun occurs.)  Instructions are in
Documentation/usb/usbmon.txt.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
