From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] ASoC: sgtl5000: defer the probe if
	clock is not	found
Date: Mon, 1 Jul 2013 12:33:10 +0100
Message-ID: <20130701113310.GA24642@n2100.arm.linux.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
 <20130701094525.GY27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id F041826508D
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 13:33:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130701094525.GY27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 01, 2013 at 10:45:25AM +0100, Mark Brown wrote:
> On Mon, Jul 01, 2013 at 04:16:09PM +0800, Shawn Guo wrote:
> > It's not always the case that clock is already available when sgtl5000
> > get probed at the first time, e.g. the clock is provided by CPU DAI
> > which may be probed after sgtl5000.  So let's defer the probe when
> > devm_clk_get() call fails and give it chance to try later.
> 
> Why not fix this in the clock API - the same logic is going to apply to
> a great proportion of clocks?

It's not ever clear whether a missing clock is because it's just not
provided or whether it's because it hasn't been registered yet.  The
decision to defer on missing resources is something which a _driver_
using the resource should make, not the subsystem providing the
resource - because the driver should know better whether that resource
is optional, whether it can continue to initialise without it and maybe
try again later, or whether it does need to defer.

Take for instance a video driver. :)  It may be that it can't do all
resolutions, but it can do some without an external clock, so it may
decide that it can initialise without the external clock and allow one
of the possible modes to be set - and when the external clock does
appear, it can then allow the other modes.

That kind of information is unknown at the subsystem level, and so the
subsystem level should only ever return "I don't know about this" not
"defer probe".
