From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU
 DAI and platform drivers
Date: Fri, 25 Jul 2014 10:05:22 +0800
Message-ID: <20140725020520.GA29136@MrMyself>
References: <cover.1406189745.git.nicoleotsuka@gmail.com>
 <2c74a11776ffcc017c80dc31be4a8313755be8f5.1406189745.git.nicoleotsuka@gmail.com>
 <20140724152045.GA3384@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 32CD8265745
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 04:21:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140724152045.GA3384@distanz.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com, lgirdwood@gmail.com, robh+dt@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, galak@codeaurora.org, grant.likely@linaro.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Tobias,

On Thu, Jul 24, 2014 at 05:20:45PM +0200, Tobias Klauser wrote:
> On 2014-07-24 at 10:35:29 +0200, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> > signal associated with an input clock into a signal associated with a different
> > output clock. The driver currently works as a Front End of DPCM with other Back
> > Ends DAI links such as ESAI<->CS42888 and SSI<->WM8962 and SAI. It converts the
> > original sample rate to a common rate supported by Back Ends for playback while
> > converts the common rate of Back Ends to a desired rate for capture. It has 3
> > pairs to support three different substreams within totally 10 channels.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> 
> [...]
> 
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -0,0 +1,1031 @@
> 
> [...]
> 
> > +static struct platform_driver fsl_asrc_driver = {
> > +	.probe = fsl_asrc_probe,
> > +	.driver = {
> > +		.name = "fsl-asrc",
> > +		.owner = THIS_MODULE,
> 
> Not necessary, this will be set by module_platform_driver (or
> the expansion of platform_driver_register, respectively).
> 
> > +		.of_match_table = fsl_asrc_ids,
> > +		.pm = &fsl_asrc_pm,
> > +	},
> > +};
> > +module_platform_driver(fsl_asrc_driver);
> 
> [...]
> 
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> > @@ -0,0 +1,384 @@
> 
> [...]
> 
> > +static int fsl_asrc_dma_pcm_new(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct snd_card *card = rtd->card->snd_card;
> > +	struct snd_pcm_substream *substream;
> > +	struct snd_pcm *pcm = rtd->pcm;
> > +	u64 dma_mask = DMA_BIT_MASK(32);
> > +	int ret, i;
> > +
> > +	if (!card->dev->dma_mask)
> > +		card->dev->dma_mask = &dma_mask;
> 
> dma_mask will go out of scope after fsl_asrc_dma_pcm_new returns,
> resulting in a stray pointer in card->dev->dma_mask.

Will fix them in v3.

Thank you
Nicolin
