From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoC: support more sample rates on
 raumfeld devices
Date: Wed, 13 Jan 2010 16:43:20 +0100
Message-ID: <20100113154320.GD9007@buzzloop.caiaq.de>
References: <1263378338-21791-1-git-send-email-daniel@caiaq.de>
	<20100113130208.GD27473@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CA01F10385A
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 16:43:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100113130208.GD27473@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 13, 2010 at 01:02:09PM +0000, Mark Brown wrote:
> On Wed, Jan 13, 2010 at 11:25:38AM +0100, Daniel Mack wrote:
> > Add support for sample rates other than 44100Khz on raumfeld audio
> > devices. Force the codec's supported sample rates as the table of
> > supported rates which is calculated at run-time does not suffice: if we
> > call snd_soc_dai_set_sysclk() at stream startup, half of the possible
> > rates are missing.
> 
> I'm not massively enthusiastic about this - 

Me neither, and I agree to your objections.

> I'd much rather be able to
> give the CODEC a hook to let it know what MCLK rates it can have and a
> callback to update them.  It's a perfect case for the clock API but of
> course we can't use that off-SoC :/

I thought about this too and disliked it as well. It would make the
codec be in charge of dealing with clock changes, which is - in this
case particularily at least - not apropriate as the codec is slave to
all clocks.

For this application, the codec driver would need to be as dumb as
possible: I would just get the information about which MCLK and LRCLK it
runs with and it could reject invalid configurations by return value.
But that would imply major changes to the clocking logic in the cs4270
driver, which is fine as-is when it acts as master.

I'm uncertain and hence I just went the other way which bypasses this
logic for now, also not to break existing platforms.

Daniel
