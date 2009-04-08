From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/6] ASoC: 4 channel support for
	twl4030	and omap-mcbsp
Date: Wed, 8 Apr 2009 10:53:30 +0100
Message-ID: <20090408095330.GC20122@sirena.org.uk>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090408092323.bb7f7d7e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3806F1037F9
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 11:53:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090408092323.bb7f7d7e.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 09:23:23AM +0300, Jarkko Nikula wrote:

> What's actually state of the TDM container format support in ASoC?

It's largely punted to the machine driver.

> I see there is that set_tdm_slot callback in struct snd_soc_dai_ops
> but only pxa-ssp.c is setting it currently.

Right.  A large proprortion of the Wolfson codecs could set it too, as
could many platforms that generate clocks manually, but it's not widely
used since there's relatively few use cases in public hardware.

> Am I correct that DSP_x, I2S are not multichannel but should be
> embedded into TDM if multichannel operation is wanted?

TDM mode is more intended for situations where a device is only going to
be paying attention to some of the timeslots - for example, if you have
a CPU, CODEC and baseband processor sharing one set of data lines and
want to send data between multiple devices.

For I2S the normal multichannel implementation is to use multiple data
lines with shared clock lines - there's no natural extension within the
one data line - so TDM mode would be needed.  For DSP mode there's a
more natural extension (just transmit additional channel data after the
final one, you're allowed extra bit clocks anyway) so it's less needed.

> So should Peter's these two patches take this API into use?

> "[PATCH 2/6] ASoC: OMAP mcbsp: Add 4 channel support"
> "[PATCH 6/6] ASoC: Beagle: Add support for 4 channel mode"

For DSP mode it's up to you; personally I wouldn't bother unless the
code supports ignoring some of the timeslots.  It's more likely that
any other devices sharing the DAI would need TDM to pick out or fill
the data streams relevant to them.
