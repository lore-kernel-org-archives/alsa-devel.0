From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Fri, 6 Nov 2009 15:00:14 +0000
Message-ID: <20091106150013.GA27699@rakim.wolfsonmicro.main>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
	<1257432930.3603.902.camel@odin>
	<20091105212822.2fab9974.jhnikula@gmail.com>
	<1257451710.3576.292.camel@odin>
	<20091106132024.GA4938@sirena.org.uk>
	<1257517520.3624.564.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD00424737
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 16:00:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257517520.3624.564.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2009 at 02:25:20PM +0000, Liam Girdwood wrote:

> static inline int snd_soc_get_framesize(int clock, struct snd_pcm_hw_params *params);

That's roughly what I'm thinking of too - it doesn't even need to take
the clock in since the frame size is unrelated to the clock in (and the
calculation is also useful for devices which have FLLs they can use to
vary the system clock to meet their bit clock requirements).  We'd also
want a versions that takes the TDM parameters in for use when
configuring that.

I'll pull the relevant code out of some of my drivers sometime over the
next few days.

Most of the devices I've seen that couldn't use this stuff at all
actually need to maintain some sample rate ratio for their master clock
and don't need to worry about BCLK since the fs restriction usually
takes care of it.

> static inline int snd_soc_get_divider(int clock, struct snd_pcm_hw_params *params);

This one I'm less sure about, partly due to naming but also because it
tends to be where you end up with restrictions that'd need handling in
drivers - I'm not sure that you'd save anything that wasn't already
saved with the above two functions.
