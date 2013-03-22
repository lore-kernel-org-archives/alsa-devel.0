From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 13:49:37 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303221348250.7975@pmeerw.net>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <514C2E5E.2040909@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> >> I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
> >> channel swapping issue on playback of a stereo stream (one channel has a 
> >> sine, the other is zero); the channel swap occurs on starting the playback
> > 
> >> it appears that the swapping issue is back, probably due to the DMA rework 
> >> in recent kernel?
> > 
> > kernel 3.4 does not have the issue
> 
> Well, then, I guess, you'll have to bisect it down.

here it is:
946cc36ae550ea52adee0f42ac5034a34b5393be is the first bad commit
commit 946cc36ae550ea52adee0f42ac5034a34b5393be
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Fri Sep 14 15:05:58 2012 +0300

    ASoC: omap-pcm: Convert to use dmaengine
    
    Original author: Russell King <rmk+kernel@arm.linux.org.uk>
    
    Switch the omap-pcm to use dmaengine.
    Certain features are not supported by after dmaengine conversion:
    1. No period wakeup mode
       DMA engine has no way to communicate this information through
       standard channels.
    
    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

-- 

Peter Meerwald
+43-664-2444418 (mobile)
