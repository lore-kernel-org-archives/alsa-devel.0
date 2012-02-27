From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Mon, 27 Feb 2012 15:54:01 -0600
Message-ID: <4F4BFB79.30801@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 0515A10391A
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 22:54:26 +0100 (CET)
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
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
> The fsl_ssi probe function detects the client machine name using model
> property of the device tree.  But it will not work for the ARM client
> machines which are to be added.  The model property is given as a
> descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> Instead, the compatible property gives the machine name.

If you apply this change to the P1022DS as well, then you can eliminate
the need to check for "P1022" and "P1022DS", since the compatible string
in the P1022DS DTS has always said, "fsl,P1022DS".

-- 
Timur Tabi
Linux kernel developer at Freescale
