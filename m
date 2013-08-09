From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [RFC PATCH] ASoC: omap-mcbsp: Add support for
 highter rate up to 384000
Date: Fri, 9 Aug 2013 09:43:54 +0200
Message-ID: <20130809074354.GB12866@panicking>
References: <20130807182841.GA7823@panicking> <5203782D.1080008@ti.com>
 <20130808110410.GA11288@panicking> <52047B9F.7040607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 9738D261A2D
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 09:44:02 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id f15so1859509eak.36
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 00:44:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52047B9F.7040607@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Aug 09, 2013 at 08:18:23AM +0300, Peter Ujfalusi wrote:
> On 08/08/2013 02:04 PM, Michael Trimarchi wrote:
> > On Thu, Aug 08, 2013 at 01:51:25PM +0300, Peter Ujfalusi wrote:
> >> On 08/07/2013 09:28 PM, Michael Trimarchi wrote:
> >>> Add support for highter rate up to 384000Khz. There are codecs in the
> >>> market that can play up to this frequency.
> >>> Test was done just with:
> >>>
> >>> #define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000)
> >>>
> >>> playing wav file 32bit/192000Khz stereo. Some glitch has observed
> >>> but this should depend on the selected min buffer bytes that was
> >>> left untouched in aplay and in the omap-pcm driver.
> >>>
> >>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> >>> ---
> >>>  sound/soc/omap/omap-mcbsp.c |    8 +++++++-
> >>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> >>> index 7483efb..1e95f6a 100644
> >>> --- a/sound/soc/omap/omap-mcbsp.c
> >>> +++ b/sound/soc/omap/omap-mcbsp.c
> >>> @@ -39,7 +39,9 @@
> >>>  #include "mcbsp.h"
> >>>  #include "omap-mcbsp.h"
> >>>  =

> >>> -#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
> >>> +#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000 |		\
> >>
> >> I think only this change is enough for what you want to achieve.
> >>
> >>> +				 SNDRV_PCM_RATE_CONTINUOUS |		\
> >>> +				 SNDRV_PCM_RATE_KNOT)
> >>
> >> The _KNOT is for sure not needed and I would not set the CONTINUOUS ei=
ther.
> > =

> > pcm5102pw is a codec that support 384000 rate so I think that PCM_RATE_=
KNOT
> > is requested for such rate. Correct?
> =

> Yes, looks that way. I had overlooked the 384000 KHz...
> =


Ok, I will do it better

> >>
> >>>  =

> >>>  #define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
> >>>  	xhandler_get, xhandler_put) \
> >>> @@ -574,11 +576,15 @@ static struct snd_soc_dai_driver omap_mcbsp_dai=
 =3D {
> >>>  		.channels_max =3D 16,
> >>>  		.rates =3D OMAP_MCBSP_RATES,
> >>>  		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> >>> +		.rate_min =3D 8000,
> >>> +		.rate_max =3D 384000,
> >>
> >> Why you want to limit the rates here?
> >>
> > =

> > I didn't find in the market somenthing up to 384000.
> =

> Sure, but it is not correct to say that McBSP supports rates up to 384000.
> McBSP have constraint on the BCLK speed up to 48MHz. So while
> 32bit/stereo/384000 is OK, 32bit/4channel/384000 is not, but
> 16bit/4channel/384000 is again good.
> When McBSP is master we have a check for the clock speed. We might need to
> have similar for McBSP slave mode, but I don't think we are going to hit =
the
> 48MHz limit anyways.

Should be possible to consider this limitation of the McBSP clock speed.
I'm going to take a look on this. I will send another patch

Michael


> =

> =

> > =

> > Michael
> > =

> >>>  	},
> >>>  	.capture =3D {
> >>>  		.channels_min =3D 1,
> >>>  		.channels_max =3D 16,
> >>>  		.rates =3D OMAP_MCBSP_RATES,
> >>> +		.rate_min =3D 8000,
> >>> +		.rate_max =3D 384000,
> >>
> >> Same here, do not set these.
> >>
> >>>  		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> >>>  	},
> >>>  	.ops =3D &mcbsp_dai_ops,
> >>>
> >>
> >>
> >> -- =

> >> P=E9ter
> > =

> =

> =

> -- =

> P=E9ter

-- =

| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
