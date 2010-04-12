From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 14:12:43 +0200
Message-ID: <20100412121243.GN18855@one.firstfloor.org>
References: <20100407090623.GN30807@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org> <87sk719hbm.fsf@basil.nowhere.org> <20100412111439.GU30801@buzzloop.caiaq.de> <20100412115300.GM18855@one.firstfloor.org> <q2z74fd948d1004120511hebf19eaauc41ee9ed25dea19e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <q2z74fd948d1004120511hebf19eaauc41ee9ed25dea19e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

> 
> I'm not putting into question whether something is broken in my
> system, but if it is, it must be the ICH9 platform, because I was able
> to reproduce it in another laptop.
> 
> My laptop is a Lenovo T400 and I was able to reproduce it in a Acer
> Aspire 59xx (I don't remember the exact model, but it is one of the
> new ones with 15.6 inch - i think they all use the same base). And the
> common thing between them is the ICH9 platform.

There are lots of systems around with ICH9 that work fine.
I'm typing on one.

> 
> The only which solved this problem was the first patch sent to me by
> Daniel Mack. I've been using it for days straight and it works fine.

Can you send a full boot log?

-Andi
-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
