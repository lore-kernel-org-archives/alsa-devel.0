From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: No device for DAI %s
Date: Mon, 6 Sep 2010 09:32:59 +0100
Message-ID: <20100906083259.GF8381@sirena.org.uk>
References: <AANLkTikksq9W+x7T2GqFDfZZOUvOVg0XD3Nmo=ATzw=f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BCAE1037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 10:33:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikksq9W+x7T2GqFDfZZOUvOVg0XD3Nmo=ATzw=f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Doyle <wpdster@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 05, 2010 at 01:59:27PM -0400, Patrick Doyle wrote:

Please always remember to CC maintainers on kernel related mail.

> I am curious -- what is the intent of that warning message?  If the
> device "should become mandatory over time" when will that happen
> (obviously, when the developer of a particular device makes it
> happen), but what would motivate the developer to do so?  If I am that

Eventually the motivation would be that the device would become
mandatory and the driver would stop working.  And indeed this has
already happened with current ASoC.

> developer, and I am adapting code from another device, what do I need
> to do (and why should I do it) to associate a device with a DAI?

Fill in that pointer with the struct device you probed off.

> Actually, in a more general sense, is there any good
> article/book/tutorial/blog explaining the design and architecture of
> the SoC code in ALSA?  Right now, I am in a maze of little twisty
> passages, all alike, composed of calls to snd_soc_register_dai(),
> platform_register_driver(), platform_register_device, "soc-audio"
> platform drivers, i2s drivers, i2c drivers, etc... and would like to
> find something to help me pull my head back above water.  (Have I
> mixed enough metaphors here?)

Not outside the code.  Basically it's just the same as any other
subsystem: you probe off whatever bus your device is physically attached
to and then register with the subsystem.
