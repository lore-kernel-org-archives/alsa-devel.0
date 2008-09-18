From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Does LKML accept non-ASOC audio driver?
Date: Thu, 18 Sep 2008 11:17:43 +0100
Message-ID: <20080918101743.GB4203@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
	<20080917153029.GD7679@sirena.org.uk> <48D130BD.3060005@atmel.com>
	<20080917163537.GF7679@sirena.org.uk>
	<BAY110-W332FD6EFAA8BBE246EDD7DC94F0@phx.gbl>
	<20080918092135.GA4203@sirena.org.uk>
	<BAY110-W448DBD74086F0CC723FA67C94F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 379ED1037F0
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 12:17:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BAY110-W448DBD74086F0CC723FA67C94F0@phx.gbl>
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

On Thu, Sep 18, 2008 at 09:48:20AM +0000, Cliff Cai wrote:

> Yes,the hardware doesn't have seperate codec control,
> we use the same bus as for DMA transmission to configure the codec( e.g.AD73311)

That shouldn't be an issue, AC97 does the same thing but...

> and after configuring it,the codec will enter data mode,and is not configurable any more.  

...this might be more of an issue.  That said, is the SPORT on the DSP
likely to be used with smarter codecs (it looks like it's already used
by your existing ASoC drivers but perhaps differently?)?  If it is then
it's probably worth fitting it in to ASoC in order to avoid having two
distinct drivers for it.  It should be possible for the machine driver
to do the codec setup when it probes and then just have a dumb DAI for
the codec with no operations (actually, it's worth adding that dumb
codec driver anyway - it's not like dumb ADCs and DACs are uncommon).

If there's not much code to reuse then a simpler driver for the SPORT
outside of ASoC with just a platform data hook for doing the codec
initialisation would probably be the best bet.  Could you point me at
the existing drivers?

Actually, looking at the datasheet for the AD73311 it is actually
possible to reconfigure the codec at run time at the expense of one data
bit.
