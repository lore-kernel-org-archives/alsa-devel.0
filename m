From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/6] ASoC: davinci-mcbsp: add binding for
 McBSP
Date: Fri, 8 Apr 2016 11:24:28 +0200
Message-ID: <570778CC.1000600@barix.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-2-git-send-email-petr@barix.com> <570661A6.6020804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570661A6.6020804-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07.04.2016 15:33, Peter Ujfalusi wrote:

> Given that the driver is actually a driver for daVinci ASP and it 
> completely ignores registers introduced when the IP is renamed from 
> ASP to McBSP, should we say something about this? That the ASP is 
> compatible or subset of McBSP (w/o the multichannel support) and these 
> bindings could be used for ASP, with adding new compatible? Or just 
> leave that out and bother with it when we have such a device booting 
> with DT? 
Hi Peter,

what do you think about the following formulation?

--
This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
audio interface found in some TI DaVinci processors like the OMAP-L138 
or AM180x.

Some older DaVinci processors like the DM6446 or DA355 use a simpler 
version of
the digital audio interface, called ASP. This driver can support them as 
well if
the appropriate compatible string is added.
--

Thanks
Petr

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
