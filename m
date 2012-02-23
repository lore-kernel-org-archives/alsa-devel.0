From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/4] ASoC: imx: add an explicit Kconfig
 option for imx-ssi driver
Date: Thu, 23 Feb 2012 09:40:00 -0600
Message-ID: <4F465DD0.1020304@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	by alsa0.perex.cz (Postfix) with ESMTP id BD5AF1041CA
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:40:17 +0100 (CET)
In-Reply-To: <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
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

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Since when do you work for Linaro?

> ---
>  sound/soc/imx/Kconfig  |    7 +++++++
>  sound/soc/imx/Makefile |    4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
> index 863a6b4..b9de8a8 100644
> --- a/sound/soc/imx/Kconfig
> +++ b/sound/soc/imx/Kconfig
> @@ -8,6 +8,9 @@ menuconfig SND_IMX_SOC
>  
>  if SND_IMX_SOC
>  
> +config SND_SOC_IMX_SSI
> +	tristate
> +

I was hoping to see sound/soc/imx disappear completely, and all IMX
support move into sound/soc/fsl.  After all, i.MX is a Freescale name.

Anyway, I'm really glad to see this patchset, but I won't be able to
devote much time to studying it until next week, at the earliest.

-- 
Timur Tabi
Linux kernel developer at Freescale
