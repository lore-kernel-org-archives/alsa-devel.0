From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: problem with snd_soc_dai_set_fmt()
Date: Thu, 29 Apr 2010 23:18:08 +0100
Message-ID: <20100429221808.GB23958@opensource.wolfsonmicro.com>
References: <4BD9F889.4010106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E1FE1038BF
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 00:18:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BD9F889.4010106@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 29, 2010 at 04:22:17PM -0500, Timur Tabi wrote:

> Let's say the DAI driver has not defined a .set_fmt() function.  This means
> that if the fabric driver does this:

*machine*

> ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
> if (ret < 0) {
> 	dev_err(dev, "could not set CPU driver audio format\n");
> 	return ret;
> }

> It's going to think that the DAI driver *rejected* the DAI format.  What
> this means is that I cannot make this function optional.  I have to define
> this function in my CPU driver.

Right, but really this is the case - the driver has completely ignored
what the machine driver was trying to do.  It may be that the default
behaviour is what was asked for, but it may also be that you've asked
for I2S format and got DSP format or something similiarly incompatible.

> int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> {
> 	if (dai->driver && dai->driver->ops->set_fmt)
> 		return dai->driver->ops->set_fmt(dai, fmt);
> 	else
> 		return 0;
> }

Due to the above issue I don't think this is a good idea - we really
ought to let the machine driver know if the request it made was ignored
in case it is trying to set up something that can't be supported.
Another short term option would be to change the error code to be
something a bit more distinctive than -EINVAL.  If we want to support
very generic machine drivers that genuinely don't know what hardware is
able to do I think we'd be be better off doing something like adding
capability masks to the drivers so these functions can validate what
they're being asked to do, at which point we know the actual format so
returning 0 isn't an issue.

The current expectation is that the machine driver knows what the
hardware is capable of and won't try to set anything silly, in the case
of fixed format devices that don't implement set_fmt() that consists of
just not calling set_fmt() for the DAI at all.

There is a genuine problem with the above code, BTW - the check for
driver->ops has got lost in the suffle.
