From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 19:36:32 +0100
Message-ID: <20080714183632.GI25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B788B24403
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 20:36:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 11:21:12AM -0600, Grant Likely wrote:
> On Mon, Jul 14, 2008 at 10:53 AM, Mark Brown

> > Incidentally, nobody ever really commented on my suggestion to do
> > something DMI-like

> I'm feeling stupid;  what does "DMI" stand for?

Desktop Management Interface, a standard BIOS interface for getting
system data on x86 class hardware.  Of particular interest here is the
fact that it contains various ID strings for things like motherboard and
chassis - on Linux drivers can be automatically loaded based on these
strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
that does this.

Note that it's *not* binding a driver,  it just provides the hooks to
enable the modules to be automatically loaded and to let drivers query
information in DMI.

> Yes, we have APIs for matching against device trees.  Personally, I'm
> leaning towards having the powerpc platform code
> (arch/powerpc/platforms/* stuff; not ASoC platform stuff) register a
> platform device for the machine driver and let as many machine drivers
> as needed be written.  Hopefully we'll be able to do at least one

That would be what I'd expected initially - it is, after all, what other
platforms are doing here.

> generic machine driver that will be usable by most PowerPC boards, but
> I don't think it is a requirement or even realistic to shoehorn all
> powerpc sound circuits into a single driver.

Yes, that'd be completely unrealistic.

> > I don't mind - you can call it what you like inside PowerPC-specific
> > code.

> Oh help!  Don't tell us that!  Otherwise we'll always be talking
> across purposes.  When ambiguous, let's just be sure to always refer
> to them as "ASoC machine drivers".  :-)

Feh, from now on I shall me naming all new concepts with pwgen :) .
