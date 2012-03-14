From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Wed, 14 Mar 2012 02:57:00 +0000
Message-ID: <4F6008FA.3040805@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 24BC9103AC1
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 03:57:20 +0100 (CET)
In-Reply-To: <20120313234638.GY3177@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <AB5DAA7FB92CD749B4F821B354173B55@mgd.freescale.com>
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

> With this card those would just be separate CODECs.  This is a binding
> for a simple card.

But that is insufficient for the SSI driver, which is expected to handle 
multiple SSIs.  If you're going to document a binding for the SSI driver, 
then you need to document how to handle multiple SSIs.

> The biggest improvement is that the SoC binding knows nothing about the
> card binding at all, cards are completely separate and are free to
> define any binding they choose using any number of on-SoC and off-SoC
> devices.

Ok, I don't understand that at all.

I also don't understand why you insist on perverting my driver to support 
two incompatible bindings, especially since I still haven't heard an 
explanation as to what's wrong with the binding that I defined.

-- 
Timur Tabi
Linux kernel developer at Freescale
