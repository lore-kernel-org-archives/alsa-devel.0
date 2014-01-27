From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 6/6] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 27 Jan 2014 17:10:54 +0100
Message-ID: <20140127161054.GB9934@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
 <20140127151533.GA11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4E7F2265013
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 17:11:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140127151533.GA11727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Jan 27, 2014 at 03:15:33PM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 01:03:10PM +0100, Markus Pargmann wrote:
> 
> > +	aic32x4->supply_ldo = devm_regulator_get_optional(dev, "ldoin");
> > +	aic32x4->supply_iov = devm_regulator_get_optional(dev, "iov");
> > +	aic32x4->supply_dv = devm_regulator_get_optional(dev, "dv");
> > +	aic32x4->supply_av = devm_regulator_get_optional(dev, "av");
> 
> These shouldn't be optional, it seems unlikely that the device is going
> to work without power.  This will also be broken for probe deferral
> since the code will just ignore errors so if the error is -EPROBE_DEFER
> it'll not actually defer.

The manual describes the possible power supplies as the following:

dv has to be present if ldoin is not supplied or LDO_SELECT hardware pin
is low.
av has to be present if ldoin is not supplied.
iov is always necessary.
ldoin is necessary if both dv and av are not supplied.

I will try to catch all those conditions in the next version and fix the
EPROBE_DEFER.

> 
> Just use the normal bulk functions, as Fabio said this will be simpler
> too, and there should be code to disable on device removal at least
> (ideally also on suspend and resume, and while the device is idle if it
> doesn't have slow startup times).

Do the normal bulk functions handle optional regulators?

Thanks,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
