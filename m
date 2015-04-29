From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] mfd: arizona: Update DT binding to
	support hpdet channel
Date: Wed, 29 Apr 2015 14:12:45 +0100
Message-ID: <20150429131245.GL3480@opensource.wolfsonmicro.com>
References: <1429589505-11954-1-git-send-email-ideal.song@samsung.com> <1429589505-11954-3-git-send-email-ideal.song@samsung.com> <20150429105737.GZ9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150429105737.GZ9169@x1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 11:57:37AM +0100, Lee Jones wrote:
> Does this looks okay to you Charles?
> 
> > This patch add device tree bindings for the pdata needed to configure
> > the Accessory Detect Mode select when Headphone detection.
> 
> Isn't the idea of headphone detection that it headphones are detected
> i.e. automatically?
> 

Yeah, pretty much the chip can run an impedance measurement on
either the left or the right headphone pin and to complicate
things a little further you don't necessarily have to wire that
to the actual headphones in hardware. So people tend to wire
up all sorts of odd things that they thought sounded awesome. So
you do really need a way to inform the driver which pin is
actually going to be useful for measuring the headphone impedance
on a specific system.

In an ideal world we would just measure both and take the
average, but in practice it is very dependent on how the hardware
is wired up.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
