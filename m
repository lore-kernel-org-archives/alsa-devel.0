From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Does LKML accept non-ASOC audio driver?
Date: Thu, 18 Sep 2008 12:33:55 +0100
Message-ID: <20080918113354.GC4203@sirena.org.uk>
References: <48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
	<20080917153029.GD7679@sirena.org.uk> <48D130BD.3060005@atmel.com>
	<20080917163537.GF7679@sirena.org.uk>
	<BAY110-W332FD6EFAA8BBE246EDD7DC94F0@phx.gbl>
	<20080918092135.GA4203@sirena.org.uk>
	<BAY110-W448DBD74086F0CC723FA67C94F0@phx.gbl>
	<20080918101743.GB4203@sirena.org.uk>
	<BAY110-W35E0C694DFC04076A4E353C94F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7820124340
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 13:33:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BAY110-W35E0C694DFC04076A4E353C94F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cliff Cai <xcahua@hotmail.com>
Cc: alsa-devel@alsa-project.org, cooloney@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2008 at 11:01:07AM +0000, Cliff Cai wrote:

> > outside of ASoC with just a platform data hook for doing the codec
> > initialisation would probably be the best bet.  Could you point me at
> > the existing drivers?

> One thing I should let you know ,the initialisation code will highly depend
> on the low-level SPORT operation code in blackfin arch. 

That's absolutely fine - the machine driver is entirely specific to the
hardware it's connecting so things like this are not a problem.  It
already explicitly references the codec and machine drivers anyway.

> > Actually, looking at the datasheet for the AD73311 it is actually
> > possible to reconfigure the codec at run time at the expense of one data
> > bit.

> You are right,but it's not a good way in real use,since we need to format every
> PCM sample in that mode.

Yeah, without trusting the application data to leave the bit clear it'd
need some glue in hardware to force the MSB low when not doing control
operations.
