From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 5/6] ASoC: OMAP4: Add HDMI Audio machine
 driver for OMAP4 boards
Date: Thu, 05 May 2011 16:09:19 -0500
Message-ID: <1304629759.1900.111.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-6-git-send-email-ricardo.neri@ti.com>
	<20110505082516.GG11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id B481A10381C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 23:09:11 +0200 (CEST)
In-Reply-To: <20110505082516.GG11744@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, den 05.05.2011, 03:25 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:21:52AM -0500, Ricardo Neri wrote:
> 
> > +static struct snd_soc_dai_link omap4_hdmi_dai = {
> > +		.name = "HDMI",
> > +		.stream_name = "HDMI",
> 
> Indentation.
I will correct.
> 
> > +static __devinit int omap4_hdmi_probe(struct platform_device *pdev)
> > +{
> > +	struct snd_soc_card *card = &snd_soc_omap4_hdmi;
> > +	int ret;
> > +
> > +	if (!cpu_is_omap44xx()) {
> > +		dev_err(&pdev->dev, "Not running on OMAP4!\n");
> > +		return -ENODEV;
> > +	}
> 
> Why check this?  If the system can't support the DAIs they won't
> register so it's redundant and it means more work for OMAP5.
I will remove this verification.
> 
> > +	card->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, card);
> 
> The set_drvdata() isn't needed.
I will remove this as well.
> 
> > +	snd_soc_unregister_card(card);
> > +	platform_set_drvdata(pdev, NULL);
> 
> You never need to reset driver data on unregister, nothing should
> reference it except a driver.
I saw that other drivers (harmony and mfld) reset driver data after
unregister. Is that incorrect as well? Anyways, I don't needed for my
driver.

> 
> > +MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
> > +MODULE_DESCRIPTION("OMAP4 HDMI machine ASoC driver");
> > +MODULE_LICENSE("GPL");
> 
> MODULE_ALIAS().
I will add.
