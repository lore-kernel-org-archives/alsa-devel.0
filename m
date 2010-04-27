From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 16:36:08 +1000
Message-ID: <1272350168.24542.6.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F4292480F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 08:36:19 +0200 (CEST)
In-Reply-To: <1272314980-23679-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-04-26 at 15:49 -0500, Timur Tabi wrote:
> An upcoming change in the architecture of ALSA SoC (ASoC) will require the
> MPC8610 HPCD's ASoC fabric driver to register as a standard platform driver.
> Therefore, we need to call platform_device_register_simple() from the board's
> platform code.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Gross. Loses the linkage to device-tree etc... which is useful for audio
especially. You should at least make sure the device node follows for
the target driver to be able to use it :-) I'd like you to sync with
Grant work on that matter if you are going to convert of_devices into
platform_devices.

Cheers,
Ben.

> Kumar, the ASoC mainters are willing to pick up this patch, but they want an
> ACK from you first.  Or, you could pick it up, since by itself it's harmless.
> 
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> index 5abe137..66afff3 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -98,6 +98,9 @@ static int __init mpc8610_declare_of_platform_devices(void)
>  	/* Without this call, the SSI device driver won't get probed. */
>  	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>  
> +	/* Register the platform device for the ASoC fabric driver */
> +	platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, NULL, 0);
> +
>  	return 0;
>  }
>  machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
