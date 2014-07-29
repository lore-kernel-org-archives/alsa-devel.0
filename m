From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: wm8962: Let CODEC driver enable
 and disable its own MCLK
Date: Tue, 29 Jul 2014 18:19:51 +0800
Message-ID: <20140729101950.GB5495@MrMyself>
References: <1406547718-21498-1-git-send-email-nicoleotsuka@gmail.com>
 <20140728122211.GS17528@sirena.org.uk>
 <CAOMZO5DgE9RjC9MG7FbGPKwsgxunntw70W6Sj8WQKFYG+j8BsA@mail.gmail.com>
 <20140729025518.GB3350@MrMyself> <20140729095203.GK17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140729095203.GK17528@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, b02247@freescale.com, linux-kernel <linux-kernel@vger.kernel.org>, Nicolin Chen <b42378@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 29, 2014 at 10:52:03AM +0100, Mark Brown wrote:
> On Tue, Jul 29, 2014 at 10:55:19AM +0800, Nicolin Chen wrote:
> > On Mon, Jul 28, 2014 at 03:19:43PM -0300, Fabio Estevam wrote:
> 
> > > >> +     pdata->mclk = devm_clk_get(&i2c->dev, NULL);
> 
> > > > This is broken for deferred probe.
> 
> > Sorry. I don't get why deferred probe would be broken by this.
> > And I just took a test by adding this:
> 
> I don't see the code that actually pays attention to the return value
> from devm_clk_get() - in the main probe function the code just treats
> all errors as a missing MCLK.

Just checked the clk_get() code and got the point.

I will add a check to it and return for EPROBE_DEFER.

Thank you,
Nicolin
