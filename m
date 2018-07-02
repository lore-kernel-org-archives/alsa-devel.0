From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
Date: Mon, 02 Jul 2018 12:15:03 +0200
Message-ID: <1530526503.2900.144.camel@baylibre.com>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
         <20180630172241.10806-3-jbrunet@baylibre.com>
         <20180702101222.GF18211@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702101222.GF18211@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-07-02 at 11:12 +0100, Mark Brown wrote:
> On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:
> 
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_I2S:
> > +	case SND_SOC_DAIFMT_LEFT_J:
> > +		break;
> 
> These two modes are not the same so either there should be some
> different handling to select between them or one shouldn't be supported.
> 
> Otherwise this looks good.

Actually, the difference is provided with some pull-up/pull-down resistor.
There no way to set this up in SW, AFAIK.
So the driver shall accept both and trust we are not doing anything crazy
