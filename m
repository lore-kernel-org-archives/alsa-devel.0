From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/8] ARM: dts: am335x-pepper: Fix the audio CODEC's
 reset pin
Date: Thu, 30 Nov 2017 09:00:58 -0800
Message-ID: <20171130170058.GQ28152@atomide.com>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-6-afd@ti.com>
 <20171130161826.GP28152@atomide.com>
 <20171130163344.kudopvsljywb4hyw@sirena.org.uk>
 <4b535cec-6e33-adc0-a962-f5e65d84d1ad@ti.com>
 <20171130165328.q5nknyvwp36xj4t2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130165328.q5nknyvwp36xj4t2@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

* Mark Brown <broonie@kernel.org> [171130 16:56]:
> On Thu, Nov 30, 2017 at 10:37:22AM -0600, Andrew F. Davis wrote:
> > On 11/30/2017 10:33 AM, Mark Brown wrote:
> 
> > > It might make sense to pull in the relevant branches from ASoC first
> > > however IIRC the reset GPIO code currently does nothing useful anyway so
> > > it won't have any impact on bisection.  Andrew?
> 
> > Yeah, that's right, for safety it would be nice to take these after the
> > ASoC code, but it shouldn't matter in practice as the reset wasn't used
> > right anyway.
> 
> I'd just go for it.

OK will apply the two omap dts changes for v4.16.

Thanks,

Tony
