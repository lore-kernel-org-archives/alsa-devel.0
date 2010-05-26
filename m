From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
 default registers
Date: Tue, 25 May 2010 23:35:00 -0700
Message-ID: <20100526063459.GA16085@opensource.wolfsonmicro.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274792996.3000.233.camel@odin>
	<201005260900.35587.peter.ujfalusi@nokia.com>
	<201005260928.50075.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F1FE24679
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 08:34:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005260928.50075.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 09:28:49AM +0300, Peter Ujfalusi wrote:

> Better thing to do is:
> restore the registers in these cases:
> if (!setup || (setup && setup->reset_registers))

> So if the machine does not provide setup data, than we can assume, than no one 
> taken a time to tune the platform, so we need to restore to be on the safe side.

> What do you think?

This sounds like a sensible optimisation.  May also be an idea to
explicitly do a reset of the registers on unload - I guess nobody will
ever do that if they're not developing, and that'd probably mean that
many of the people who might actually need to reset the registers purely
for development will get the benefit of it without the risk of leaving
the option on in production by mistake.

I can't remember if you're doing this already (and don't even know if
it's possible with the hardware) but if you can do a bulk read of the
registers rather than reading register by register then the overhead
from the I/O should be noticably reduced if you do do the reset.
