From: Daniel Mack <daniel@caiaq.org>
Subject: Re: ASoC: hook for codec control updates and
	clock	controls
Date: Mon, 8 Dec 2008 13:18:55 +0100
Message-ID: <20081208121855.GA4063@buzzloop.caiaq.de>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
	<20081208094843.GA7094@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2150F103828
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 13:18:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081208094843.GA7094@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 09:48:43AM +0000, Mark Brown wrote:
> > That makes sense. However, there is this special case I'm facing here -
> > the codec's volume settings are updated and the board driver doesn't
> > notice that, so it can't react and switch on the clock for some time.
> 
> The normal thing would be to never turn off the master clock.  This is a
> very common setup - many systems will have a dedicated crystal for the
> codec which can never be disabled.  Do you actually need to turn off the
> clock (and are you sure that the codec is happy about that)?

The codec is happy about that, yes. And switching off the clock was
planned to save some power, but the more I think about it, the more I
tend to leave the clock running all the time.

In general, this chip has two purposes: one is an analog mixer and the
other is a codec, and the clock is only needed when the DAC/ADC is in
use or (for a short period) when new mixer values are written.

> > The idea is to provide a way for codecs to signal the need for the
> > master clock (or whatever clock) to be applied externally. And it's
> > actually not important what it takes to actually do that - a generic way
> > the board support code can use would be good.
> 
> This would need to at least specify the clock that needs to be turned
> on and how many cycles it needs to be turned on for.  I'm having a hard
> time getting enthusiastic about that, it seems like too much software
> especially since we can't use the clock API for any of this due to the
> inconsistent implementations.

That's why I was thinking about a general purpose callback mechanism
like the one Jarkko suggested.

> In what circumstances does the codec need the clock?  What are the
> negative consequences of it not being enabled? 

If the clock is not enabled, changes in volume registers are not applied
to the actual mixers in hardware, e.g., the gain setting does simply not
happen.

We'll think about how much disadvantage it is to keep the clock running
all the time.

Thanks,
Daniel
