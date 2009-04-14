From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Tue, 14 Apr 2009 19:51:07 +0200
Message-ID: <200904141951.07749.marek.vasut@gmail.com>
References: <200904121858.42931.marek.vasut@gmail.com>
	<20090412175800.GA8209@sirena.org.uk>
	<200904122051.19335.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EAED24462
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 19:51:04 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2790098fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 10:51:04 -0700 (PDT)
In-Reply-To: <200904122051.19335.marek.vasut@gmail.com>
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

On Sunday 12 of April 2009 20:51:19 Marek Vasut wrote:
> On Sunday 12 of April 2009 19:58:00 Mark Brown wrote:
> > On Sun, Apr 12, 2009 at 07:20:15PM +0200, Marek Vasut wrote:
> > > On Sunday 12 of April 2009 19:06:26 Mark Brown wrote:
> > > > > +static struct platform_device palmld_pxa2xx_pcm = {
> > > >
> > > > This should follow the pattern that everything else uses with the
> > > > struct platform_device in devices.c and board files triggering
> > > > registration of that.
> > >
> > > Half of the platforms use static struct, half use struct. Probably
> > > someone should send a huge patch to make it consistent. I'd like to
> > > have it consistent at least inside the platform file.
> >
> > The general rule is that if it's a part of the CPU it should go in
> > devices.c - things that aren't doing that are mostly just waiting for
> > cleanup.
> >
> > > > > +static struct platform_device palmld_pxa2xx_ac97 = {
> > > > > +	.name = "pxa2xx-ac97",
> > > > > +	.id   = -1,
> > > > > +	.dev  = {
> > > > > +		.platform_data = &palmld_ac97_pdata,
> > > > > +	},
> > > > > +};
> > > >
> > > > No, use pxa_set_ac97_info().
> > >
> > > How?
> >
> > Pass the platform data as the argument.  This will currently involve
> > merging the two different platform data structures that we have right
> > now.
>
> OK, I see, thanks :-) Will you be happier with this patch then ?

So is it ok this way ? I'd be glad to fix the problem ASAP.
