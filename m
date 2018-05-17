From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] ASoC: ssm2305: Add amplifier driver
Date: Thu, 17 May 2018 15:38:53 +0200
Message-ID: <20180517133853.6vnqtnqo6x5mvkz5@pengutronix.de>
References: <20180517130047.15565-1-m.felsch@pengutronix.de>
 <6c7a72fc-f086-78e5-c920-809aeb738528@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 5896C267046
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 15:39:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6c7a72fc-f086-78e5-c920-809aeb738528@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 18-05-17 15:11, Lars-Peter Clausen wrote:
> On 05/17/2018 03:00 PM, Marco Felsch wrote:
> [...]
> > +	if (IS_ERR(priv->gpiod_shutdown)) {
> > +		err = PTR_ERR(priv->gpiod_shutdown);
> > +		if (err != -EPROBE_DEFER) {
> > +			dev_err(dev, "Failed to get 'shutdown' gpio: %d\n",
> > +				err);
> > +			return err;
> 
> You also want to return the error in the EPROBE_DEFER case, so the driver
> tries to probe again later.
> 

Yes, you're right.

> > +		}
> > +	}
> > +
> > +	return devm_snd_soc_register_component(dev, &ssm2305_component_driver,
> > +					       NULL, 0);
> > +}
> [...]
> 
