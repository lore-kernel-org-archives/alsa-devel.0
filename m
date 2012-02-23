From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver
	compilable on ARM/IMX
Date: Thu, 23 Feb 2012 09:44:37 -0600
Message-ID: <4F465EE5.4010908@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
	<4F465A33.3020208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id E039B243C3
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:44:49 +0100 (CET)
In-Reply-To: <4F465A33.3020208@ru.mvista.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: alsa-devel@alsa-project.org, Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Sergei Shtylyov wrote:
>     These functions are not equivalent concerning endianness. You should 
> probably have used readl_be() instead, else it won't work on PPC anymore.

readl_be() is not good enough, either.  The in/out_be functions have
specific syncronization instructions in them, so that the operations
conform to the PowerPC instruction ordering architecture.

You probably need to do something like this:

#ifdef PPC
#define read_ssi(x) in_be32(x)
#else #if defined ARM
#define read_ssi(x) readl(x)
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
