From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: cs4270: add power management
	support
Date: Tue, 05 May 2009 10:30:48 -0500
Message-ID: <4A005BA8.2070600@freescale.com>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<1241515501-6600-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 64A93103834
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 17:32:12 +0200 (CEST)
In-Reply-To: <1241515501-6600-2-git-send-email-daniel@caiaq.de>
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

> +static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
> +	struct snd_soc_codec *codec = &cs4270->codec;
> +	int reg = snd_soc_read(codec, CS4270_PWRCTL);
> +
> +	if (reg < 0)
> +		return reg;

You check for an error code from snd_soc_read() here, but ...

> +	/* ... then disable the power-down bits */
> +	reg = snd_soc_read(codec, CS4270_PWRCTL);

you don't check for it here.

In cs4270_i2c_suspend(), snd_soc_read() can never return an error,
because you're passing a hard-coded register address.

-- 
Timur Tabi
Linux kernel developer at Freescale
