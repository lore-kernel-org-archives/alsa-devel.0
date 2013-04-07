From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Sun, 07 Apr 2013 22:35:02 +0200
Message-ID: <5161D876.6020007@metafoo.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <5161CB73.4000302@metafoo.de> <20130407200843.GA8350@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130407200843.GA8350-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 04/07/2013 10:08 PM, Markus Pargmann wrote:
> Hi,
> 
> On Sun, Apr 07, 2013 at 09:39:31PM +0200, Lars-Peter Clausen wrote:
>> On 04/07/2013 09:25 PM, Markus Pargmann wrote:
>>> Hi,
>>>
>>> This series adds DT support for phycore-ac97 using the fsl-ssi driver. In
>>> version 2 I discarded most of the imx-ssi work and integrated the ac97-slave
>>> support in fsl-ssi, including support for imx-pcm-fiq as alternative to dma.
>>> There are some other changes to get phycore-ac97 working. The first two patches
>>> have notes about the detailed changes since version 1. The rest of the patches
>>> is new and necessary for the ac97-slave support.
>>>
>>> Regards,
>>>
>>> Markus
>>>
>>
>> Hi,
>>
>> The DMA PCM related changes won't apply anymore due to the recent dmaengine
>> PCM cleanups. I've also been working on a more generic dmaengine PCM driver
>> which has DT support and can be used by imx. The work in progress patches
>> can be found here:
>> https://github.com/lclausen-adi/linux-2.6/commits/asoc-dmaengine-cleanups
>>
>> - Lars
> 
> Okay, I will rebase it for v3 onto your committed cleanups and will have
> a look on your latest patches.
> 

It might be a good idea to rebase it ontop of the generic dmaengine driver
patches right away, since it will simplify things quite a bit.

- Lars

> Regards,
> 
> Markus
> 
>>
>>>
>>> Markus Pargmann (11):
>>>   ASoC: phycore-ac97: Add DT support
>>>   ASoC: imx-pcm-dma: Add support for DMA init by
>>>   ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
>>>   ASoC: fsl-ssi: Add SACNT definitions
>>>   ASoC: fsl-ssi: Add support for imx-pcm-fiq
>>>   ASoC: fsl-ssi: Setup generic imx dma params
>>>   ARM: imx: Export ac97 reset functions
>>>   ASoC: fsl-ssi: imx ac97 support
>>>   ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
>>>   ASoC: fsl: Move fsl-ssi binding doc to sound/
>>>   ASoC: fsl: Update fsl-ssi binding doc
>>>
>>>  Documentation/devicetree/bindings/powerpc/fsl/ssi.txt             |   73 -
>>>  Documentation/devicetree/bindings/sound/fsl,ssi.txt               |   13 
>>>  b/Documentation/devicetree/bindings/sound/fsl,ssi.txt             |   73 +
>>>  b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt |   12 
>>>  b/arch/arm/mach-imx/mach-pca100.c                                 |    7 
>>>  b/arch/arm/mach-imx/mach-pcm043.c                                 |    7 
>>>  b/sound/soc/fsl/Kconfig                                           |    2 
>>>  b/sound/soc/fsl/fsl_ssi.c                                         |   70 +
>>>  b/sound/soc/fsl/fsl_ssi.h                                         |    8 
>>>  b/sound/soc/fsl/imx-pcm-dma.c                                     |   31 
>>>  b/sound/soc/fsl/imx-pcm-fiq.c                                     |   14 
>>>  b/sound/soc/fsl/imx-pcm.h                                         |    6 
>>>  b/sound/soc/fsl/imx-ssi.c                                         |    7 
>>>  b/sound/soc/fsl/imx-ssi.h                                         |    1 
>>>  b/sound/soc/fsl/phycore-ac97.c                                    |  185 ++++
>>>  sound/soc/fsl/fsl_ssi.c                                           |  379 +++++++---
>>>  sound/soc/fsl/imx-pcm.h                                           |    9 
>>>  17 files changed, 664 insertions(+), 233 deletions(-)
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
> 
