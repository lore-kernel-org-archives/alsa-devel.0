From: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>
Subject: Re: [PATCH v3 2/3] ASoC: OMAP4: Add support for McPDM
Date: Fri, 19 Feb 2010 18:50:52 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B8F94AFD7@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8F94A4F0@dlee01.ent.ti.com>
	<1266576927.3236.24.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B333103801
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 01:50:55 +0100 (CET)
In-Reply-To: <1266576927.3236.24.camel@odin>
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
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Liam Girdwood [mailto:lrg@slimlogic.co.uk] 
> Sent: Friday, February 19, 2010 4:55 AM
> To: Candelaria Villareal, Jorge
> Cc: alsa-devel@alsa-project.org; broonie@opensource.wolfsonmicro.com
> Subject: Re: [PATCH v3 2/3] ASoC: OMAP4: Add support for McPDM
> 
> On Thu, 2010-02-18 at 18:32 -0600, Candelaria Villareal, Jorge wrote:
> > McPDM is the interface between Phoenix audio codec
> > and the OMAP4430 processor. It enables data to be transfered
> > to/from Phoenix at sample rates of 88.4 or 96 KHz.
> > 
> > Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > Signed-off-by: Margarita Olaya <x0080101@ti.com>
> > ---
> >  sound/soc/omap/Kconfig  |    3 +
> >  sound/soc/omap/Makefile |    2 +
> >  sound/soc/omap/mcpdm.c  |  490 
> +++++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/omap/mcpdm.h  |  151 +++++++++++++++
> >  4 files changed, 646 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/soc/omap/mcpdm.c
> >  create mode 100644 sound/soc/omap/mcpdm.h
> > 
> > diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> > index 61952aa..b96e9d8 100644
> > --- a/sound/soc/omap/Kconfig
> > +++ b/sound/soc/omap/Kconfig
> > @@ -6,6 +6,9 @@ config SND_OMAP_SOC_MCBSP
> >         tristate
> >         select OMAP_MCBSP
> > 
> > +config SND_OMAP_SOC_MCPDM
> > +       tristate
> > +
> >  config SND_OMAP_SOC_N810
> >         tristate "SoC Audio support for Nokia N810"
> >         depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
> > diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
> > index 3db8a6c..bf8b388 100644
> > --- a/sound/soc/omap/Makefile
> > +++ b/sound/soc/omap/Makefile
> > @@ -1,9 +1,11 @@
> >  # OMAP Platform Support
> >  snd-soc-omap-objs := omap-pcm.o
> >  snd-soc-omap-mcbsp-objs := omap-mcbsp.o
> > +snd-soc-omap-mcpdm-objs := mcpdm.o
> 
> Probably best to follow convention here and have
> 
> snd-soc-omap-mcpdm-objs := omap-mcpdm.o
> 
Actually, both mcpdm.o and omap-mcpdm.o have to be compiled. If
you check patch 3/3 (which adds omap-mcpdm.c) you'll see that it
adds the following:

-snd-soc-omap-mcpdm-objs := mcpdm.o
+snd-soc-omap-mcpdm-objs := mcpdm.o omap-mcpdm.o
