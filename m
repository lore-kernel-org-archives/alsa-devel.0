From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC
	while	changing clock
Date: Wed, 1 Apr 2009 17:48:47 +0100
Message-ID: <20090401164847.GE21294@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
	<20090401121032.GA21294@sirena.org.uk> <49D374CD.20401@emlix.com>
	<20090401152421.GC21294@sirena.org.uk> <49D3947F.3010805@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B20A24446
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 18:48:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D3947F.3010805@emlix.com>
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

On Wed, Apr 01, 2009 at 06:21:19PM +0200, Daniel Gl?ckner wrote:
> On 04/01/2009 05:24 PM, Mark Brown wrote:
> > In that case rather than using a trigger to check if the device is
> > running it should be possible to use constraints to prevent
> > reconfiguration of the device when it's not supported - this is more
> > friendly to apps since they know they won't be allowed to change the
> > configuration.

> It was my impression that it is up to the pcm part to install these
> constraints as this is where SNDRV_PCM_INFO_JOINT_DUPLEX can be put into
> the snd_pcm_hardware structure.

JOINT_DUPLEX is just a hint to the application about how the card will
behave - you still need to enforce the actual constraints you have in
the driver.  In any case, the PCM driver shouldn't be setting that
unless it has such a constraint itself since it should work with the
widest possible range of systems.

> > Hrm.  For the ADC that's probably OK but powering off the DAC does risk
> > being audible in the output; that does depend on the hardware, though.
> > It should do the right thing, I think, but checking for audio artefacts
> > would be advisable.

> I can't hear any artefacts with my cheap headphones.
> The delayed close is audible, though.

Probably due to something else in the output path powerdown (eg, the
output stages).  If it happens without the change to power down the DAC
it's a separate issue :)

> - and one to fix the bug

This sounds like a good plan.  Please put something explaining the
failure scenario in the comments so anyone pulling the PLL configuration
out for machine drivers doesn't get suprised by this.
