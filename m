From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Fri, 29 Aug 2014 09:40:11 -0700
Message-ID: <20140829164010.GA5520@Asurada>
References: <20140829110601.GB21473@leverpostej>
 <20140829115943.GV29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140829115943.GV29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 29, 2014 at 12:59:43PM +0100, Mark Brown wrote:
> On Fri, Aug 29, 2014 at 12:06:01PM +0100, Mark Rutland wrote:
> > On Fri, Aug 29, 2014 at 08:12:12AM +0100, Xiubo Li wrote:
> 
> > > The 'big-endian-data' property is originally used to indicate whether the
> > > LSB firstly or MSB firstly will be transmitted to the CODEC or received
> > > from the CODEC, and there has nothing relation to the memory data.
> 
> > Both Nicolin [1] and Mark [2] asked for the old property to be kept
> > around for compatibility reasons. Those requests seem to have been
> > ignored entirely; the commit message doesn't even describe why you
> > believe removing support for the old property is safe.
> 
> The response was that the relevant chips aren't out in the wild so it's
> vanishingly unlikely that anyone would have a real DT with this option
> enabled.  I'll defer to Nicolin on if that's the case or not.

Yea, it sounds like so. I thought Vf610 also used this property. But if
only LS1 using it, I think we may consent this rename right?

Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
