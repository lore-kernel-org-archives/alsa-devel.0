From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ad74111: new codec driver
Date: Sat, 26 Mar 2011 12:21:08 +0000
Message-ID: <20110326122108.GD28537@opensource.wolfsonmicro.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68C2C243F9
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:21:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 04:33:46AM -0400, Mike Frysinger wrote:

>  	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
> -	select SND_SOC_ADS117X
>  	select SND_SOC_AD73311 if I2C
> +	select SND_SOC_AD74111
> +	select SND_SOC_ADS117X

A few of your patches have this sort of additional change in them.
While the cleanup is good it would be better to split it into a separate
patch.  Seeing the unrelated change slows down review and it'll also
create extra merge issues when applying or cherry picking the driver
back to older kernels.

> +static struct platform_driver ad74111_codec_driver = {
> +	.driver = {
> +		.name = "ad74111-codec",

Again, drop the -codec unless this is part of a MFD.

> +/*
> + * definitions for AD74111 registers
> + *

Does this device really have registers?  There's no reference at all to
them in the driver.

> +/* Control register F */
> +#define CTRL_REG_F		(5 << 11)
> +#define REGF_DAC_VOL(x)		((x) & 0x3F)

If the registers should be here they should be namespaced.
