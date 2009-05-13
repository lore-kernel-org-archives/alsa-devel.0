From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamically registering a codec
Date: Wed, 13 May 2009 23:44:24 +0100
Message-ID: <20090513224424.GB24973@sirena.org.uk>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 27B012434E
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 00:44:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 03:18:36PM -0400, Jon Smirl wrote:

> On PowerPC the device tree is used to dynamically load the correct
> codec module. How am I supposed to get this dynamically loaded module

For an AC97 CODEC in the standard configuration there should be no need
for the CODEC to appear in the device tree for it to be discovered.
However...

> registered? The WM8580 codec registers itself.

The CODEC driver should use the normal kernel APIs to get itself probed.

In the specific case of AC97 what ought to be happening is that the
CODEC driver is dynamically probed based on the ID registers (as the
non-ASoC AC97 core code does).  There's quite a bit of infrastructure
work that needs to be done on the AC97 bus to make that viable, though -
at the minute it doesn't support dynamic module loading and is only
used for secondary CODEC functions like touchscreens.  There doesn't
seem to be much prospect of anyone doing anything with this in the
immediate future, most of the PC side effort is on HDA these days and in
the embedded space the situation is similar and there's more urgent
things with AC97 like platform data that are likely to get dealt with
first.

What's happening at the minute for ASoC is that AC97 CODECs are not
required to be registered before the card instantiates.  A better
solution would involve having the AC97 controllers probed for CODECs
when they register but that would require some cooperation from the
machine driver since random actions may be required to ensure that the
CODECs are operational (see Zylonite with CLK_POUT in use for a simple
example).  There would also be some fun handling the ac97.c adaptor but
we can cross that bridge when we come to it.

> Modifying the WM9712 codec to register itself on device load works for
> me. If I don't do this how am I supposed to dynamically find the DAI
> pointer so that I can call snd_soc_register_dais()?

I'm unenthusiastic about including any more of this soc-of-simple stuff
in CODEC drivers, if it's going to be more generally used it ought to be
pushed into the core.  soc-of-simple predates the core registration
support and since registration is now required for everything there
doesn't seem to be any sense in going through all the existing CODEC
drivers adding specific bodges for this - we should just move the
soc-of-simple stuff into the core registration functions so we don't
need to modify the individual drivers.

That doesn't solve your OpenFirmware problems; the easiest thing there
is probably to do a specific soc-of-simple variant or option that knows
how to find the various AC97 driver options there are.  That's not ideal
but it's tractable since there aren't that many AC97 CODECs.  I don't
think I'd object to core code to read the ID registers either so long as
it doesn't impact boards that need to jump through hoops to get the
CODEC running.

I definitely don't want to be adding random platform devices for AC97
CODECs if at all possible since it feels like it complicates the AC97
support more than it already is.
