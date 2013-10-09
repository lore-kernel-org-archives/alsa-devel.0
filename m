From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC] ASoC: pcm: Trigger all commands on error
Date: Wed, 9 Oct 2013 16:12:42 +0200
Message-ID: <20131009141242.GE19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
 <20131008104457.GA21581@sirena.org.uk>
 <20131009130553.GD19005@pengutronix.de>
 <20131009132004.GL21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EC9E02654C2
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 16:12:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131009132004.GL21581@sirena.org.uk>
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

On Wed, Oct 09, 2013 at 02:20:04PM +0100, Mark Brown wrote:
> On Wed, Oct 09, 2013 at 03:05:53PM +0200, Markus Pargmann wrote:
> > On Tue, Oct 08, 2013 at 11:44:57AM +0100, Mark Brown wrote:
> 
> > > Right, but then _STOP will be called without the clock having been
> > > successfully enabled so you'll have an unbalanced clk_disable().
> 
> > _STOP is only called as long as the error handling is not working
> > properly. Otherwise STOP should not be called for a failed START.
> 
> I'm not sure what you mean here.  How would the error be handled without
> calling _STOP?

The START error should be handled in mxs_saif and there shouldn't be a
_STOP call for mxs_saif_trigger afterwards to handle the failed START.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
