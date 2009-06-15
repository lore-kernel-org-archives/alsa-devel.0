From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance
	I2S and add	Left_J support)
Date: Mon, 15 Jun 2009 16:04:33 +0100
Message-ID: <20090615150433.GF6106@sirena.org.uk>
References: <20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 445282439E
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 17:04:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245077824.24109.51.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 11:57:04AM -0300, Daniel Ribeiro wrote:

> For what it matters, the only difference on I2S/LEFT_J vs DSP_A/DSP_B
> should be the SSPSFRM duration as it is needed to emulate the LRCLK.

Assuming no extra bit clocks.  Extra bit clocks do something different
in I2S due to the fact that LRCLK falling edge is signifigcant.

> (and of course, the fact that I2S/LEFT_J are stereo only and that
> network mode can't be supported)

You should be able to support at least modes using the first TDM
timeslot I'd have thought.
