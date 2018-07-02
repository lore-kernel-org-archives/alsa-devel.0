From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
Date: Mon, 02 Jul 2018 12:15:28 +0200
Message-ID: <1530526528.2900.145.camel@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
         <20180629150924.18197-6-jbrunet@baylibre.com>
         <20180702100533.GD18211@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702100533.GD18211@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-07-02 at 11:05 +0100, Mark Brown wrote:
> On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:
> 
> >  	{ .compatible = "everest,es7134", .data = &es7134_chip },
> >  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> > +	{ .compatible = "everest,es7154", .data = &es7154_chip },
> >  	{ }
> 
> This needs to be added to the DT documentation.

I believe I added this in patch 3 of this serie, which I'll resubmit.
Shall I resubmit this patch along with it ?
