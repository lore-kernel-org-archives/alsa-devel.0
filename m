From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/4] ASoC: mxs-saif: set a base clock rate
 for EXTMASTER mode work
Date: Sat, 21 Jul 2012 15:20:30 +0800
Message-ID: <20120721072028.GB923@S2101-09.ap.freescale.net>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 by alsa0.perex.cz (Postfix) with ESMTP id D3855264EF6
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 09:20:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1342776027-31758-3-git-send-email-b29396@freescale.com>
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

On Fri, Jul 20, 2012 at 05:20:25PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Set an initial clock rate for the saif internal logic to work
> properly. This is important when working in EXTMASTER mode that
> uses the other saif's BITCLK&LRCLK but it still needs a basic
> clock which should be fast enough for the internal logic.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
