From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Wed, 12 Mar 2014 09:54:19 +0800
Message-ID: <20140312015418.GB1177@MrMyself>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
 <alpine.DEB.2.02.1403111026280.3558@heelrod>
 <531F320E.70605@metafoo.de>
 <20140311184606.GW28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140311184606.GW28112@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Paul.Handrigan@cirrus.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, lgirdwood@gmail.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2014 at 06:46:06PM +0000, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 04:55:58PM +0100, Lars-Peter Clausen wrote:
> > On 03/11/2014 04:41 PM, Brian Austin wrote:
> 
> > >So WRT the CS42888, this is one device in a series of 2 devices that are
> > >register compatible with the only difference being that the CS42488 has 2
> > >extra ADC's. Same die and same DeviceID.
> 
> > >Would it make more sense to submit the driver with the extra ADC's to make
> > >it feature complete for both devices? Wouldn't be odd to have 2 drivers that
> > >do the same for 98% of the code.
> 
> > This should be in one driver. But support for the second device can
> > always be added in a follow up patch.
> 
> Yes, we can add support later.  It might be helpful to name the driver
> with some generic name I guess.

I didn't notice there's a sister model for CS42888. But good to know.

And I think I should try cs42x88.c as the driver name, which makes sense
even if we have another sister here. Or Brian may give me a more official
one?

It would be better if I also put those CS42488's support into the driver
but I'll start a long vacation from tomorrow. So if I am not able to do
that for CS42488's parts in the short time, I'll send the CS42888 part
first by the end of the day and we can add CS42488 later.

Thanks all,
Nicolin Chen


