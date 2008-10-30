From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-ssp
Date: Thu, 30 Oct 2008 12:06:34 +0000
Message-ID: <20081030120634.GD5747@sirena.org.uk>
References: <1224809675.8330.4.camel@brutus>
	<1224863678.28382.54.camel@dell-desktop.example.com>
	<1224912767.5426.19.camel@brutus>
	<20081027124705.GE5896@sirena.org.uk>
	<1225113574.9922.10.camel@brutus>
	<20081027134407.GF5896@sirena.org.uk>
	<1225366817.12583.28.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C0D57243A4
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 13:06:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225366817.12583.28.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 09:40:17AM -0200, Daniel Ribeiro wrote:

> 	Here are my test results for stereo S16_LE audio:

> 	set_tdm_slot(cpu_dai, 1, 2), SSCR0_Datasize(16):
> 	Only left channel works.

> 	set_tdm_slot(cpu_dai, 2, 2), SSCR0_Datasize(16):
> 	No I/O.

Could you expand on what you mean by "No I/O" here - do you get silent
output or does DMA not work either?

> 	set_tdm_slot(cpu_dai, 3, 2), SSCR0_Datasize(16):
> 	Only left channel works.

> 	set_tdm_slot(cpu_dai, 1, 1), SSCR0_Datasize(16) | SSCR0_EDSS:
> 	Both channels work.

Just a thought, but you should also be able to get things working by
adding a constraint on the format in your machine driver to force use of
32 bit - see things like the WM8903 driver for examples of how to this.
Ideally that shouldn't be required, though.

> 	On my board CLK and FRM are driven by the codec, pxa is slave. I have
> no specs for the codec, only a 2.4 kernel driver that works with
> (SSCR0_Datasize(16) | SSCR0_EDSS | SSCR0_SlotsPerFrm(1)).

Which codec is this?  Could you post the driver?

BTW, your mail client is doing some really strange indentation here
and indenting the first line of each paragraph by a tab which looks like
how some other clients do quotation.
