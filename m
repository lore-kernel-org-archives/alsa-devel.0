From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Wed, 9 Oct 2013 15:05:53 +0200
Message-ID: <20131009130553.GD19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B41BC2610A3
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 15:05:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131008104457.GA21581@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 08, 2013 at 11:44:57AM +0100, Mark Brown wrote:
> On Tue, Oct 08, 2013 at 11:48:39AM +0200, Markus Pargmann wrote:
> > On Tue, Oct 08, 2013 at 10:34:13AM +0100, Mark Brown wrote:
> 
> > > I meant just unwinding the things done in the trigger call.
> 
> > You mean unwinding when we detect the error? If we return the
> > error code from the trigger function, the pcm_native.c will still
> > trigger a STOP command which is executed on all components.
> 
> Sure, but it's another way of getting consistency and does seem a bit
> more obvious.

It is still not consistent as we get an additional STOP after cleanly
unwinding the START:

snd_pcm_do_start()
    soc_pcm_trigger() # START
        codec_dai->driver->ops->trigger() # START
	platform->driver->ops->trigger() # Assuming an error here

	unwind:
        codec_dai->driver->ops->trigger() # STOP

A failed snd_pcm_do_start() is detected, so undo_start is called:

snd_pcm_undo_start()
    soc_pcm_trigger() # STOP
        codec_dai->driver->ops->trigger() # STOP
	platform->driver->ops->trigger() # STOP
	cpu_dai->driver->ops->trigger() # STOP

Now all component trigger functions are called without a matching START
command.

> 
> > > > Another possibility is to explicitly allow multiple _STOPs. Then I could
> > > > fix the driver to store the clock state. But I would prefer a generic
> > > > solution.
> 
> > > You're going to have to handle this anyway to be robust - what happens
> > > if it's the clock enable that fails?
> 
> > If clk_enable fails, we can return an error code in the mxs-saif trigger
> > function. Of course the error handling is missing here, but it is not
> > necessary to store the state of the clock to handle errors properly.
> 
> Right, but then _STOP will be called without the clock having been
> successfully enabled so you'll have an unbalanced clk_disable().

_STOP is only called as long as the error handling is not working
properly. Otherwise STOP should not be called for a failed START.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
