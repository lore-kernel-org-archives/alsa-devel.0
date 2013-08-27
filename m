From: James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 27 Aug 2013 07:32:03 +0100
Message-ID: <CABRv+91ZGMHbHZFW0gYOL-zGP=HbmiJU51z-_C_2Jj+5ATisrA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1308211654010.1297-100000@iolanthe.rowland.org>
	<Pine.LNX.4.44L0.1308261419100.886-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308261419100.886-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 26, 2013 at 7:37 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> Clemens and everyone else:
>
> Not having heard any responses to the patch posted last Wednesday, I
> have updated and completed it.  The version below is ready for testing.
> Please let me know what you find.
>
> It is not very different from the previous version.  I got rid of the
> nrpacks module parameter and figured out how to pass the frames/period
> and periods/buffer values to data_ep_set_params().  (Maybe this isn't
> the best way to do it, but it works.)  I also fixed up the calculation
> that limits URBs to a sync interval.
>
> Of greater interest, I decided to limit each URB to 6 ms and the total
> queue to 18 ms, thereby encouraging the driver to use three URBs rather
> than two.  (These values could be increased to 8 and 24, respectively.)
> This helps to reduce the effects of an underrun, as follows:
>
> With only two URBs, following an underrun the driver would submit URB1
> and URB2.  Because of the delay, it can easily happen that the last
> packet of URB1 comes before the isochronous scheduling threshold.  The
> URB gets scheduled, but the hardware never sees it.  Consequently there
> is no completion interrupt until URB2 finishes, at which point the
> queue is empty, causing a secondary underrun.  I actually saw this
> happen several times during testing.
>
> James, this patch should be tested along with Clemens's original
> "maxpacket is too large" patch and my "EHCI accepts late iso URBs"
> patches.  It should allow you to go down to ridiculously low parameter
> values, provided only that the total latency is higher than ~1.2 ms.
> For example, at 48 KHz this patch should work okay with 8 frames/period
> and 8 periods/buffer.  Of course, larger values will provide greater
> resilience against underruns.
>

This does not help at all with running jackd at lower latencies.

With this patch, I get xruns at 128 frames/period or less with jackd
(accompanied by iso underrun messages), whereas with vanilla 3.10.9
(which now has both yours and Clemen's patches applied), performance
is extremely good (64 frames per period possible).

James
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
