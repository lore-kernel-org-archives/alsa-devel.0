From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/5] [RFC] ALSA ASoC Support for TLVaic23b
	audio codec
Date: Mon, 29 Sep 2008 20:50:12 +0100
Message-ID: <20080929195011.GC21010@sirena.org.uk>
References: <dfeb90390809290241h2219ef57q2a7401aebf47efe5@mail.gmail.com>
	<48E1068E.7020908@boundarydevices.com>
	<20080929165404.GA16109@sirena.org.uk>
	<48E10FEA.7000300@boundarydevices.com>
	<20080929173937.GB18699@sirena.org.uk>
	<48E11753.3090100@boundarydevices.com>
	<20080929183045.GA21010@sirena.org.uk>
	<48E12789.50006@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E4EAB2451D
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 21:50:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E12789.50006@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 12:07:53PM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > Otherwise could you explain in more detail where you see the code
> > duplication coming from?

> My point, though admittedly a minor one, was that the I2C device
> or spi device could be initialized before the codec is probed.

> That would be moving code from codec files into board files.
> Better would be moving the code into a common soc directory file.

Ah, I think I see what you're talking about for at least this part of
your e-mails, though I'm not 100% sure.

Just to clarify, I *think* that what you're actually talking about here
is the fact that currently ASoC registers the entire ASoC subsystem off
the codec device registration with whatever control subsystem it uses
and therefore the final call to register the device is done within codec
driver code (though triggered by the machine driver)?

It would be much easier if you could be a *little* more verbose and/or
precise in your e-mails.  You started off by talking about wanting to
put the "I2C code" and "SPI code" into the board drivers which rather
suggests removing all bus access code.

> +	ret = aic23_init(socdev);
> +	if (ret < 0) {
> +		printk(KERN_ERR "aic23: failed to initialise AIC23\n");
> +		goto err;
> +	}
> ... The above would move to codec probe

The code you're quoting there is in the codec probe function?  init() is
split out so it can be shared between multiple control methods.

That said, there is an issue with this at the minute due to the fact
that the core does not yet use the device model properly and
(essentially) hangs all the drivers off the codec device which leads to
having both ai23_probe() which registers the I2C driver and
aic23_codec_probe().  This is half way to being rectified (the code
exists but is in the process of being merged) so that what happens is
that all the components of the system register with the ASoC core after
being probed normally from registrations done in the board init code or
similar.  This will remove all the socdev interaction from the codec
driver which is, I think, what you're getting at?

> +static struct i2c_driver aic23b_i2c_driver = {
> +       .driver = {
> +                  .name = "tlvaic23b",
> +                  },
> +       .probe = aic23_codec_probe,
> +       .remove = __exit_p(aic23_i2c_remove),
> +       .id_table = tlvaic23b_id,
> +};
> +
> +#endif

> If this code could be generalized to be useable by most
> codecs, I think the code would look better. This is the
> "almost" duplication to which I'm referring.

There's always a certain amount of bolierplate required to tell the
device core about drivers which isn't going away.  It's really very
small and the benefits in terms of things like refcounting modules and
autoloading them are worthwhile.
