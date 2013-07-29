From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Mon, 29 Jul 2013 19:12:02 +0200
Message-ID: <51F6A262.6010800@ladisch.de>
References: <Pine.LNX.4.44L0.1307291041410.1479-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1307291041410.1479-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> Clemens remarked some time ago that keeping the queue full would be
> trivial, if only he knew how full it needed to be.  The answer to that
> is given above.  I have been trying to make the appropriate changes,
> but I'm not finding it "trivial".

What I meant was that it would be trivial to change the lower bound of
the period size (from which many queueing parameters are derived).

> The current driver seems to assume that endpoints with an _implicit_
> feedback endpoint won't have variable-length packets.

That's likely to be a bug.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
