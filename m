From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Thu, 29 Mar 2012 11:23:42 -0500
Message-ID: <4F748C8E.1010702@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
	<20120329160916.GG19506@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DABA103FAE
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:24:06 +0200 (CEST)
In-Reply-To: <20120329160916.GG19506@S2101-09.ap.freescale.net>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> d18b63ab0b04af1bad01e59a96b88fc8cda08752
> ASoC: core: Use driver core probe deferral

That fixed it, but the SHA in my repository is
97883ef0a8f61fbd5fb8242980f6998290d1dd95

Anyway, I just want to say that for-3.5 still works on PowerPC.

I do have one question though.  I don't know much about the clock layer.
When you do this:

	ssi_private->clk = clk_get(&pdev->dev, NULL);

What clock are you getting?

-- 
Timur Tabi
Linux kernel developer at Freescale
