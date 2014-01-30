From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] ASoC: fsl: add imx-ssm2603 machine
 driver
Date: Thu, 30 Jan 2014 10:17:47 +0100
Message-ID: <1391073467.4921.1.camel@pizza.hi.pengutronix.de>
References: <1391014047-22816-1-git-send-email-p.zabel@pengutronix.de>
 <1391014047-22816-2-git-send-email-p.zabel@pengutronix.de>
 <20140130054626.GA2405@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8464E265041
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 10:17:51 +0100 (CET)
In-Reply-To: <20140130054626.GA2405@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

Am Donnerstag, den 30.01.2014, 13:46 +0800 schrieb Nicolin Chen:
> Hi Philipp,
> 
> On Wed, Jan 29, 2014 at 05:47:27PM +0100, Philipp Zabel wrote:
> > This adds support for i.MX boards with Analog Devices SSM2603 codecs
> > connected via I2S with separate Tx and Rx clocks.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  sound/soc/fsl/Kconfig       |  12 +++
> >  sound/soc/fsl/Makefile      |   2 +
> >  sound/soc/fsl/imx-ssm2603.c | 239 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 253 insertions(+)
> >  create mode 100644 sound/soc/fsl/imx-ssm2603.c
> > 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> > index b7ab71f..8a4ff4e 100644
> > --- a/sound/soc/fsl/Kconfig
> > +++ b/sound/soc/fsl/Kconfig
> > @@ -212,4 +212,16 @@ config SND_SOC_IMX_MC13783
> >  	select SND_SOC_MC13783
> >  	select SND_SOC_IMX_PCM_DMA
> >  
> > +config SND_SOC_IMX_SSM2603
> > +	tristate "SoC Audio support for i.MX boards with ssm2603"
> > +	depends on OF && I2C
> > +	select SND_SOC_SSM2602
> > +	select SND_SOC_IMX_PCM_DMA
> > +	select SND_SOC_IMX_AUDMUX
> > +	select SND_SOC_FSL_SSI
> > +	select SND_SOC_FSL_UTILS
> 
> Not sure if this UTILS is essential...
> 
> > +static int imx_ssm2603_probe(struct platform_device *pdev)
> > +{
> > +	ret = snd_soc_register_card(&data->card);
> 
> devm_ might be better?

right, I'll change both.

thanks
Philipp
