From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/4 RESEND] ARC: axs10x: Update defconfigs so that audio
 is enabled
Date: Fri, 26 Feb 2016 07:00:02 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8C535@us01wembx1.internal.synopsys.com>
References: <cover.1456234503.git.joabreu@synopsys.com>
 <174bd675951f46071d0db8ea1f67abb083053332.1456234503.git.joabreu@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8BD53@us01wembx1.internal.synopsys.com>
 <1456323120.3392.31.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 24 February 2016 07:42 PM, Alexey Brodkin wrote:
>> Further per out off-list discussion - let us have a seperate config for ARC HS SDP
>> which supports the shipping single hardware configuration and add these fancy
>> things there as well as bumping the clk rate to 100 MHz . Current axs103* configs
>> are more of developer configs and I don't want to bloat their code with things we
>> don't build / download 10 times a day !
> Agree but first we need to introduce those additional configs.
> Let me draft those.

s/configs/config
We only need one !

> In the meantime it would be helpful if you take a look at existing axs10x_defconfigs
> and check which option you do want to keep and what are those extra once that should
> go to new configs with all bells and whistles.

I'd say leave current axs103* defconfigs as to what they are - we can trim them at
leisure / seperately.
Introduce a new config item which matches the shipping axs product (NR_CPU = 2
etc) and a pairing defconfig
and add all the fancy stuff there ! They can continue to share the DTs
The other purpose of this config item is to elide the hack we have for setting clk
for SMP (so it remains 90 or 100)

-Vineet
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
