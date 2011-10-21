From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 21 Oct 2011 10:00:55 +0100
Message-ID: <20111021090054.GF3513@opensource.wolfsonmicro.com>
References: <1319121769.24621.130.camel@matrix>
 <CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
 <1319186260.24621.154.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319186260.24621.154.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 02:07:40PM +0530, Ashish Chavan wrote:
> On Thu, 2011-10-20 at 18:10 +0100, Girdwood, Liam wrote:

> > Any reason for not using DAPM here ? Otherwise they are always on
> > making your chip burn mW.....

> Not really. As explained in the comment in DAPM patch, this enables will
> be effective (burn mW) only after respective IO is taken out from
> STANDBY mode. DAPM takes care of managing STANDBY mode for all IOs and
> ADC/DAC. I know this way of handling low power mode is bit non-trivial,
> but it is what is recommended by chip designers. Actually Mark was also
> initially confused with this and requested to put enough documentation
> into code. After that I tried explaining the logic in source code
> comment in DAPM patch. Let me know if it is not clear and doesn't convey
> clearly what is should.

That'd be fine but there's no DAPM code in the patch, only code to
unconditionally enable on init.
