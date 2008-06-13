From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
	MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 23:42:43 +0100
Message-ID: <20080613224243.GA28507@sirena.org.uk>
References: <48526566.8080400@freescale.com>
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
	<48528E81.2050901@freescale.com>
	<9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>
	<20080613155712.GA9955@rakim.wolfsonmicro.main>
	<9e4733910806130959m5cfbefbbo747642789190c285@mail.gmail.com>
	<20080613185942.GB12536@opensource.wolfsonmicro.com>
	<9e4733910806131225t7b40f3ado98b648b3f6798361@mail.gmail.com>
	<1213387493.6376.28.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D473F2451B
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jun 2008 00:42:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1213387493.6376.28.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2008 at 09:04:53PM +0100, Liam Girdwood wrote:

> > Yes, anything but the most basic configuration ends up in the loading
> > a fabric driver. I suspect all i2s setups will need one. AC97 and HDA
> > may not.

Ah!  I had thought that you wanted to see much wider use of generic
driver than this.

> I agree, all I2S & PCM setups will need fabric. HDA and Mipi won't due

Me too - there's just not the standardisation for software to work with
for I2S and PCM.

> to well defined specs whilst AC97 is the grey area. AC97 needs fabric on
> some systems but not others.

Yeah, part of what I was driving at was that it would be good if we
could handle standard conforming AC97 systems by having a fabric/machine
driver which provides the required glue to connect up whatever codecs
it was able to probe on the bus to the controller.

Having such a driver would mean that with ASoC support for their AC97
controller platforms would only have to have a mechanism to decide to
use the generic driver to also get support for standard AC97 subsystems.
This would leave these systems using an ASoC machine driver but not one
that is custom to any given system.
