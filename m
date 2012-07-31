From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disappears
 suddenly
Date: Tue, 31 Jul 2012 10:35:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1207311034140.1532-100000@iolanthe.rowland.org>
References: <1343736296.42529.YahooMailNeo@web121606.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343736296.42529.YahooMailNeo-JJyWuWT5O7BRBbKmAC7my5OW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Jul 2012, Joao Bonina wrote:

> You're right about the EMI message, it's happening when the streaming stops.
> 
> I've tried different cables before, but that didn't solve the problem.
> 
> The motherboard is an Alix 1D, and I'm using the onboard USB 2.0 ports.
> 
> If this really is an EMI issue, guess I'll have to source some kind of miniPCI-USB 2.0 card and see if that solves the problem.

Another possibility is to put a USB hub before the sound device.  That 
_might_ clean up the signal.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
