From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add external amplifier controls for
	Visstrim_M10.
Date: Thu, 19 Jan 2012 15:45:21 +0000
Message-ID: <20120119154521.GG3178@opensource.wolfsonmicro.com>
References: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AB9E103C1F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 16:45:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2012 at 03:53:27PM +0100, Javier Martin wrote:
> Visstrim_M10 has an external class D amplifier.
> This patch provides support for controlling the 4
> possible gain levels and per channel muting.

It does seem like there could usefully be a generic driver but it's so
little code...

> +	switch (reg) {
> +	case MX27VIS_AMP_GAIN:
> +		gpio_set_value(MX27VIS_PIN_G0, value & 1);
> +		gpio_set_value(MX27VIS_PIN_G1, value >> 1);
> +		mx27vis_amp_gain = value;
> +		break;
> +	case MX27VIS_AMP_MUTE:
> +		gpio_set_value(MX27VIS_PIN_SDL, value & 1);
> +		gpio_set_value(MX27VIS_PIN_SDR, value >> 1);
> +		mx27vis_amp_mute = value;
> +		break;

These should validate that value is in range.

> +	ret = mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
> +			ARRAY_SIZE(mx27vis_amp_pins), "MX27VIS_AMP");
> +	if (ret) {
> +		printk(KERN_ERR "ASoC: unable to setup gpios\n");
> +		platform_device_put(mx27vis_aic32x4_snd_device);
> +	}

This looks awfully like it should be arch/arm code except it looks like
it also munges in the gpio_request.  Odd.
