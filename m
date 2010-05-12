From: saeed bishara <saeed.bishara@gmail.com>
Subject: Re: [patch 2/6] openrd-client: initialise audio
Date: Wed, 12 May 2010 07:09:36 +0000 (UTC)
Message-ID: <loom.20100512T090617-1@post.gmane.org>
References: <20100511162342.640158675@mandriva.com>
	<20100511162601.607632763@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F2592495A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 09:09:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OC64k-0002t8-4I
	for alsa-devel@alsa-project.org; Wed, 12 May 2010 09:09:50 +0200
Received: from galiil.marvell.com ([199.203.130.254])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 09:09:50 +0200
Received: from saeed.bishara by galiil.marvell.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 09:09:50 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 <apatard <at> mandriva.com> writes:

> --- linux-2.6.33.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-11
17:53:34.753650304 +0200
> +++ linux-2.6.33/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-11
17:55:13.313650581 +0200
> @@ -18,6 +18,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/kirkwood.h>
> +#include <mach/audio.h>
>  #include <plat/mvsdio.h>
>  #include "common.h"
>  #include "mpp.h"
> @@ -47,6 +48,11 @@ static struct mv643xx_eth_platform_data
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(24),
>  };
> 
> +struct kirkwood_soc_platform_data kirkwood_soc_data = {
> +	.dram        = &kirkwood_mbus_dram_info,
> +};
> +EXPORT_SYMBOL_GPL(kirkwood_soc_data);
> +
The kirkwood_soc_data is the same for all boards, so you can move it to the
mack-kirkwood/common.c, the tclk usually set at kirkwood_init().

saeed
