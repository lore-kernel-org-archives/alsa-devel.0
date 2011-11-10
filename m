From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH v4 0/3] ARM: mxs: add recording support for
	saif
Date: Thu, 10 Nov 2011 06:46:11 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722CA76D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id A7D022417E
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 07:46:20 +0100 (CET)
In-Reply-To: <1320907333-12696-1-git-send-email-b29396@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
> kernel-bounces@lists.infradead.org] On Behalf Of Dong Aisheng
> Sent: Thursday, November 10, 2011 2:42 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; w.sang@pengutronix.de; u.kleine-
> koenig@pengutronix.de; lrg@ti.com; Guo Shawn-R65073
> Subject: [PATCH v4 0/3] ARM: mxs: add recording support for saif
> 
> Changes since v3:
>  * remove unneeded locking according to Sascha.

I did not see your objections on my comments about difference between
Clkmux and clk api. So I kept it in this new patch series and only removed
the unneeded lock as you suggested.
If any issue, please let me know.

> The patches are based on imx-features branch since commit:
> ca4e419c2.
>
> Changes since v2:
>  * separate clkmux code into another patch according to Uwe
>  * add lock according to Wolfram
>  * Other minus fixes suggested by Uwe and Wolfram.
>  * remove Wolfram's fix saif clock setting patch which is in v2 series
>    since Wolfram will reform the clock code and send it out himself.
>    For test purpose, user still needs that patch. People can get it
>    from v2 series.
>    The patch is:
>    [PATCH v2 3/3] arm: mxs: disable clock-gates when setting saif-clocks
> 
> The patches are based on imx-features branch since commit:
> f4f01e31835f.
> 
> Changes since v1:
> The main changes are move mach-specific code(clkmux in DIGCTL) from saif
> driver to mach-specific layer based on Wolfram's suggestion.
> 
> Note that the last patch is a RFC patch and sent out for testing since
> without that patch the saif may not work.
> 
> Dong Aisheng (3):
>   ARM: mxs: add saif clkmux functions
>   ARM: mx28evk: add platform data for saif
>   ARM: mx28evk: set a initial clock rate for saif
> 
>  arch/arm/mach-mxs/clock-mx28.c                  |   65
> +++++++++++++++++++++++
>  arch/arm/mach-mxs/devices-mx28.h                |    3 +-
>  arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +-
>  arch/arm/mach-mxs/include/mach/common.h         |    2 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |    4 +-
>  arch/arm/mach-mxs/include/mach/digctl.h         |   21 +++++++
>  arch/arm/mach-mxs/mach-mx28evk.c                |   16 +++++-
>  7 files changed, 110 insertions(+), 6 deletions(-)  create mode 100644
> arch/arm/mach-mxs/include/mach/digctl.h
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards
Dong Aisheng
