From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Sun, 12 Apr 2009 19:24:24 +0200
Message-ID: <200904121924.24781.marek.vasut@gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<20090412170626.GD4295@sirena.org.uk>
	<200904121920.15488.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 953F5103815
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 19:24:16 +0200 (CEST)
Received: by bwz23 with SMTP id 23so1945546bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2009 10:24:16 -0700 (PDT)
In-Reply-To: <200904121920.15488.marek.vasut@gmail.com>
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

On Sunday 12 of April 2009 19:20:15 Marek Vasut wrote:
> On Sunday 12 of April 2009 19:06:26 Mark Brown wrote:
> > On Sun, Apr 12, 2009 at 06:58:42PM +0200, Marek Vasut wrote:
> > > +static struct platform_device palmld_pxa2xx_pcm = {
> > > +	.name = "pxa2xx-pcm",
> > > +	.id   = -1,
> > > +};
> >
> > This should follow the pattern that everything else uses with the struct
> > platform_device in devices.c and board files triggering registration of
> > that.
>
> Half of the platforms use static struct, half use struct. Probably someone
> should send a huge patch to make it consistent. I'd like to have it
> consistent at least inside the platform file.
>
> > > +static struct platform_device palmld_pxa2xx_ac97 = {
> > > +	.name = "pxa2xx-ac97",
> > > +	.id   = -1,
> > > +	.dev  = {
> > > +		.platform_data = &palmld_ac97_pdata,
> > > +	},
> > > +};
> >
> > No, use pxa_set_ac97_info().
>
> How?
>
> > > +static struct platform_device palmld_wm9712_codec = {
> >
> > No, the WM9712 is not a platform device.

btw mio_a701 uses it the same way ... why can I ? Why was the mio code merged 
then?
