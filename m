From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver as
 using symmetric rates
Date: Mon, 11 Jan 2010 11:51:01 +0000
Message-ID: <20100111115101.GA8471@rakim.wolfsonmicro.main>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
	<20100111113631.GE3440@sirena.org.uk>
	<eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAEAD103800
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:51:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
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
Cc: Timur Tabi <timur@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 12:39:13PM +0100, javier Martin wrote:

> However,
> I think it would be a good idea to add an optional flag to activate
> symmetric rate.
> Understanding it as TX and RX SSI sections sharing the same CLKs.
> This is necessary for some codecs like wm8974 to work because they can only
> provide
> one BCLK and FCLK for both directions.

That's not what the patch does - it only sets the symmetric_rates flag,
which can also be flagged from the machine driver, which adds some
constraints for applications so you can't configure asymmetric rates.
It doesn't affect the hardware configuration at all.
