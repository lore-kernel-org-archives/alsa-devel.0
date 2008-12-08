From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: hook for codec control updates and clock
	controls
Date: Mon, 8 Dec 2008 12:40:48 +0000
Message-ID: <20081208124048.GI5159@sirena.org.uk>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
	<20081208094843.GA7094@sirena.org.uk>
	<20081208121855.GA4063@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9ED103832
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 13:40:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081208121855.GA4063@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 01:18:55PM +0100, Daniel Mack wrote:
> On Mon, Dec 08, 2008 at 09:48:43AM +0000, Mark Brown wrote:

> > This would need to at least specify the clock that needs to be turned
> > on and how many cycles it needs to be turned on for.  I'm having a hard
> > time getting enthusiastic about that, it seems like too much software
> > especially since we can't use the clock API for any of this due to the
> > inconsistent implementations.

> That's why I was thinking about a general purpose callback mechanism
> like the one Jarkko suggested.

Hrm?  I'm talking about the form such a mechanism would take.  Like I
say, I think it would be likely to be more trouble than it's worth.

> > In what circumstances does the codec need the clock?  What are the
> > negative consequences of it not being enabled? 

> If the clock is not enabled, changes in volume registers are not applied
> to the actual mixers in hardware, e.g., the gain setting does simply not
> happen.

> We'll think about how much disadvantage it is to keep the clock running
> all the time.

Note that I also suggested that leaving the clocks on while the analogue
paths are enabled by ensuring that the DAPM bias configuration covers
those and then using the machine bias callback; this would turn the
clocks off when there's no audio which is likely to be all you need
since the amplifiers will probably burn enough power to make the cost of
the clock irrelevant.

We should be bringing the bias up to ON with analouge only paths anyway
so this is a low cost approach.
