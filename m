From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
 of_device with platform_device
Date: Fri, 20 Aug 2010 17:10:31 +0100
Message-ID: <1282320631.3084.636.camel@odin>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
	<AANLkTi=nAR=qCikxMK25a6u_vT5t_hz0RGo2Us+sba6T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BA96A24555
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:10:37 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2173525ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 09:10:37 -0700 (PDT)
In-Reply-To: <AANLkTi=nAR=qCikxMK25a6u_vT5t_hz0RGo2Us+sba6T@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-20 at 10:49 -0500, Timur Tabi wrote:
> On Fri, Aug 20, 2010 at 4:41 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Aug 19, 2010 at 03:26:58PM -0500, Timur Tabi wrote:
> >> 'struct of_device' no longer exists, and its functionality has been merged
> >> into platform_device.  Update the MPC8610 HPCD audio drivers (fsl_ssi, fsl_dma,
> >> and mpc8610_hpcd) accordingly.
> >>
> >> Also add a #include for slab.h, which is now needed for kmalloc and kfree.
> >>
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> >
> > This doesn't apply against current for-2.6.37 (presumably as a result of
> > the merge up of 2.6.36-rc1) - could you check please?
> 
> I believe that this is because you are missing this patch:
> 
> [v2] asoc/multi-component: fsl: add support for variable SSI FIFO depth
> 
> Liam, would you please ask Mark to pull from your for-2.6.37 branch,
> so that he can pick up this patch?

Mark has pulled and has this patch now. Btw, the confusion here was in
the patch subject (multi-component) hence this mornings email on the
matter.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
