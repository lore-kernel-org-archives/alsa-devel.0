From: <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4
Date: Thu, 23 Dec 2010 06:42:50 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0271CFAAA@008-AM1MPN1-021.mgdnok.nokia.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4F6D3A7@dlee06.ent.ti.com>
	<20101220173612.GC2531@rakim.wolfsonmicro.main>
	<20101221114858.0e29e684.jhnikula@gmail.com>,
	<1292926632.3296.1.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 026C324854
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 07:43:11 +0100 (CET)
In-Reply-To: <1292926632.3296.1.camel@odin>
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
To: lrg@slimlogic.co.uk, jhnikula@gmail.com
Cc: magi.olaya@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

It seams that I have really bad mail issues..
I just received the RE mails to the patch, but not the original, so
I picked this mail to reply.
And going to top post :(

In the patch:
@@ -623,6 +652,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
                if (cpu_class_is_omap1()) {
                        err = -EINVAL;
                        break;
+               } else if (cpu_is_omap44xx()) {
+                       regs->srgr2     &= ~CLKSM;

There's no need to clear the CLKSM, since it is by default not set.
IMHO you shall handle the OMAP4 in a same way as we handle OMAP3.
By doing nothing here.

+                       break;
                }
                err = omap2_mcbsp_set_clks_src(mcbsp_data->bus_id,
                                               MCBSP_CLKS_PRCM_SRC);


Otherwise:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

______________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of ext Liam Girdwood [lrg@slimlogic.co.uk]
Sent: Tuesday, December 21, 2010 12:17
To: Jarkko Nikula
Cc: Olaya, Margarita; alsa-devel@alsa-project.org; Mark Brown
Subject: Re: [alsa-devel] [PATCH] ASoC: mcbsp: Add McBSP support for OMAP4

On Tue, 2010-12-21 at 11:48 +0200, Jarkko Nikula wrote:
> On Mon, 20 Dec 2010 17:36:13 +0000
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
> > On Mon, Dec 20, 2010 at 11:32:47AM -0600, Olaya, Margarita wrote:
> > > From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > >
> > > This patch adds McBSP support for the OMAP4 CPU
> >
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> Have my ack too
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
>
> Out of curiosity: can the McBSP interface to be used as a simple
> alternative to OMAP4 ABE centric audio on existing platfroms like Panda?
>

McBSP, McPDM and DMIC can all be used without the ABE in legacy mode on
OMAP4.

Liam

--
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
