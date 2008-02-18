From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 17:58:22 +0000
Message-ID: <20080218175822.GA20259@rakim.wolfsonmicro.main>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
	<20080218152259.GA7939@rakim.wolfsonmicro.main>
	<1203352473.4063.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A167424515
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:58:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203352473.4063.22.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 10:34:33AM -0600, Brian Austin wrote:
[Reflowed to fit into 80 columns.]

> Since the codecs are not tied to the machine, the user must then add
> to the Kconfig of the ARCH to select which codec they want to use?

No - ASoC codec drivers shouldn't be directly visible in the kernel
configuration user interface.

> If the codec isn't tied to the machine, why can't we select from a
> list of supported codecs?  Just trying to get a better understanding
> of how this works.

The dependency is from machine to codec rather than from codec to
machine.  Using a codec in ASoC always requires explicit configuration
through a machine driver in order to specify how the codec is connected
to the rest of the system but the same codec driver can be used by many
machines.

Given that this is the embedded space and only a small proportion of the
machine drivers that get written ever get merged it's useful to have
codec drivers merged even if there are no currently merged machine
drivers which need them.  Having the codec driver merged makes it easier
for people to get the driver and if they do want to contribute their
machine driver then having the codec driver already there makes that
easier.

This pattern of merging codec drivers before machine support is fairly
common for reference platforms like you're talking about - often the
codec driver will be ready first.  For example, the recently merged
mpc8610_hpcd and DaVinci platforms both did this.
