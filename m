From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dapm_reg_event, etc
Date: Wed, 23 Jul 2008 22:26:14 +0100
Message-ID: <20080723212613.GB9895@sirena.org.uk>
References: <9e4733910807231234r10ae0b5erb6044667c0cb090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 888A72412E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 23:26:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807231234r10ae0b5erb6044667c0cb090@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 03:34:38PM -0400, Jon Smirl wrote:
> I modified Kconfig to build all of the codecs. That exposed a couple
> more errors.
> 
> tlv320aic3x won't build . dapm_reg_event() is missing from soc_dapm.h:

This has been fixed in the dev branch for a while and there's a version
of the fix already queued for Takashi.

> and there is another error in my patch:

Oh, right.  I've meged this now - thanks.

> And the AC97 codec won't link, not sure why.

You need an AC97 bus driver for them to link.
