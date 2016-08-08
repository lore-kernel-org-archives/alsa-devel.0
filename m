From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [alsa-devel] [PATCH 3/4] ASoC: da7213: Refactor sysclk(), pll()
 functions to improve handling
Date: Mon, 8 Aug 2016 10:32:05 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D464B97E@SW-EX-MBX01.diasemi.com>
References: <cover.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
 <c49bf78ac801dfd1fd1fa41d5e65d866fd30a177.1470318378.git.Adam.Thomson.Opensource@diasemi.com>
 <alpine.DEB.2.02.1608080940020.17128@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1608080940020.17128@pmeerw.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08 August 2016 08:43, Peter Meerwald-Stadler wrote:

> > Currently the handling of the PLL in the driver is a little clunky,
> > and not ideal for all modes. This patch updates the code to make it
> > cleaner and more sensible for the various PLL states.
> >
> > Key items of note are:
> >  - MCLK squaring is now handled directly as part of the sysclk()
> >    function, removing the need for a private flag to set this feature.
> >  - All PLL modes are defined as an enum, and are handled as a case
> >    statement in pll() function to clean up configuration. This also
> >    removes any need for a private flag for SRM.
> >  - For 32KHz mode, checks are made on codec master mode and correct
> >    MCLK rates, to avoid incorrect usage of PLL for this operation.
> >  - For 32KHz mode, SRM flag now correctly enabled and fout set to
> >    sensible value to achieve appropriate PLL dividers.
> 
> thanks, looks good
> Tested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> 
> nitpick: add extra newline at the end of
> if (da7213->mclk_rate == 32768) block
> 

Thanks. Glad the patch set has resolved issues you were seeing. Patches have
been pulled by Mark.
