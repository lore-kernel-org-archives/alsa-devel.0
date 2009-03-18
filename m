From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 7/9] ARM: DaVinci: ASoC: Adds ALSA
	SoC	DIT/DIR driver support for DM646X
Date: Wed, 18 Mar 2009 17:46:56 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B67017069809B099@dbde02.ent.ti.com>
References: <1237205148-30242-1-git-send-email-naresh@ti.com>,
	<20090316152517.GG16539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B88A91037EC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 13:18:12 +0100 (CET)
In-Reply-To: <20090316152517.GG16539@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org



>> On Mon, Mar 16, 2009 at 08:05:48AM -0400, Naresh Medisetty wrote:
>
> > --- /dev/null
> > +++ b/sound/soc/codecs/codec_stubs.c
> > @@ -0,0 +1,63 @@
> > +/*
> > + * ALSA SoC DaVinci DIT/DIR driver
> > + *
> > + *  TI DaVinci audio controller can operate in DIT/DIR (SPDI/F)
> where
> > + *  no codec is needed.  This file provides stub codec that can be
> used
> > + *  in these configurations.
>
> Either the driver is a generic driver (in which case this comment
> should
> reflect that) or it's specific to this hardware (in which case the name
> is entirely inappropriate)...

It's specific to dm646x, I will rename this while re-submitting the
Patch

>
> > +#define STUB_RATES   SNDRV_PCM_RATE_8000_96000
> > +#define STUB_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |
> SNDRV_PCM_FMTBIT_S20_3LE | \
> > +                     SNDRV_PCM_FMTBIT_S24_3LE |
> SNDRV_PCM_FMTBIT_S32_LE)
>
> ...looking at this and the rest of the definitions I'd suggest that the
> driver is specific to a particular device at the minute.
>
> > +static int __init dit_modinit(void)
> > +{
> > +     return snd_soc_register_dai(dit_stub_dai);
> > +}
> > +module_init(dit_modinit);
>
> > +static void __exit dit_exit(void)
> > +{
> > +     snd_soc_unregister_dai(dit_stub_dai);
> > +}
> > +module_exit(dit_exit);
>
> It should really probe as a platform device and register the DAIs when
> that happens (see wm8350 and wm8400 for examples).  You could make the
> driver more generic by passing in the parameters as platform data.

I will re-submit this patch by fixing this.
