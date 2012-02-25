From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 08:09:15 +0800
Message-ID: <20120225000913.GE24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
	<4F47BB0D.9080905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 51B9624377
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:55:35 +0100 (CET)
Received: by dady9 with SMTP id y9so3341768dad.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:55:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F47BB0D.9080905@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 10:30:05AM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> > The ARM machines really shouldn't be using the bindings that PowerPC is
> > using for the machine as they conflate the machine driver with the SSI
> > binding.  The idiom for new systems is that machine drivers should be
> > first class devices in the device tree referencing the SSI and CODEC.
> 
> Where is this documented?
> 
Documentation/devicetree/bindings/sound/tegra*, I guess.

-- 
Regards,
Shawn
