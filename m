From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/6] ASoC: dwc: Remove unnecessary debug messages and
 tests
Date: Fri, 12 Dec 2014 02:06:12 -0800
Message-ID: <1418378772.18092.42.camel@perches.com>
References: <cover.1418372910.git.Andrew.Jackson@arm.com>
	 <97f65b6037b9ac676f6ca7717a230a68cbe81fd1.1418372910.git.Andrew.Jackson@arm.com>
	 <1418376671.18092.40.camel@perches.com> <548AB7EC.4020502@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <548AB7EC.4020502@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-12-12 at 09:39 +0000, Andrew Jackson wrote:
> On 12/12/14 09:31, Joe Perches wrote:
> > On Fri, 2014-12-12 at 09:25 +0000, Andrew Jackson wrote:
> >> The devm_XXX allocation functions print a message on failure,
> >> so additional messages are not required.
> > []
> >> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> > []
> >> @@ -345,26 +345,17 @@ static int dw_i2s_probe(struct platform_device *pdev)
> >>  	}
> >>  
> >>  	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
> >> -	if (!dw_i2s_dai) {
> >> -		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");
> >> +	if (!dw_i2s_dai)
> >>  		return -ENOMEM;
> >> -	}
> > 
> > ok.
> >  
> >>  	dw_i2s_dai->ops = &dw_i2s_dai_ops;
> >>  	dw_i2s_dai->suspend = dw_i2s_suspend;
> >>  	dw_i2s_dai->resume = dw_i2s_resume;
> >>  
> >>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -	if (!res) {
> >> -		dev_err(&pdev->dev, "no i2s resource defined\n");
> >> -		return -ENODEV;
> >> -	}
> >> -
> > 
> > Why delete this?
> 
> Lars-Peter said that it was unnecessary: see <http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308416.html>.
> > 
> >>  	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
> >> -	if (IS_ERR(dev->i2s_base)) {
> >> -		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
> >> +	if (IS_ERR(dev->i2s_base))
> >>  		return PTR_ERR(dev->i2s_base);
> >> -	}
> > 
> > or this?
> 
> Ditto

OK, but your commit message doesn't match the changes.

These messages are redundant not what most consider
debugging messages (ie: emitted at KERN_DEBUG).

The 2nd one isn't a devm_<foo> function and the last
one isn't an allocation.
