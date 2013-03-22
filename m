From: Daniel Mack <zonque@gmail.com>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 09:55:20 +0100
Message-ID: <514C1C78.3090702@gmail.com>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 22.03.2013 09:48, Peter Meerwald wrote:
> I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
> channel swapping issue on playback of a stereo stream (one channel has a 
> sine, the other is zero); the channel swap occurs on starting the playback

Always? Or in like 50% of the runs? And is the record stream (IOW: the
clocks) already running when you switch on playback?

Maybe it's unreleated, but your report reminded me of this commit, which
fixed a similar bug for pxa socs: 273b72c8c ("ASoC: pxa-ssp: atomically
set stream active masks").


Daniel

