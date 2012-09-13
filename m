From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: wm8960: Support shared LRCLK
Date: Thu, 13 Sep 2012 13:47:54 -0500
Message-ID: <50522A5A.10006@freescale.com>
References: <1347508108-24248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id C4F9A265335
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 20:48:01 +0200 (CEST)
In-Reply-To: <1347508108-24248-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> +		ret = regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2,
> +					 0x4, 0x4);

This is not enough to get the codec working on my board.

What is the actual mechanism that enables the clock on the WM8960?  I
don't have an oscilloscope, not it's hard to tell what the hardware is
actually doing.  However, I suspect that the LRCLK is not running.

-- 
Timur Tabi
Linux kernel developer at Freescale
