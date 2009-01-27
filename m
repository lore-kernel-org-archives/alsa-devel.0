From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 15:00:41 +0000
Message-ID: <20090127150040.GD11870@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F231037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 16:00:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901271519.47119.anarsoul@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 03:19:39PM +0200, Vasily Khoruzhick wrote:

> I'm trying to develop asoc driver for hp ipaq rx1950 (s3c24xx + uda1380).
> 
> 1st question: where I can enable/disable uda1380 codec power? I need to 
> control codec power for powersave reasons.

CCing in Philipp Zabel who wrote the UDA1380 driver.  Assuming you mean
control to cut the power to the chip the most standard way of doing it
would be with the regulator API but if the chip isn't being used much in
new designs it might not be worth it.

> I tried to add custom power function call to uda1380_set_bias_level in 
> uda1380.c (pointer to power function is stored in codec->private_data), as it 
> done for uda134x codec, but after enable-disable-enable cycle (for example, 
> after resuming from suspend) driver cannot communicate with codec anymore 
> (i2c bus is always busy), only reloading i2c driver helps.

The UDA134x is a bit of a special case since it needs the machine driver
to provide bitbanging functions for the L3 interface.

> 2nd question: for some reason, driver does not produce any sound during first 
> aplay invocation, only second and later aplay invocation driver produces 
> sound. What can be the reason of this problem?

That sounds like something in the teardown path should be done on
startup as well.  Can't think of any obvious gotchas there, though I'd
be looking at the codec and machine drivers since the CPU driver for the
S3C24xx is used in quite a few designs.
