From: "Eric Miao" <ymiao3@marvell.com>
Subject: Re: [PATCH] pxa2xx-lib: support building for several
	pxa's
Date: Wed, 30 Jul 2008 18:07:02 -0700
Message-ID: <E913911567467945BBEB9277E27868B0FE1CC4@msiexch01.marvell.com>
References: <1217441805.20421.4.camel@ubuntu>
	<bc64b4640807301541m3f070da9o1c44ec14e160e829@mail.gmail.com>
	<f9d2a5e10807301628t63058b1am6ff1a42563f06736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dakia3.marvell.com (dakia3.marvell.com [65.219.4.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 85F1A244A8
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 03:07:07 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russ Dill <russ.dill@gmail.com>, Dmitry <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Russ Dill [mailto:russ.dill@gmail.com]
> Sent: Thursday, July 31, 2008 7:29 AM
> To: Dmitry
> Cc: alsa-devel@alsa-project.org; broonie@opensource.wolfsonmicro.com; Eric
> Miao
> Subject: Re: [PATCH] pxa2xx-lib: support building for several pxa's
> 
> On Wed, Jul 30, 2008 at 3:41 PM, Dmitry <dbaryshkov@gmail.com> wrote:
> > Hi,
> >
> > 2008/7/30 Russ Dill <russ.dill@gmail.com>:
> >> Here's a version of the third patch in the series without all the
> >> #ifdef's. Just a quick question for Dmitry, why all the if (!
> >> cpu_is_pxa3xx())'s around the pxa_gpio_mode's? Also, there was a build
> >> error when just building the sound/arm pxa2xx-ac97.
> >
> > Good!
> >
> > AFAIR pxa_gpio_mode isn't valid for the the pxa3xx, so cpu_is_pxa3xx().
> 
> I can't find any reason within the source that it wouldn't work. pxafb
> uses it, which is used by littleton and zylonite. I'm not sure when
> pxa_gpio_mode should be used vs the mfp pin config.
> 

pxa_gpio_mode() is deprecated, please don't use that, even with pxa2xx
platforms. The reason some legacy pxa_gpio_mode() is still there, e.g.
pxafb, is that not all platforms have transitioned into use the new MFP
API, til then, I'll schedule a cleanup to remove all those pxa_gpio_mode,
so whenever possible, don't introduce any new pxa_gpio_mode().

P.S. the reason pxa_gpio_mode() doesn't cause any obvious consequence is
that PXA3xx no longer has those GAFR registers, but that's really going
to affect other registers, esp. the GPDR, which isn't correct.

> >>
> >> Support building pxa2xx-lib for several pxa chip versions by making code
> >> run-time selected, not only compile-time
> >>
> >> Signed-off-by: Russ Dill <russ.dill@gmail.com>
> >> ---
> >>  include/asm-arm/arch-pxa/pxa-regs.h |    4 +-
> >>  sound/arm/Kconfig                   |    2 +-
> >>  sound/arm/pxa2xx-ac97-lib.c         |  174
> ++++++++++++++++------------------
> >>  sound/soc/pxa/pxa2xx-i2s.c          |   16 ++-
> >>  4 files changed, 95 insertions(+), 101 deletions(-)
> >>
> > --
> > With best wishes
> > Dmitry
> >
