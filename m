From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revert "ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC"
Date: Sun, 8 Jan 2012 20:15:46 -0800
Message-ID: <20120109041545.GK29065@opensource.wolfsonmicro.com>
References: <1326079783.2951.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00A96103819
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 05:16:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326079783.2951.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 11:29:43AM +0800, Axel Lin wrote:
> This reverts commit 739be96ab83755e10fd0c2b6a34c8a73254527f7 because it 
> introduces below build warnings:

> drivers/misc/Kconfig:212:       symbol ATMEL_SSC is selected by SND_ATMEL_SOC_SSC
> sound/soc/atmel/Kconfig:9:      symbol SND_ATMEL_SOC_SSC is selected by SND_AT91_SOC_SAM9G20_WM8731
> sound/soc/atmel/Kconfig:18:     symbol SND_AT91_SOC_SAM9G20_WM8731 depends on ATMEL_SSC

>  config SND_ATMEL_SOC_SSC
>  	tristate
>  	depends on SND_ATMEL_SOC
> -	select ATMEL_SSC

Why is this the best fix?  It's not obvious to me that the dependency
from the machine driver to the ATMEL_SSC (rather than a select or
relying on the SSC driver sorting things out) is correct.
