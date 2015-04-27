From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/8] mfd: arizona: Add support for WM8998 and WM1814
Date: Mon, 27 Apr 2015 13:40:19 +0100
Message-ID: <20150427124019.GA3622@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com> <1429619636-25478-4-git-send-email-rf@opensource.wolfsonmicro.com> <20150422110808.GU22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150422110808.GU22845@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 12:08:08PM +0100, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 01:33:51PM +0100, Richard Fitzgerald wrote:
> 
> > +	switch (arizona->type) {
> > +	case WM8998:
> > +	case WM1814:
> > +		/* Some bits are shifted on WM8998,
> > +		 * rearrange to match the standard bit layout
> > +		 */
> > +		val[0] = ((val[0] & 0x60e0) >> 1) |
> > +			 ((val[0] & 0x1e00) >> 2) |
> > +			 (val[0] & 0x000f);
> > +		break;
> 
> Are you sure this approach is going to scale (and avoid confusion)?

It's a total one-off for the WM8998/WM1814, no other codecs have
this shifted-bit-position problem. This shouldn't happen for any
future codecs, so I don't feel like it's worth over-complicating it.
