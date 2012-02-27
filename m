From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/6] ASoC: fsl: use platform_device_id
 table to match p1022_ds device
Date: Mon, 27 Feb 2012 15:39:17 -0600
Message-ID: <4F4BF805.60807@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 397EF103D37
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 22:54:26 +0100 (CET)
In-Reply-To: <1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
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

> -
> -	/*
> -	 * Check if we're actually running on a P1022DS.  Older device trees
> -	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
> -	 * need to support both.  The SSI driver uses that property to link to
> -	 * the machine driver, so have to match it.
> -	 */

Please retain this paragraph somewhere.  It's important to explain why
we're checking for both strings.

-- 
Timur Tabi
Linux kernel developer at Freescale
