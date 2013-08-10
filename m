From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [RFC PATCH] ASoC: omap-mcbsp: Add support for
 highter rate up to 384000
Date: Sat, 10 Aug 2013 09:53:25 +0200
Message-ID: <20130810075325.GA12316@panicking>
References: <20130807182841.GA7823@panicking> <5203782D.1080008@ti.com>
 <20130808110410.GA11288@panicking> <52047B9F.7040607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 72CD72610C4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 09:53:36 +0200 (CEST)
Received: by mail-ee0-f46.google.com with SMTP id c13so2487271eek.33
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2013 00:53:36 -0700 (PDT)
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

Hi Peter

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
> =


I found some time but I can't not test this patch now ;) too far from
my office. The idea is to check with MAX_BCLK. There are two points
that should cover slave and master mode. Is it the right direction?
BTW Do you think that is better to have at soc level as a new constraint?

Michael

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7483efb..ea95ad2 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -39,7 +39,9 @@
 #include "mcbsp.h"
 #include "omap-mcbsp.h"
 =

-#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_96000)
+#define OMAP_MCBSP_MAX_BCLK	48000000
+#define OMAP_MCBSP_RATES	(SNDRV_PCM_RATE_8000_192000 |		\
+				 SNDRV_PCM_RATE_KNOT)
 =

 #define OMAP_MCBSP_SOC_SINGLE_S16_EXT(xname, xmin, xmax, \
 	xhandler_get, xhandler_put) \
@@ -225,10 +227,14 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_su=
bstream *substream,
 	struct omap_mcbsp *mcbsp =3D snd_soc_dai_get_drvdata(cpu_dai);
 	struct omap_mcbsp_reg_cfg *regs =3D &mcbsp->cfg_regs;
 	struct snd_dmaengine_dai_dma_data *dma_data;
-	int wlen, channels, wpf;
+	int wlen, channels, wpf, bclk;
 	int pkt_size =3D 0;
 	unsigned int format, div, framesize, master;
 =

+	bclk =3D snd_soc_params_to_bclk(params);
+	if (bclk < 0 || bclk > OMAP_MCBSP_MAX_BCLK)
+		return -EINVAL;
+
 	dma_data =3D snd_soc_dai_get_dma_data(cpu_dai, substream);
 	channels =3D params_channels(params);
 =

@@ -326,7 +332,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_subs=
tream *substream,
 	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
 	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
 	master =3D mcbsp->fmt & SND_SOC_DAIFMT_MASTER_MASK;
-	if (master =3D=3D	SND_SOC_DAIFMT_CBS_CFS) {
+	if (master =3D=3D SND_SOC_DAIFMT_CBS_CFS) {
 		div =3D mcbsp->clk_div ? mcbsp->clk_div : 1;
 		framesize =3D (mcbsp->in_freq / div) / params_rate(params);
 =

@@ -500,6 +506,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc=
_dai *cpu_dai,
 			return -EBUSY;
 	}
 =

+	if (freq > OMAP_MCBSP_MAX_BCLK)
+		return -EINVAL;
+
 	mcbsp->in_freq =3D freq;
 	regs->srgr2 &=3D ~CLKSM;
 	regs->pcr0 &=3D ~SCLKME;
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
