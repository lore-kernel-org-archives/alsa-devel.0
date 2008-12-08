From: Daniel Mack <daniel@caiaq.org>
Subject: Re: ASoC: hook for codec control updates and
	clock	controls
Date: Mon, 8 Dec 2008 01:04:50 +0100
Message-ID: <20081208000450.GA30181@buzzloop.caiaq.de>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id DC4772412E
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 01:04:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081207190239.GA4457@sirena.org.uk>
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

Hi Mark,

On Sun, Dec 07, 2008 at 07:02:40PM +0000, Mark Brown wrote:
> On Sun, Dec 07, 2008 at 06:38:25PM +0100, Daniel Mack wrote:
> 
> > mixers to work, however, the I2S input clock is needed which is 
> > currently only true when the DAC/ACD elements are active but not when
> > the chip is just operating as an analog mixer.
> 
> What exactly do you mean when you say "I2S clock input" here?  An I2S
> link has two clocks, a bit clock and a frame clock and most codecs also
> use a third, master, clock which is not associated directly with an I2S
> link.  I suspect that the requirement is for the master clock...

Yes, correct. It's about the master clock. The internal mechanisms seem
to count in multiples of Fs, but this one is also derived from the
master clock (called MCLK here).

> The clocking is the responsibility of the board driver - often the
> clocks are disabled while the link is inctive but this up to the board
> driver (and ultimately the hardware design).

That makes sense. However, there is this special case I'm facing here -
the codec's volume settings are updated and the board driver doesn't
notice that, so it can't react and switch on the clock for some time.

> > Adding a hook to struct snd_soc_codec which is called from
> > snd_soc_update_bits() isn't a big deal, but the problem is the
> > abstraction layers in this case - for good reasons, the cpu_dai is not
> > accessible from the codec dai. Or did I miss a link?
> 
> You'll be able to get there since the card is accessible but it's
> unacceptable for the codec driver to go fiddling with other parts of the
> link like you're suggesting here - it doesn't have enough information
> about the system to know what to do.  The clocking for the bus could be
> shared with other devices, the clocks could be provided by other devices
> or the codec itself could be the clock master.

Sorry for not being precise enough here. In our case, the codec is slave
and all clocks are provided by the I2S master, which is a PXA processor.

The idea is to provide a way for codecs to signal the need for the
master clock (or whatever clock) to be applied externally. And it's
actually not important what it takes to actually do that - a generic way
the board support code can use would be good.

Is such an aproach feasible?

Best regards,
Daniel
