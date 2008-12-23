From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Tue, 23 Dec 2008 12:18:50 +0000
Message-ID: <20081223121849.GC3197@sirena.org.uk>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<FF55437E1F14DA4BAEB721A458B670170622FF42E7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 46F39103831
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 13:19:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B670170622FF42E7@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Medisetty, Naresh" <naresh@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 23, 2008 at 02:05:33PM +0530, Medisetty, Naresh wrote:
> Mark,

> > Could you expand on that a bit - what are you referring to as the 
> > standard here?  This could just be a case of different hardware 
> > manufacturers implementing slightly different things and giving them 
> > the same name.

> Yes, Exactly it's just a case of different manufacturers implementing the same thing in different way.

The idea in ASoC is to follow a consistent naming scheme within ASoC
rather than implement the APIs in a per-manufacturer fashion.  A given
DAI mode should always produce the same effect in hardware no matter
which device is being configured.  This makes the code much easier to
work with since otherwise you'd not be able to tell from the code if the
devices that are being connected are configured compatibly simply by
looking at the set_dai_fmt() calls.

For most newer SoC CPUs (like the DaVinci) the drivers have to simulate
the various clocking modes by configuring the chip rather than by having
native support for the modes in the chip.

> I am referring the davinci ASP default polarities (without inversion) of FS and BCLK as standard.

Like I say, the DaVinci chip defaults don't matter here - what matters
is the mode the DAI is supposed to be operating in.

> In davinci ASP Frame sync signals internal to the ASP are active high. 
> The Frame sync clock (either FSX or FSR) is XORed with Frame sync polarity bit (FSXP or FSRP).
> So if the requirement is for frame sync active low FSXP and FSRP bits in PCR register should be set.

Troy left the frame clock settings alone so I'll assume you've no
concerns there?

> Similarly the BCLK (CLKX and CLKR) is XORed with BCLK polarity bit (CLKXP and CLKRP).
> Internally the transmit data driven on rising edge of CLKX and receive data sampled on falling edge of CLKR.
> To inverse this CLKXP and CLKRP should be set.

> According to this the existing code is proper since it is not setting any polarity bits in _SOC_DAIFMT_NB_NF (Normal bit and Normal Frame )case.

The DaVinci driver is configuring the clocks to match DSP mode (when
using I2S mode it flips the inversion bits in the format before using
them).  For DSP mode data is available on the first rising edge of BCLK
so sampling should be done on the rising edge.  This means that the data
has to be driven out on the falling edge to ensure that it is ready to
be sampled on the rising edge.  Troy's changes implement this so they
look correct to me.

> And also in AIC33 codec there is no question of polarities since it is directly configurable through modes (either I2S or DSP).

The inversions apply to the standard clocking for a given mode.  For
example, with I2S LRCLK clock inversion is essentially equivalent to
swapping left and right channels.  This facility is implemented by a
reasonable number of codecs and made available through the API since
it improves interoperability.  Some CPUs (especially those with hand
configured ports rather than native support for the clocking modes)
have trouble doing some of the standard modes but can deal with inverted
versions of one or both of the clocks.

[BTW, your MUA appears to be generating lines ~90-100 characters long -
it'd help if it were to go for something less than 80 characters since
it makes your messages easier to read and reply to with standard mail
clients.]
