From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for spi regmap
Date: Wed, 21 Mar 2012 22:11:20 +0530
Message-ID: <1332348080.21744.26.camel@matrix>
References: <1332345170.21744.10.camel@matrix>
	<20120321155635.GE3226@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe002.messaging.microsoft.com [213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 9313210449F
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 17:29:51 +0100 (CET)
In-Reply-To: <20120321155635.GE3226@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-03-21 at 15:56 +0000, Mark Brown wrote:
> On Wed, Mar 21, 2012 at 09:22:50PM +0530, Ashish Chavan wrote:
> 
> > +#if defined(CONFIG_SPI_MASTER)
> > +	/* Dummy read to give two pulses over nCS */
> > +	regmap_read(da7210->regmap, DA7210_STATUS, &val);
> > +	regmap_read(da7210->regmap, DA7210_STATUS, &val);
> > +	regmap_read(da7210->regmap, DA7210_STATUS, &val);
> > +#endif
> 
> This ifdef stuff should all be runtime configured based on the bus type,
> unless the cost of the reads is considered immaterial in which case it
> should be unconditional.
> 

OK, will make it runtime.

> > +#if defined(CONFIG_SPI_MASTER)
> > +	snd_soc_write(codec, 0x00, 0x80);
> > +#endif
> 
> Hrm?

This is writing to page register. SPI register space is divided in to
two pages. Registers from 0x01 to 0x80 fall in to first page. If we want
to write to any register above 0x80, first we need to set page register
with PAGE1. May be I should put comments to make it obvious.

> 
> >  	/* unlock */
> >  	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x8B);
> > @@ -1035,6 +1056,10 @@ static int da7210_probe(struct snd_soc_codec *codec)
> >  	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x00);
> >  	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0x00);
> 
> I also note that you've not yet updated this to use a regmap patch as
> was previously requested.

Actually I don't have enough details about the problem that you
mentioned with this. I am waiting for inputs from some body else. Can
you please elaborate the problem if you have details? so that I can
correct it.

> 
> > +#if defined(CONFIG_SPI_MASTER)
> > +static int __devinit da7210_spi_probe(struct spi_device *spi)
> > +{
> > +	struct da7210_priv *da7210;
> > +	int ret;
> > +
> > +	da7210 = kzalloc(sizeof(struct da7210_priv), GFP_KERNEL);
> > +	if (!da7210)
> > +		return -ENOMEM;
> 
> devm_kzalloc().

OK for this and rest of all comments. I will take care of them in next
submission soon.
