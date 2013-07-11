From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on Exynos5420
Date: Thu, 11 Jul 2013 13:41:40 +0200
Message-ID: <2214161.FSfscAvpna@thinkpad>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com> <29860116.IF545KsGYb@thinkpad> <20130711112023.GM24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130711112023.GM24508@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Padmavathi Venna <padma.v@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, padma.kvr@gmail.com, sbkim73@samsung.com, kgene.kim@samsung.com, abrestic@chromium.org
List-Id: alsa-devel@alsa-project.org

On Thursday 11 of July 2013 12:20:23 Mark Brown wrote:
> On Thu, Jul 11, 2013 at 12:43:22PM +0200, Tomasz Figa wrote:
> > On Thursday 11 of July 2013 12:38:24 Padmavathi Venna wrote:
> > > +- samsung,supports-tdm: If the I2S controller supports TDM, then this
> > > flag
> > > +  must be enabled.
> > 
> > I think this should be rather handled by a different compatible value, not
> > a
> This is a bit of a larger project sadly, there was resistance to doing
> the DT bindings based on compatible strings using the IP version :(

I'm not sure if this case is related to this problem in any way. I just 
suggested introducing a new include like samsung,exynos5420-i2s, a opposed to 
using samsung,exynos5250-i2s and adding flags, since the I2S in Exynos5420 is 
the first one to have this TDM or whatever mode. (I'd still like to hear what 
it is...)

Best regards,
Tomasz
