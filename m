From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
Date: Thu, 23 Dec 2010 14:39:38 +0000
Message-ID: <1293115178.3320.19.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4F6D3A7@dlee06.ent.ti.com>
	<20101220173612.GC2531@rakim.wolfsonmicro.main>
	<20101221114858.0e29e684.jhnikula@gmail.com>
	, <1292926632.3296.1.camel@odin> ,
	<CF32F28EDF8D20468EEDCBE4975DA0271CFAAA@008-AM1MPN1-021.mgdnok.nokia.com>
	<CF32F28EDF8D20468EEDCBE4975DA0271D4A4D@008-AM1MPN1-021.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 91553103804
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 15:39:44 +0100 (CET)
Received: by wwe15 with SMTP id 15so5985386wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 06:39:44 -0800 (PST)
In-Reply-To: <CF32F28EDF8D20468EEDCBE4975DA0271D4A4D@008-AM1MPN1-021.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, magi.olaya@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-23 at 07:32 +0000, peter.ujfalusi@nokia.com wrote:
> Hi,
> 
> > From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of Ujfalusi Peter (Nokia-MS/Tampere)
> > Sent: Thursday, December 23, 2010 08:42
> > To: lrg@slimlogic.co.uk; jhnikula@gmail.com
> > Cc: magi.olaya@ti.com; alsa-devel@alsa-project.org; broonie@opensource.wolfsonmicro.com
> > Subject: Re: [alsa-devel] [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
> 
> > In the patch:
> > @@ -623,6 +652,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> >                 if (cpu_class_is_omap1()) {
> >                         err = -EINVAL;
> >                         break;
> > +               } else if (cpu_is_omap44xx()) {
> > +                       regs->srgr2     &= ~CLKSM;
> > 
> > There's no need to clear the CLKSM, since it is by default not set.
> > IMHO you shall handle the OMAP4 in a same way as we handle OMAP3.
> > By doing nothing here.
> > 
> > +                       break;
> 
> I think you should not break here, since you might want to select the CLKS/PRCM with the next
> call...
> 
> >                 }
> >                 err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
> >                                                MCBSP_CLKS_PRCM_SRC);
> > 
> > 
> > Otherwise:
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Just noticed that, this patch is already in, but the issues, I have commented has to
> be fixed in order to have proper support for OMAP4.

Now fixed and added your Ack.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
