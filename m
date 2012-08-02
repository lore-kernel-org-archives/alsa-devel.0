From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disappears
 suddenly
Date: Thu, 2 Aug 2012 11:42:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208021136180.1170-100000@iolanthe.rowland.org>
References: <1343919982.13369.YahooMailNeo@web121604.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343919982.13369.YahooMailNeo-JJyWuWT5O7AbWpotXP+qY5OW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Aug 2012, Joao Bonina wrote:

> Did the copying test and all went well there.
> 
> Also did a usbmon session with the DAC disconnecting/reconnecting 
> automatically. There was no EMI message in dmesg there, and I'm 
> connecting the DAC through a USB hub.
> 
> Analyzed the usbmon log with Virtual USB analyzer, but couldn't find
> reasons there for the disconnection. I'm not very experienced in this
> subject, so excuse me if I'm missing something obvious here.
> 
> I'm attaching the usbmon log if someone wants to take a look at it.
> Sorry for the long attachment file.

I agree, there's no obvious reason for the disconnection in the log.  
Possible explanations include a bad cable connection or a bug in the 
sound card's firmware.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
