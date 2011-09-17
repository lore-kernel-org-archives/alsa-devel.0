From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Sat, 17 Sep 2011 13:58:18 +0100
Message-ID: <20110917125817.GA2909@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<20110916164412.GD23727@opensource.wolfsonmicro.com>
	<4E737D89.9060900@freescale.com>
	<20110916164838.GF23727@opensource.wolfsonmicro.com>
	<4E737FA8.5090109@freescale.com>
	<20110916171259.GG23727@opensource.wolfsonmicro.com>
	<4E739484.4000604@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 205A22447F
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 14:58:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E739484.4000604@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 01:25:08PM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > Right, but the two things aren't connected.  As I've *repeatedly* said
> > the list of supported sample rates in the DAI should be the full set
> > that the device can support, unrelated to any clock setup.

> But I could hook up any frequency to audmclk and dacmclk.  What if I want
> 40000Hz as a sample rate?  I could then then set mclk to 15.36MHz.

If the CODEC supports continuous rates it'll say so and nothing in the
CODEC driver will stop that being selected.

> I don't see how the codec driver can know what sample rates it supports until
> *after* set_sysclk() is called (i.e. when the driver is told the value of mclk).

The part will have been specified and qualified for a set of sample
rates.  These will be listed in the datasheet and are the rates the
driver should advertise.
