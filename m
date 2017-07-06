From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 6/9] clk: at91: clk-generated: make gclk determine
 audio_pll rate
Date: Thu, 6 Jul 2017 18:08:31 +0200
Message-ID: <20170706160831.4ire6kbfqswo337d@piout.net>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-7-quentin.schulz@free-electrons.com>
 <ab11f002-b761-cdb4-eb0c-ce24dcb9c5d4@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ab11f002-b761-cdb4-eb0c-ce24dcb9c5d4-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 06/07/2017 at 17:29:22 +0200, Nicolas Ferre wrote:
> > +	/*
> > +	 * The audio_pll rate can be modified, unlike the five others clocks
> > +	 * that should never be altered.
> > +	 * The audio_pll can technically be used by multiple consumers. However,
> > +	 * with the rate locking, the first consumer to enable to clock will be
> > +	 * the one definitely setting the rate of the clock.
> > +	 * Since audio IPs are most likely to request the same rate, we enforce
> > +	 * that the only clks able to modify gck rate are those of audio IPs.
> > +	 */
> > +
> > +	if (gck->id != GCK_ID_SSC0 && gck->id != GCK_ID_SSC1 &&
> > +	    gck->id != GCK_ID_I2S0 && gck->id != GCK_ID_I2S1 &&
> > +	    gck->id != GCK_ID_CLASSD)
> > +		goto end;
> 
> ...well... maybe for a temporary solution, but what about the next
> product that will also have such feature but without the same set of IDs?
> 

It will have a different compatible and that can be used to encode the
difference.

> I know that the main use of this clock is the "audio" subsystem (so its
> name) but in a machine without audio needs, it can be interesting to use
> this fractional PLL for other devices that can handle a GCK (and I'm
> thinking about the SDHCI interface that then could be configured with
> maximum clock speed).
> 
> > +	parent = clk_hw_get_parent_by_index(hw, GCK_INDEX_DT_AUDIO_PLL);
> > +	if (!parent)
> > +		goto end;
> 
> Here, if the audio pll id changes in the DT, we don't retrieve the
> proper parent... And again, not very future proof.
> 

One more reason to remove all the crap we have in the DT, as suggested
by RobH.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
