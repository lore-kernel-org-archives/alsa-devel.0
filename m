From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: hook for codec control updates and
	clock	controls
Date: Sun, 7 Dec 2008 19:02:40 +0000
Message-ID: <20081207190239.GA4457@sirena.org.uk>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D49A1037F3
	for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2008 20:02:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081207173825.GB26551@buzzloop.caiaq.de>
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

On Sun, Dec 07, 2008 at 06:38:25PM +0100, Daniel Mack wrote:

> mixers to work, however, the I2S input clock is needed which is 
> currently only true when the DAC/ACD elements are active but not when
> the chip is just operating as an analog mixer.

What exactly do you mean when you say "I2S clock input" here?  An I2S
link has two clocks, a bit clock and a frame clock and most codecs also
use a third, master, clock which is not associated directly with an I2S
link.  I suspect that the requirement is for the master clock...

The clocking is the responsibility of the board driver - often the
clocks are disabled while the link is inctive but this up to the board
driver (and ultimately the hardware design).

> Adding a hook to struct snd_soc_codec which is called from
> snd_soc_update_bits() isn't a big deal, but the problem is the
> abstraction layers in this case - for good reasons, the cpu_dai is not
> accessible from the codec dai. Or did I miss a link?

You'll be able to get there since the card is accessible but it's
unacceptable for the codec driver to go fiddling with other parts of the
link like you're suggesting here - it doesn't have enough information
about the system to know what to do.  The clocking for the bus could be
shared with other devices, the clocks could be provided by other devices
or the codec itself could be the clock master.

> Is there a sane way to address this problem?

It does depend on what the actual requirement is here.  Which clock or
clocks are the issue?
