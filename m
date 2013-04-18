From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4 02/10] ASoC: imx-pcm-dma: DT support
Date: Thu, 18 Apr 2013 17:35:12 +0200
Message-ID: <20130418153512.GA4307@pengutronix.de>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
 <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
 <5170069F.4030200@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5170069F.4030200-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 04:43:43PM +0200, Lars-Peter Clausen wrote:
> On 04/18/2013 02:33 PM, Markus Pargmann wrote:
> > This patch adds the possibility to pass a of_node as platform_data which
> > is used by generic-pcm-dma to request a DMA slave channel.
> > 
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  sound/soc/fsl/imx-pcm-dma.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> > index c246fb5..8945d22 100644
> > --- a/sound/soc/fsl/imx-pcm-dma.c
> > +++ b/sound/soc/fsl/imx-pcm-dma.c
> > @@ -62,9 +62,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
> >  
> >  int imx_pcm_dma_init(struct platform_device *pdev)
> >  {
> > +	if (pdev->dev.platform_data)
> > +		pdev->dev.of_node = pdev->dev.platform_data;
> 
> In my opinion it's better to use pdev->dev.parent->of_node here. In the ssi
> driver you use platform_device_register_data, which will create a copy of
> the of_node you pass in as platform data. I'm not quite sure how well this
> will work. If you want to continue to use platform_data you should at least
> change the code in the ssi driver to not make a copy of the of_node.

Thanks, I did not think about using the parent, that is much easier. I
changed it for the next version.

Regards,

Markus

> 
> - Lars
> 
> > +
> >  	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
> >  		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> > -		SND_DMAENGINE_PCM_FLAG_NO_DT |
> >  		SND_DMAENGINE_PCM_FLAG_COMPAT);
> >  }
> >  
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
