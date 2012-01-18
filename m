From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Wed, 18 Jan 2012 13:17:31 +0000
Message-ID: <20120118131731.GO8732@opensource.wolfsonmicro.com>
References: <1326371061.17726.30.camel@matrix>
	<20120112185257.GB9661@sirena.org.uk>
	<1326893178.16299.10.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A071C10383B
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 14:17:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326893178.16299.10.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 06:56:18PM +0530, Ashish Chavan wrote:

> > > +static int da7210_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
> > > +				 int div_id, int div)

> > Why does the driver need the machine driver to manually configure clock
> > dividers?

> Do you mean that the input mclk value should be passed via platform data
> and driver should use it from there during initialization?

No, it should be configured using set_sysclk() like for all the other
CODEC drivers.  The problem is that everyone using the driver needs to
know all the dividers in the chip.
