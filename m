From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: mxs-saif: fix clock prepare and
 enable unbalance issue
Date: Sat, 21 Jul 2012 15:03:49 +0800
Message-ID: <20120721070346.GA923@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FB0264EEB
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 09:03:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1342776027-31758-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 20, 2012 at 05:20:24PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Currently we directly call a clock_enable in trigger function without
> a clk_prepare as pair first.
> This will cause system hang immediately when run capture because
> the clock was not prepared(playback does not hang because the clock was
> prepared already by get_mclk before), a warning message in clock framework
> may cause a deadlock to reclaim clock lock (see: pl011_console_write).
> 
> Here we prepare clock first in hw_param, then enable it in trigger
> function to guarantee the balance.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
