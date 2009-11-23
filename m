From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 6/8] Audio driver of Always Innovating
	OMAP3-based Touch Book
Date: Mon, 23 Nov 2009 15:35:04 +0000
Message-ID: <20091123153504.GD3987@sirena.org.uk>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com> <1258651091-31727-2-git-send-email-gregoire@gentil.com> <1258651091-31727-3-git-send-email-gregoire@gentil.com> <1258651091-31727-4-git-send-email-gregoire@gentil.com> <1258651091-31727-5-git-send-email-gregoire@gentil.com> <1258651091-31727-6-git-send-email-gregoire@gentil.com> <1258651091-31727-7-git-send-email-gregoire@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258651091-31727-7-git-send-email-gregoire@gentil.com>
Sender: linux-omap-owner@vger.kernel.org
To: Gregoire Gentil <gregoire@gentil.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Tim Yamin <plasmaroo@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 09:18:09AM -0800, Gregoire Gentil wrote:

> Signed-off-by: Gregoire Gentil <gregoire@gentil.com>

Please remember to CC the maintainers for the subsystem you're
submitting to on patches.

> +static irqreturn_t touchbook_headphone_event(int irq, void *snd)
> +{
> +	int status = gpio_get_value(TB_HEADPHONE_GPIO);
> +	struct snd_soc_device *socdev = platform_get_drvdata(
> +						omap3touchbook_snd_device);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +
> +	if (status) {
> +		snd_soc_dapm_disable_pin(codec, "HFL");
> +		snd_soc_dapm_disable_pin(codec, "HFR");
> +	} else {
> +		snd_soc_dapm_enable_pin(codec, "HFL");
> +		snd_soc_dapm_enable_pin(codec, "HFR");
> +	}
> +
> +	schedule_work(&jack_work);
> +	return IRQ_HANDLED;
> +}

All this jack handling should be using the standard GPIO based jack
abstraction provided by sound/soc/soc-jack.c.  That will also give
userspace visiblity of the status of the jack, allowing better
application integration.  sdp3430 and ams-delta provide examples of
using the API.
