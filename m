From: Greg Knight <g.knight@symetrica.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 13:48:08 -0400
Message-ID: <1426787288.13824.36.camel@symus-gk-mint>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com>
	 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
	 <550AF442.5040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <550AF442.5040203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> For a codec such as the SGTL5000 I would connect a clock, which is
running all
> the time. If you take a look at the driver, it enables the clock at
probe and
> leaves it running as long as the driver is loaded.

Speaking briefly to my "electrical" colleague, he's a bit concerned
about the extra power load that a crystal oscillator might incur, while
I'm concerned about audio quality from a source like CLKOUT2.

Is there a straightforward way we could enable the clock on-demand -
when we're communicating with the codec/mixer or actually using the
audio subsystem - while keeping it disabled when not in use? We don't
expect to be using the audio subsystem frequently.

Worst-case we can set up a GPIO and enable/disable it as needed in
user-space - acceptable, if annoying, for our application.

Thanks,
Greg

