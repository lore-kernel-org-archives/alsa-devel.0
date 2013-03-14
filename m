From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 07/10] ASoC: phycore-ac97: Add DT support
Date: Thu, 14 Mar 2013 13:55:45 +0100
Message-ID: <20130314125545.GD32452@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-8-git-send-email-mpa@pengutronix.de>
 <20130312185921.GX19942@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130312185921.GX19942-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 12, 2013 at 06:59:22PM +0000, Mark Brown wrote:
> On Sun, Mar 10, 2013 at 07:33:08PM +0100, Markus Pargmann wrote:
> > Add devicetree support for this audio soc fabric driver.
> > 
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  sound/soc/fsl/phycore-ac97.c | 148 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 125 insertions(+), 23 deletions(-)
> 
> A binding document is mandatory for new bindings.
> 
> > +#ifdef CONFIG_MACH_IMX27_DT
> > +		.cpu_dai_name	= "10010000.ssi",
> > +		.platform_name	= "imx-fiq-pcm-audio",
> > +#else
> 
> This looks wrong, at least the CPU DAI name should be being looked up
> via the DT.

Yes.

> 
> > +static const struct of_device_id imx_phycore_ac97_of_dev_id[] = {
> > +	{
> > +		.compatible = "phytec,imx27-pca100-ac97",
> > +		.data = (void *)MX27_PCA100,
> > +	}, {
> > +		.compatible = "phytec,imx27-pcm043-ac97",
> > +		.data = (void *)MX27_PCM043
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_phycore_ac97_of_dev_id);
> 
> It seems like we ought to be able to describe the properties of the
> boards in this class rather than just enumerating the boards.  What are
> the differences?

All right I will change it. They are actually using different audmux
port configuration.

> 
> >  MODULE_AUTHOR("Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> > -MODULE_DESCRIPTION("PhyCORE ALSA SoC driver");
> > +MODULE_DESCRIPTION(DRV_NAME ": PhyCORE ALSA SoC fabric driver");
> 
> Please don't make up terms like "fabric driver".

I didn't make it up. There are actually other drivers with that name,
like "mpc5200 pcm030 fabric driver" or "mpc5200 Efika fabric driver"
which actually do the same as this one.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
