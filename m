From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] [POWERPC] Update MPC8610 HPCD to
	support audio	drivers
Date: Tue, 08 Jan 2008 12:39:14 +0000
Message-ID: <1199795954.19903.76.camel@localhost.localdomain>
References: <1199732204949-git-send-email-timur@freescale.com>
	<1199732204578-git-send-email-timur@freescale.com>
	<20080108115654.d0ac909b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B51B24488
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 13:39:16 +0100 (CET)
In-Reply-To: <20080108115654.d0ac909b.sfr@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-01-08 at 11:56 +1100, Stephen Rothwell wrote:
> Hi Timur,
> 
> On Mon,  7 Jan 2008 12:56:43 -0600 Timur Tabi <timur@freescale.com> wrote:
> >
> > +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> > @@ -34,9 +34,27 @@
> >  
> >  #include <asm/mpic.h>
> >  
> > +#include <linux/of_platform.h>
> >  #include <sysdev/fsl_pci.h>
> >  #include <sysdev/fsl_soc.h>
> >  
> > +static struct of_device_id mpc8610_ids[] = {
> 
> __initdata
> 
> > +	{ .compatible = "fsl,mpc8610", },
> > +	{}
> > +};
> > +
> > +static int __init mpc8610_declare_of_platform_devices(void)
> > +{
> > +	if (!machine_is(mpc86xx_hpcd))
> > +		return 0;
> > +
> > +	/* Without this call, the SSI device driver won't get probed. */
> > +	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> > +
> > +	return 0;
> > +}
> > +device_initcall(mpc8610_declare_of_platform_devices);
> 
> We have machine_device_initcall for this now.
> 

Now changed in ASoC dev branch.

Liam
