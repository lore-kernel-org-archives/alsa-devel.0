From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/5] input: twl6040-vibra: Do not use
	wrapper for irq request
Date: Tue, 5 Jul 2011 17:10:13 +0300
Message-ID: <1462382.yEDobJovyP@barack>
References: <1309873775-17927-1-git-send-email-peter.ujfalusi@ti.com>
	<1309873775-17927-3-git-send-email-peter.ujfalusi@ti.com>
	<20110705135745.GN2820@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE0D24369
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 16:10:18 +0200 (CEST)
In-Reply-To: <20110705135745.GN2820@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 05 July 2011 15:57:46 Balbi, Felipe wrote:
> > +	info->irq =3D platform_get_irq(pdev, 0);
> > +	if (!info->irq) {
> =

> this is wrong. platform_get_irq() will return -ENXIO if it can't find
> the IRQ you requested:
> =

>   55 /**
>   56  * platform_get_irq - get an IRQ for a device
>   57  * @dev: platform device
>   58  * @num: IRQ number index
>   59  */
>   60 int platform_get_irq(struct platform_device *dev, unsigned int num)
>   61 {
>   62         struct resource *r =3D platform_get_resource(dev, IORESOURCE=
_IRQ,
> num); 63
>   64         return r ? r->start : -ENXIO;
>   65 }
>   66 EXPORT_SYMBOL_GPL(platform_get_irq);

Yes, I have not checked that..
Will replace the check with (info->irq< 0) checks in both slaves.

Thanks for noticing it!
I'll wait a bit for other comments, and will resend.

-- =

P=E9ter
