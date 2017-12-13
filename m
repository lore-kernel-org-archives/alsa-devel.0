From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 05/11] ASoC: fsl_ssi: Refine indentations and wrappings
Date: Wed, 13 Dec 2017 14:33:57 -0800
Message-ID: <20171213223356.GA13576@Asurada-Nvidia>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
 <1513146874-25476-6-git-send-email-nicoleotsuka@gmail.com>
 <bf6f6d92-ae85-e61f-b027-95189c06916d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bf6f6d92-ae85-e61f-b027-95189c06916d@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 11:30:31PM +0100, Maciej S. Szmigiero wrote:
> On 13.12.2017 07:34, Nicolin Chen wrote:
> > This patch just simply unifies the coding style.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > 
> > Changelog
> > v1->v2
> >  * Added two missing indentation changes
> >  * Removed two extra blank lines.
> > 
> >  sound/soc/fsl/fsl_ssi.c     | 239 +++++++++++++++++++++-----------------------
> >  sound/soc/fsl/fsl_ssi.h     |   2 +-
> >  sound/soc/fsl/fsl_ssi_dbg.c |   3 +-
> >  3 files changed, 118 insertions(+), 126 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index 8b5407d..9a3db08 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> (..)
> > @@ -916,12 +917,11 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
> >  	case SND_SOC_DAIFMT_DSP_A:
> >  		/* Data on rising edge of bclk, frame high, 1clk before data */
> >  		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> > -			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> > +			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
> >  		break;
> >  	case SND_SOC_DAIFMT_DSP_B:
> >  		/* Data on rising edge of bclk, frame high */
> > -		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
> > -			SSI_STCR_TXBIT0;
> > +		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |  SSI_STCR_TXBIT0;
> 
> It looks like an extra space got here			 ^.

Good catch.

Thanks
