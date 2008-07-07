From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Mon, 7 Jul 2008 11:59:06 +0100
Message-ID: <20080707105905.GA19240@rakim.wolfsonmicro.main>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93783244E0
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 12:59:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:

> The driver is assuming a capture stream exists. My codec is output only.

While the driver declares a capture stream the core doesn't require that
both capture and playback be available - it will cope with a capture
only or a playback only DAI (this is fairly common due to DAC only and
ADC only parts).  Unless there's some other issue specific to this
driver?

> I'm using external clocking, but the driver should support using the
> mpc5200 for clocking. That's a little complicated since you have to
> compute the divisors. For example the Phytec pcm030 board has a
> 33.3333Mhz xtal and runs at 400Mhz.

This is desirable, though it shouldn't be an obstacle for merging if the
driver only supports running in slave mode.

> In order to reduce options, can the psc-i2s driver always try to use
> mpc5200 clocking, then let the codec or fabric driver override it?

The clocking should always be under the control of the machine driver
with the codec and platform drivers exporting the required dividers and
PLLs/FLLs.  Neither the platform driver nor the codec driver are really
in a position to know how a given board is wired up and what
interdependencies or external requirements there are.
