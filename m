From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Tue, 8 Oct 2013 11:48:39 +0200
Message-ID: <20131008094839.GB19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5007F265197
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 11:48:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131008093413.GX21581@sirena.org.uk>
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

On Tue, Oct 08, 2013 at 10:34:13AM +0100, Mark Brown wrote:
> On Tue, Oct 08, 2013 at 10:29:33AM +0200, Markus Pargmann wrote:
> 
> > To make proper error handling and only STOP functions that successfully
> > started, we have to store the state of each function. The command error
> > handling is done in pcm_native.c so we don't have any influence on that.
> 
> I meant just unwinding the things done in the trigger call.

You mean unwinding when we detect the error? If we return the
error code from the trigger function, the pcm_native.c will still
trigger a STOP command which is executed on all components.

> 
> > Another possibility is to explicitly allow multiple _STOPs. Then I could
> > fix the driver to store the clock state. But I would prefer a generic
> > solution.
> 
> You're going to have to handle this anyway to be robust - what happens
> if it's the clock enable that fails?

If clk_enable fails, we can return an error code in the mxs-saif trigger
function. Of course the error handling is missing here, but it is not
necessary to store the state of the clock to handle errors properly.

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
