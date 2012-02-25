From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Sat, 25 Feb 2012 10:17:58 +0000
Message-ID: <20120225101758.GJ22562@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
	<4F4819C4.5040709@freescale.com>
	<20120225000319.GC24268@S2101-09.ap.freescale.net>
	<4F483BB8.7030706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 53C4D243EF
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 11:18:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F483BB8.7030706@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2012 at 01:39:05AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Yes, I did something wrong.  But my point is the following patches
> > should belong to one big series.  They can not be applied separately.
> >
> > [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
> > [PATCH 2/4] ASoC: imx: move SND_SOC_AC97_BUS selection down to machine driver
> > [PATCH 3/4] ASoC: imx: initialize dma_params burstsize just in imx-ssi
> > [PATCH 4/4] ASoC: imx: separate imx-pcm bits from imx-ssi driver
> > [PATCH 0/4] ASoC: merge imx into fsl
> > [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
> 
> That's not what Mark is talking about.  You somehow posted patch 0/6 as a 
> reply to the *previous* patchset, so the two patchsets were merged into 
> one email thread.

Sorry, you and Mark are not listening to Shawn.  Even worse, you're
telling Shawn that what he's trying to explain to you is not the point
when it is actually the whole point.

The "[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl" was posted as a
follow-up to "[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ".

So, the "*previous* patchset" _was_ "[PATCH 1/4] ASoC: imx: let
SND_MXC_SOC_FIQ select FIQ" and not some other random patch set.  That
is a fundamental fact, which can't be argued.  Anyone can verify it, and
it can be verified by checking the email headers.
