From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: au1x: platform
	driver	restructuring
Date: Sat, 13 Jun 2009 18:44:25 +0100
Message-ID: <20090613174424.GA19484@sirena.org.uk>
References: <4A33BEF0.6020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 79D1D245EC
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 19:44:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A33BEF0.6020602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 05:00:00PM +0200, Manuel Lauss wrote:

> -static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
> +static int au1xpsc_ac97_suspend(struct platform_device *pdev, pm_message_t m)
>  {
>  	/* save interesting registers and disable PSC */
>  	au1xpsc_ac97_workdata->pm[0] =
> @@ -328,7 +366,7 @@ static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
>  	return 0;
>  }

I'm don't think this is a good idea - it will remove any sequencing
between the suspend of the various ASoC device components, meaning that
the AC97 controller could suspend before the rest of ASoC.  This would
break if ASoC then comes along and tries to suspend the CODEC over an
AC97 link which has been disabled.  With I2S it's probably less serious
but there's a risk of audio issues if the hardware does something dodgy
when suspending or if the SoC is the clock master and the CODEC gets
upset about having clocks stopping when it's using them.

In order to do this properly I have a plan to add a calls into the ASoC
core that the individual drivers can call when they get suspend and
resume calls.  The core will suspend the entire ASoC device when it gets
the first suspend call and will wait for all the suspended devices to
resume before it resumes the ASoC device.  I've not actually added those
calls yet, though.  I can add stubs quickly enough, though - I should
probably do that just now so that we don't need a separate driver
conversion step.

One other thing I'd say is that before registering the DAIs you should
assign the dev field in the DAI structure to be the struct device that
was used to probe the DAI.
