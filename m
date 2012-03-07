From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Wed, 7 Mar 2012 15:05:48 -0600
Message-ID: <4F57CDAC.9030604@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id CB9DC104136
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 22:06:06 +0100 (CET)
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> Changes since v1:
>  * Address comments from Mark, Timur, and Sascha (Thanks for review).
>  * Drop patches that have been applied by Mark.

So I'm testing them now, and I get this on boot:

ALSA device list:
  No soundcards found.

This happens frequently to my drivers whenever something in ASoC changes.
 And it's a pain to debug because ASoC never tells me what's wrong.

I'm debugging it now.  I'll let you know when I find something.

-- 
Timur Tabi
Linux kernel developer at Freescale
