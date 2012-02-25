From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 14:03:56 +0000
Message-ID: <4F48EA4B.4030400@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
	<20120225012845.GF24268@S2101-09.ap.freescale.net>
	<20120225114227.GB3167@opensource.wolfsonmicro.com>
	<20120225130943.GB25201@S2101-09.ap.freescale.net>
	<20120225132705.GA3412@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B862103CFA
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 15:04:08 +0100 (CET)
In-Reply-To: <20120225132705.GA3412@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <060042F0AC9C954CAD953C74AD1AAAC6@mgd.freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> Nobody's suggesting that they don't get merged if they really are the
> same IP and can use the same code.  The device tree bindings are (and
> should be) a really small proportion of the code.

My understanding is that they really are the same exact IP.

> The CODEC binding for the machine driver is part of the SSI binding, and
> a mandatory one at that.  It looks like the code should be refactored to
> register the SSI unconditionally

Ok.

> and then optionally also register a
> machine driver if there's a CODEC property present.

Ah, that's not a bad idea.  I like that.

-- 
Timur Tabi
Linux kernel developer at Freescale
