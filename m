From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Wed, 18 Jan 2012 18:56:18 +0530
Message-ID: <1326893178.16299.10.camel@matrix>
References: <1326371061.17726.30.camel@matrix>
	<20120112185257.GB9661@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id DE2892463C
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 14:14:26 +0100 (CET)
In-Reply-To: <20120112185257.GB9661@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > +static int da7210_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
> > +				 int div_id, int div)
> 
> Why does the driver need the machine driver to manually configure clock
> dividers?

Do you mean that the input mclk value should be passed via platform data
and driver should use it from there during initialization?

> This isn't great, you're indexing into a table of divisors using raw
> numeric constants in a totally separate part of the code.  Worse, these
> constants aren't even directly used but have a calculation applied to 
> them apparently because this is really a multi dimensional array.  This
> isn't great for either legibility or robustness.
> 
> Fix this to remove the use of magic numbers, for example by putting
> fout and fref into the table and searching for them.
> 

OK, will take care of that.
