From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
 Instruments tlv320dac33 codec
Date: Wed, 14 Oct 2009 14:24:02 +0100
Message-ID: <20091014132402.GF20639@rakim.wolfsonmicro.main>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091014111409.GE20639@rakim.wolfsonmicro.main>
	<200910141556.50396.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 458442439F
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 15:24:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910141556.50396.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 14, 2009 at 03:56:50PM +0300, Peter Ujfalusi wrote:

> > It'd be nice to do the full power down in BIAS_OFF for future use.

> The full power off is taken when the dac33_soc_suspend is called (the hard_power 
> is restored in the dac33_soc_resume function).
> I can move it here, than add dac33_hard_power(codec, 1) to _PREPARE, if the 
> previous state was _OFF.

_STANDBY but yes.

> Than I can remove the dac33_soc_suspend and dac33_soc_resume?

No, the core won't take you down to BIAS_OFF automatically except during
shutdown (or suspend to disk but ARM doesn't do that).  Which is fun but
it's entertaining to change since it touches all the drivers.  It's
where we should go, though - I've been trying to do this when I write
new drivers.

> > I'd also expect to see something that either acknowledges the interrupt to
> > deassert it or

> The interrupt is self cleaning on dac33 side (in the mode, which we are using 
> it, there is a mode, where additional write is needed to clear the interrupt 
> status).

That should be OK, someone can always add level triggering in future if
they want to.

> Than on trigger STOP, I set the state to FLUSH and schedule the work, if an 
> interrupt comes, it is ignored, since the work has been scheduled.

Actually, you should just be able to queue the work since the state
check will be done again in the workqueue and duplicate insertions don't
hurt.  That'd also avoid the need to mask IRQs while fiddling with the
state (which you're not doing at the minute but probably need to).
