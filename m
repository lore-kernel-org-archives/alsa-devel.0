From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Tue, 6 Oct 2009 11:20:34 +0100
Message-ID: <20091006102033.GC27168@sirena.org.uk>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D189424133
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 12:20:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, Barry Song <21cnbao@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 05, 2009 at 08:18:03PM -0400, Mike Frysinger wrote:
> am i doing something wrong or are the dev_* output functions kind of
> useless with ASoC codecs ?  it seems like the error output is prefixed
> by the generic "soc-audio" but no info related to the exact codec is
> included.

You're missing something here.

> as an example, the typical behavior is for the machine driver to call
> platform_device_alloc("soc-audio", -1).  this struct device is then

This is the device for the ASoC card, not for the CODEC.  The ASoC card
is built up from several different devices, the main ones being the
devices for the CPU and for the CODEC.

> passed down to the relevant subsystem driver register/probe
> (i2c/spi/etc...) to the codec driver.  these functions typically then
> set the snd_soc_codec's dev member to the allocated platform device.

No, nothing should ever be setting codec->dev to the soc-audio device.
If anything is that's a bug and should be fixed.  That should be set to
whatever the device model struct device is for the CODEC, normally an
I2C or SPI device.

> if there are multiple codecs, things obviously fall apart quickly.
> the question is how to address this.  werent there snd_* output funcs
> before ?  or are those now deprecated/dead ?  or perhaps we should

Those have never really been used within ASoC.

> encourage people to stop doing platform_device_alloc("soc-audio") and
> start doing platform_device_alloc(snd_soc_card.name) ?

At some point, probably before the end of the year, it should be
possible to have any device registered as the card.  However, this is a
separate issue to the device used for the CODEC itself.

> also, there seems to be a semi-common bug in the codec/machine drivers
> where they dont actually initialize the dev member.  perhaps it's time
> to upgrade the snd_soc_register_codec() check from a KERN_WARNING to a
> BUG_ON() ?  clearly the current warning isnt getting its message
> through ...

That would make all the existing drivers instabuggy which isn't a
helpful way of dealing with things.  At some point where this becomes a
blocker to doing further core work someone will have to go through and
convert all the remaining CODEC drivers over to use the device model.
The main problem here is that most of the affected CODEC drivers are
essentially unmaintained.
