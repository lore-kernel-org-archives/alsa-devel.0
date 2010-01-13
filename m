From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: support more sample rates
	on	raumfeld devices
Date: Wed, 13 Jan 2010 16:27:50 +0000
Message-ID: <20100113162749.GA26519@sirena.org.uk>
References: <1263378338-21791-1-git-send-email-daniel@caiaq.de>
	<20100113130208.GD27473@rakim.wolfsonmicro.main>
	<20100113154320.GD9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 30846103851
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 17:27:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100113154320.GD9007@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 13, 2010 at 04:43:20PM +0100, Daniel Mack wrote:

> For this application, the codec driver would need to be as dumb as
> possible: I would just get the information about which MCLK and LRCLK it
> runs with and it could reject invalid configurations by return value.
> But that would imply major changes to the clocking logic in the cs4270
> driver, which is fine as-is when it acts as master.

That's not quite true.  The problem you're seeing is that the CODEC
driver has variable constraints depending on the master clock, so it at
least needs to know what master clocks it might get so it can specify
the constraints.  Even more ideally than what I suggested we'd be able
to use a clock API with constraint handling which we could use to figure
stuff out but obviously tackling that is very much an uphill struggle.

> I'm uncertain and hence I just went the other way which bypasses this
> logic for now, also not to break existing platforms.

It doesn't do anything for maintainability of the stack, though,
especially if other people try to copy it.

If you're going to do anything that doesn't involve the core API I'd
have the CODEC driver manually apply the constraints from MCLK in the
startup function iff an MCLK is currently set.  Machines with fixed
MCLKs can set the MCLK on init() and machines with dynamic MCLKs can set
the value in hw_params() and reset it when shutting down, imposing any
constraints that do exist themselves.  The rates fixed in the DAI would
be all the rates that can possibly be used.
