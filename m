From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Fri, 27 Nov 2009 11:25:51 +0000
Message-ID: <20091127112550.GA29821@rakim.wolfsonmicro.main>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE68A10392E
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 12:25:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091126174245.GJ14091@buzzloop.caiaq.de>
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

On Thu, Nov 26, 2009 at 06:42:45PM +0100, Daniel Mack wrote:
> On Thu, Nov 26, 2009 at 04:03:51PM +0000, Mark Brown wrote:

> > You can test the flow by defining a fixed voltage regulator with no soft
> > control, obviously it won't actually turn the power on or off but the
> > code will run.

> Ok. I couldn't find a dummy framework for such cases, and registering a
> full regulator just to satisfy the codec code seems a litte cumbersome.
> Is there anything like that? Or should there be?

That's what the fixed voltage regulator was there for originally - the
GPIO is a later additional and is optional.

> > terribly well.  Currently the assumption is that if you've built in the
> > regulator API you intend to use it, otherwise it's very hard to tell if
> > the operation failed and broke something or failed because the API isn't
> > in use.

> Hmm - that will break all existing platforms that use this codec and
> need regulators for other drivers. But ok, I'm fine with forcing
> everyone to innovation :)

It's difficult to do much more without making driver code using
regulators more cumbersome - the need to figure out of the error is a
real one or due to partial API usage makes things painful.  If this were
supported it'd be better to do it with a fudge in the API rather than in
driver code, we really want to keep the drivers as simple as possible to
reduce the burden on them.

> Ok, done - see the new patch below. I did use the regulator_bulk
> functions in the first place, but due to the VA special case, I had to
> extract the single regulators again from the bulk struct which turned
> out to mess the code quite a bit. Looks better this way.

Yes, due to the one special regulator you have the bulk functions don't
help here.

> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		ret = regulator_enable(cs4270->vd_reg);
> +		if (ret < 0)
> +			return ret;
> +		ret = regulator_enable(cs4270->vlc_reg);
> +		if (ret < 0)
> +			return ret;
> +		/* fall thru */

I'd expect these to just be enabled on OFF->STANDBY (or in the suspend
code indeed) - you'll need to restore the register cache after the
digital comes up anyway.

Also, you'll leak references since you only turn them off when going
into OFF but enable them every time you go to ON.

> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->bias_level == SND_SOC_BIAS_OFF) {
> +			/* OFF -> STANDBY */
> +			ret = regulator_enable(cs4270->va_reg);
> +			if (ret < 0)
> +				return ret;
> +		} else
> +			regulator_disable(cs4270->va_reg);
> +		break;

Moving this into PREPARE and checking if the previous level was STANDBY
is probably more what you mean, otherwise the audio will be burning
power from startup until the first audio has played.

>  
> +	cs4270_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
>  	return snd_soc_write(codec, CS4270_PWRCTL, reg);

I think you need to reverse these so that you turn off the supplies
after you've done the soft power off.

> @@ -833,6 +918,11 @@ static int cs4270_soc_resume(struct platform_device *pdev)
>  	struct i2c_client *i2c_client = codec->control_data;
>  	int reg;
>  
> +	cs4270_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
> +		cs4270_set_bias_level(codec, SND_SOC_BIAS_ON);
> +

The core should take care of the BIAS_ON bit for you these days (some
drivers do do it by hand for historical reasons or because they're being
a bit naughty with the bias levels).
