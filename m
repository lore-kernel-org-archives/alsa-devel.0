From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
Date: Fri, 8 Jan 2010 16:18:38 +0000
Message-ID: <20100108161837.GD10128@sirena.org.uk>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
	<eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
	<eedb5540911300909vf042b39l44e06b432351b@mail.gmail.com>
	<20091201154920.GW27548@pengutronix.de>
	<eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF12103843
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 17:18:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5540912180618w53e24c6ahe1d47d410e1a91e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, lrg@slimlogic.co.uk, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 18, 2009 at 03:18:50PM +0100, javier Martin wrote:

> I don't wanna delay the entering of this driver to mainline. It is clear
> that it is cleaner and more generic than mine. And, what we really care, it
> works for our board.

> If you have any inconvenience with my requirement I could just ack the patch
> and maybe we could add support for it later.

It would be really good to see this merged.  I've been taking a closer
look at the driver while trying to get audio working on my i.MX31ADS and
did a few updates (which I still don't have working, though I suspect
the audmux or iomux rather than the driver).  I'll post the updates
shortly, and if people are happy I'd like to merge this stuff together
with removing the old code.
