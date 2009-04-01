From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Wed, 1 Apr 2009 16:24:22 +0100
Message-ID: <20090401152421.GC21294@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk> <49D374CD.20401@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B2A8124418
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 17:24:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D374CD.20401@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl?ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 01, 2009 at 04:06:05PM +0200, Daniel Gl?ckner wrote:
> On 04/01/2009 02:10 PM, Mark Brown wrote:

> > Hrm, does the chip support asymmetric configurations for playback and
> > capture?

> No, why do you ask?

In that case rather than using a trigger to check if the device is
running it should be possible to use constraints to prevent
reconfiguration of the device when it's not supported - this is more
friendly to apps since they know they won't be allowed to change the
configuration.

> >> + * Enables or disables the left/right ADC/DAC according to new.
> >> + * Bits in new:

> > Is this really required?  I can't see it being a good idea to bounce the
> > power of the DAC or ADC while they are live since that will impact the
> > audio stream noticably.  It looks like it'd be better to do a check
> > which refuses to do the reconfiguration when it's not possible.

> Powering off is required in case the stream has been closed previously but the
m close_delayed_work has not yet been run. That was the case where I observed the
> problems this patch tries to fix.

Eew, right.  This should go in the comments.

> > It's especially suspicious since the power of the DAC and ADC is managed
> > via DAPM; the only current user should be safe since it saves then
> > restores the state but it does raise alarm bells.

> How about making it a function that always disables the four components and
> referring to snd_soc_dapm_sync to restore the state?

Hrm.  For the ADC that's probably OK but powering off the DAC does risk
being audible in the output; that does depend on the hardware, though.
It should do the right thing, I think, but checking for audio artefacts
would be advisable.

It'd probably also help to only do reconfiguration if actually required
rather than always powering down the ADCs and DACs.

> In this version of the patch I removed the line that restores the state when
> setting the sampling rate failed in-between. Is it safe to assume that DAPM will
> not enable the ADC/DAC on other occasions before a valid sampling rate has been

You should always get a chance to do a configuration before the DAC or
ADC is enabled, yes.

> configured? One could reorder aic3x_hw_params to detect the error before the
> first registers are written..

Yes.
