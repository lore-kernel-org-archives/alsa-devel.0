From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Question about pxa2xx-ac97-lib.c
Date: Sun, 12 Apr 2009 19:02:40 +0200
Message-ID: <200904121902.41007.marek.vasut@gmail.com>
References: <200904121647.39464.marek.vasut@gmail.com>
	<20090412170036.GB4295@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C4654103805
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 19:02:32 +0200 (CEST)
Received: by fxm18 with SMTP id 18so1907248fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2009 10:02:32 -0700 (PDT)
In-Reply-To: <20090412170036.GB4295@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sunday 12 of April 2009 19:00:37 Mark Brown wrote:
> On Sun, Apr 12, 2009 at 04:47:39PM +0200, Marek Vasut wrote:
> > One more thing, I'd like to ask how to change the reset_gpio in the above
> > file. Will I have to make copy of pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI] in
> > palm27x.c and change the .probe pointer to my own function that sets the
> > proper platform data? That is, something like the following? Thanks
>
> BTW, I meant to say in reply to the previous mail - you really should
> copy all audio discussion to at least alsa-devel.
>
> > +/* Palms use GPIO95 for AC97 reset */
> > +static int palm_ac97_probe(struct platform_device *pdev,
> > +                            struct snd_soc_dai *dai)
> > +{
> > +       struct platform_device *pd = to_platform_device(dai->dev);
> > +       static struct pxa2xx_ac97_platform_data pdata = {
> > +               .reset_gpio = 95,
> > +       };
> > +       printk("%s[%i]\n", __FUNCTION__, __LINE__);
> > +       pd->dev.platform_data = &pdata;
> > +       return pxa2xx_ac97_hw_probe(pd);
> > +}
>
> Look in mainline - pxa2xx-ac97-lib already provides platform data based
> configuration of the GPIO to use for reset.

Yes, I sent the new version and CCed alsa-devel.
