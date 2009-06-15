From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: About amp driver
Date: Mon, 15 Jun 2009 12:39:08 +0100
Message-ID: <20090615113907.GD6106@sirena.org.uk>
References: <4A35FE49.4090805@samsung.com>
	<20090615090756.GA6106@sirena.org.uk>
	<4A362D69.2010609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 64164103809
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 13:39:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A362D69.2010609@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 08:15:53PM +0900, Joonyoung Shim wrote:

> The lm4857 amp driver is a complete i2c driver seperated in neo1973_wm8753.c.
> It makes me confused that two complete drivers exist in a same file.
> The controls of the lm4857 amp driver is depended only by neo1973 machine
> driver because of registration through init() of snd_soc_dai_link.

Yes, there's no need for the lm4857 code to be in the machine driver and
it could be split out as I'm suggesting that you do for your system,
putting it in sound/soc/codecs.  This will help you share code and will
mean that once the core is enhanced to support this it's more
straightforward to convert the driver to use the standard stuff.

We could create a separate directory for amplifiers but I'm not sure
it's worth it since it'd just be a little more effort to classify
everything.

> I considered following some modification to solve this dependency.
> For example, the amp_init field is added in snd_soc_dai_link struct and the
> machine driver assigns the init function of amp driver in amp_init field of
> dai_link, and snd_soc_init_card() calls amp_init() of dai_link as init() call
> in soc-core.

> Is this wrong solution?

This isn't sufficiently abstracted to cover the general case.  We really
need to be able to cope with having multiple chips that handle analogue
as CODECs do, and to be able to cope with multiple chips of the same
model (which we can't do at the minute).  For the simple amplifier case
I'm not sure there's enough win putting something in the core that'll
need backing out later compared to just having direct calls from the
machine drivers.  It's not much more code for the machine drivers (a
couple of lines more for an error check as opposed to a line for the
assignment) but perhaps there's some extra hassle I'm missing.

For an example of the general case if you look at the wm9081 driver
you'll see that it's a mono DAC with integrated speaker amplifier.
Since it supports reading the input data from either the left or right
channel of stereo input data it is possible to make a stereo speaker
driver by using two of them.  Even with a fairly simple analogue
amplifier with just a volume register you could see a system having two
of them to provide stereo.
