From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 21:09:53 +0800
Message-ID: <20120225130943.GB25201@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
	<20120225012845.GF24268@S2101-09.ap.freescale.net>
	<20120225114227.GB3167@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id ED06024490
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 13:56:15 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so2194798pbc.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 04:56:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120225114227.GB3167@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2012 at 11:42:28AM +0000, Mark Brown wrote:
> On Sat, Feb 25, 2012 at 09:28:47AM +0800, Shawn Guo wrote:
> 
> > Per discussion [1], the whole point we move to fsl_ssi is that we can
> > reuse the DT support already in fsl_ssi.  If it's something we should
> > not use for IMX, I fail to see why we should make this move.
> 
> I was assuming that the idea was to share the code for device control
> as the same IP block was being deployed in the various Freescale SoCs
> - if the only thing they have in common is the device tree support it
> would be a bit strange to merge them.
> 
Here is the thing.

For historical reason, there are two drivers for the same SSI block
found on PowerPC and IMX, fsl_ssi and imx-ssi.  The fsl_ssi driver is
used on PowerPC with DT support, while imx-ssi is used on IMX with no
DT support.  Along with the work of supporting DT for the modern IMX
SoCs, I was planning to add DT support into imx-ssi.  But I was told
by Timur that instead of doing that, I should reuse fsl_ssi for those
DT aware IMX platforms.  From his POV, one big reason of why imx-ssi
was created is that ARM/IMX did not support DT before while fsl_ssi was
born to support DT only.  Since ARM/IMX starts supporting DT, fsl_ssi
should be reused there.

I'm personally fine with either reusing fsl_ssi or adding DT support
into imx-ssi.  I do not see any problem with reusing fsl_ssi so far,
but I can quickly turn around to adding new binding for imx-ssi if
you are strong on this position.

> Note that it's purely the bit where the machine driver is instantiated
> from the SSI (which is just one or two of several properties) that I'm
> talking about here, the bindings for the SSI itself look good.

Hmm, there is no SSI binding property contributing to instantiating
the machine driver.  It looks /model property for the device name used
to instantiate the machine driver, which I personally think is fine.

-- 
Regards,
Shawn
