From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: cs4270: add power management
	support
Date: Tue, 05 May 2009 12:55:21 -0500
Message-ID: <4A007D89.8020602@freescale.com>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<1241515501-6600-2-git-send-email-daniel@caiaq.de>
	<4A005BA8.2070600@freescale.com>
	<20090505155116.GD24556@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DB3D0103808
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 19:56:27 +0200 (CEST)
In-Reply-To: <20090505155116.GD24556@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:

> From d2303f37695145018e07aad85200f06b24341648 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Thu, 2 Apr 2009 15:43:44 +0200
> Subject: [PATCH 2/2] ASoC: cs4270: add power management support

You forgot to add "v2" to the subject line.  And you'll need a v3 on the
next version of the patch, because ...

> +static int cs4270_i2c_resume(struct i2c_client *client)
> +{
> +	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec = &cs4270->codec;
> +	int reg;
> +
> +	/* In case the device was put to hard reset during sleep, we need to
> +	 * wait 500ns here before any I2C communication. */
> +	ndelay(500);
> +
> +	/* first restore the entire register cache ... */
> +	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
> +		u8 val = snd_soc_read(codec, reg);
> +
> +		if (i2c_smbus_write_byte_data(client, reg, val)) {
> +			dev_err(codec->dev, "i2c write failed\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	/* ... then disable the power-down bits */
> +	reg = snd_soc_read(codec, CS4270_PWRCTL);
> +	if (reg < 0)
> +		return reg;

... you forgot this "reg < 0" check. Also, ...

> +static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec = &cs4270->codec;
> +	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
> +	return snd_soc_write(codec, CS4270_PWRCTL, reg);
> +}

... you need a blank line above the "return"


> +
> +	reg &= ~CS4270_PWRCTL_PDN_ALL;
> +	return snd_soc_write(codec, CS4270_PWRCTL, reg);
> +}

And here.

-- 
Timur Tabi
Linux kernel developer at Freescale
