From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Thu, 26 Nov 2009 16:03:51 +0000
Message-ID: <20091126160351.GB10674@rakim.wolfsonmicro.main>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B331F244DA
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 17:03:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091126154807.GI14091@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2009 at 04:48:07PM +0100, Daniel Mack wrote:

> - I only added VA for now because when VD is disabled, we need to
>   restore all codec information, and I can't test that here. We can
>   still add that later, right?

I'd suggest just adding it blind.  The code is very simple and it's much
easier to fix if there's a problem than it is to go through retrofit the
additional regulator hookups to boards if the other supplies are added
later.

You can test the flow by defining a fixed voltage regulator with no soft
control, obviously it won't actually turn the power on or off but the
code will run.

> - I'm tracking the va_reg enable state inside the driver to take anyone
>   else's reference. Is that the way do do it?

Yes.  You can also check if you're doing a PREPARE<->STANDBY transition
but either way works.  Existing drivers only do the enables/disables in
off which makes this really easy.

> +	/* get the power supply regulators (optional) */
> +	cs4270->va_reg = regulator_get(&pdev->dev, "va");
> +	if (IS_ERR(cs4270->va_reg))
> +		cs4270->va_reg = NULL;

Just fail if you can't get the supply.  If you can't get the regulator
then you've no analogue supply and the CODEC isn't going to work
terribly well.  Currently the assumption is that if you've built in the
regulator API you intend to use it, otherwise it's very hard to tell if
the operation failed and broke something or failed because the API isn't
in use.

>  	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
>  	struct snd_soc_codec *codec = &cs4270->codec;
>  
> +	cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
>  	return snd_soc_suspend_device(codec->dev);
>  }

This patch isn't against current for-2.6.33 - those functions have been
removed.  Better to do the bias management in the ASoC suspend/resume
callbacks anyway so that it's joined up with the register save/restore.
Until we get the pm_link stuff in the next merge window there's no link
between the I2C bus suspend and the platform bus suspend for the ASoC
core.
