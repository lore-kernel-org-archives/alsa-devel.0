From: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH] powerpc: rename immap_86xx.h to fsl_guts.h, and add
	85xx support
Date: Thu, 22 Jul 2010 10:30:17 -0500
Message-ID: <1279812617.7232.8703.camel@petert>
References: <1279749902-13459-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1279749902-13459-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Timur,

> +/**
> + * Global Utility Registers.
> + *
> + * Not all registers defined in this structure are available on all chips, so
> + * you are expected to know whether a given register actually exists on your
> + * chip before you access it.
> + *
> + * Also, some registers are similar on different chips but have slightly
> + * different names.  In these cases, one name is chosen to avoid extraneous
> + * #ifdefs.
> + */
> +#ifdef CONFIG_PPC_85xx
> +struct ccsr_guts_85xx {
> +#else
> +struct ccsr_guts_86xx {
> +#endif

Is there a good reason to have 2 different names for the same structure
depending on the architecture?  I'd think keeping a common "ccsr_guts"
name would get rid of the ifdefs above as well as in code that can be
used on both 85xx and 86xx processors down the road.

Best,
Peter
