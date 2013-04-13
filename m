From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Sat, 13 Apr 2013 15:55:35 +0200
Message-ID: <20130413135535.GD4573@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <5161CB73.4000302@metafoo.de>
 <20130407200843.GA8350@pengutronix.de>
 <5161D876.6020007@metafoo.de>
 <20130413133202.GA4573@pengutronix.de>
 <51696034.6060709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51696034.6060709-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
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
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 13, 2013 at 03:40:04PM +0200, Lars-Peter Clausen wrote:
> On 04/13/2013 03:32 PM, Markus Pargmann wrote:
> > On Sun, Apr 07, 2013 at 10:35:02PM +0200, Lars-Peter Clausen wrote:
> >> On 04/07/2013 10:08 PM, Markus Pargmann wrote:
> >>> Hi,
> >>>
> >>> On Sun, Apr 07, 2013 at 09:39:31PM +0200, Lars-Peter Clausen wrote:
> >>>> On 04/07/2013 09:25 PM, Markus Pargmann wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This series adds DT support for phycore-ac97 using the fsl-ssi driver. In
> >>>>> version 2 I discarded most of the imx-ssi work and integrated the ac97-slave
> >>>>> support in fsl-ssi, including support for imx-pcm-fiq as alternative to dma.
> >>>>> There are some other changes to get phycore-ac97 working. The first two patches
> >>>>> have notes about the detailed changes since version 1. The rest of the patches
> >>>>> is new and necessary for the ac97-slave support.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Markus
> >>>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> The DMA PCM related changes won't apply anymore due to the recent dmaengine
> >>>> PCM cleanups. I've also been working on a more generic dmaengine PCM driver
> >>>> which has DT support and can be used by imx. The work in progress patches
> >>>> can be found here:
> >>>> https://github.com/lclausen-adi/linux-2.6/commits/asoc-dmaengine-cleanups
> >>>>
> >>>> - Lars
> >>>
> >>> Okay, I will rebase it for v3 onto your committed cleanups and will have
> >>> a look on your latest patches.
> >>>
> >>
> >> It might be a good idea to rebase it ontop of the generic dmaengine driver
> >> patches right away, since it will simplify things quite a bit.
> > 
> > I rebased the series onto your branch now. But there is a small problem
> > with the DMA handling.
> > 
> > Currently you pass the device pointer into snd_dmaengine_pcm_register
> > and use it to request the dma channels. At least for imx-pcm-audio
> > driver, it would be useful to pass a second device just for the dma
> > requests. Otherwise imx-pcm-audio needs devicetree bindings, but I think
> > the dma properties belong to fsl-ssi.
> > 
> 
> I though about that as well, just initialize of_node of the newly allocated
> imx-pcm-audio platform device to that of the parent device. That should work
> nicely.

Okay, I wasn't sure if this is good practice, but then I will do it
like this.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
