From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Fri, 25 Sep 2009 07:30:04 -0700
Message-ID: <E1MrBoC-00021c-8s@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E4410380E
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 16:30:06 +0200 (CEST)
Received: from amazonia.comcast.net (c-98-232-231-2.hsd1.or.comcast.net
	[98.232.231.2])
	by samwise.efn.org (Postfix) with ESMTP id E72E0170028
	for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2009 07:30:06 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>) id 1MrBoC-00021c-8s
	for alsa-devel@alsa-project.org; Fri, 25 Sep 2009 07:30:04 -0700
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

Hi Peter,

  Thanks very much for the help.

> I think the problem is here.
> The MCBSP_CLKS pin is connected to CLK256FS pin of TWL4030 (or TPA).
> Since you are not using the TWL codec, there will be no clock on the MCBSP_CLKS
> pin, thus no functional clock for McBSP, thus no bits are shifted in or out.
> You can try to use the internal functional clock:
> 
>   ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK, 0,
>     SND_SOC_CLOCK_IN);

  I have checked the CLKOUT (WM8731) -> McBSP_CLKS (OMAP3) pin and it
has a 12288000 clock on it.  I've tried using the internal clock as
you show above, just to see if I get anything out on DX but I get the
same thing: DX just goes low for the "aplay" duration.

  Any idea why I'm not getting DMA interrupts?  This would indeed
cause no data at DX.  omap2_dma_irq_handler() never gets called but
omap_init_dma() and omap_start_dma() get called.  Do you think there
may be any issues with my DMA code (specifically
arch/arm/plat-omap/dma.c).  As I mentioned, I'm at "2.6.29-rc3-omap1"

  Thanks,

  Rick
