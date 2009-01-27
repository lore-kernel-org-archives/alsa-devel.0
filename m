From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 20:00:52 +0000
Message-ID: <20090127200051.GA6424@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271749.38788.anarsoul@gmail.com>
	<74d0deb30901270806s166f5336g3086e42477913e1d@mail.gmail.com>
	<200901271822.32537.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B2F824390
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:00:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901271822.32537.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 06:22:25PM +0200, Vasily Khoruzhick wrote:

> Btw, on rx1950 there're 4 gpio pins involved:
> GPJ0 controls codec power
> GPA1 controls amplifier power
> GPG12 is jack sense pin, it's value depends whether headphone jack is inserted 
You might want to have a look at the jack reporting API that was
recently added, it should save you a bit of code:

	http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=8a2cd6180f8fa00111843c2f4a4f4361995358e0

It'll need a little helper for GPIOs adding to the core but that should
be reusable.

> 	down(&rx1950_power_mutex);
> 	printk("%s: enable == %d\n", __func__, enable);
> 	if (enable) {
> 		if (s3c2410_gpio_getpin(S3C2440_GPJ0))
> 			goto done;
> 		//spin_lock(&cmpl_lock);
> 		//waiting_for_completion = 1;
> 		//spin_unlock(&cmpl_lock);
> 		s3c2410_gpio_setpin(S3C2410_GPD0, 0);
> 		s3c2410_gpio_setpin(S3C2440_GPJ0, 0);
> 		s3c2410_gpio_setpin(S3C2440_GPJ0, 1);
> 
> 		/* Wait for EINT20 irq to ensure uda1380 is powered */
> 		//printk("%s: waiting for compeltion...\n", __func__);
> 		//wait_for_completion(&rx1950_sound_completion);
> 		//printk("%s: completed\n", __func__);
> 		//printk("%s: GPG12: %d\n", __func__,
> 		//	s3c2410_gpio_getpin(S3C2410_GPG12));
> 		mdelay(50);
> 		s3c2410_gpio_setpin(S3C2410_GPD0, 1);
> 		s3c2410_gpio_setpin(S3C2410_GPD0, 0);

Hrm.  The completion makes this look more like it could use a full blown
regulator - it's certainly a pattern that will get reused often enough.

> 	/* configure some gpios */
> 	s3c2410_gpio_cfgpin(S3C2410_GPD0, S3C2410_GPIO_OUTPUT);
> 	s3c2410_gpio_cfgpin(S3C2410_GPG12, S3C2410_GPIO_IRQ);
> 	s3c2410_gpio_cfgpin(S3C2440_GPJ0, S3C2410_GPIO_OUTPUT);

The S3C24xx now supports gpiolib so you should be able to use that - the
platform specific GPIO API will probably get killed at some point.
