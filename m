From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] ASoC: WM8903: Expose GPIOs through
	gpiolib
Date: Thu, 20 Jan 2011 11:53:17 +0000
Message-ID: <20110120115317.GC2551@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B521B103A5B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 12:53:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295470205-26501-2-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 01:50:02PM -0700, Stephen Warren wrote:

This looks good, one query and one minor omission though.

>  /* Used to enable configuration of a GPIO to all zeros */
> -#define WM8903_GPIO_NO_CONFIG 0x8000
> +#define WM8903_GPIO_NO_CONFIG 0x10000

Why this change?  The top bit in the registers is never actually used,
really they're all 15 bit.

> +static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
> +	struct snd_soc_codec *codec = wm8903->codec;
> +
> +	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
> +				   WM8903_GP1_DIR_MASK, WM8903_GP1_DIR);
> +}

> +static int wm8903_gpio_direction_out(struct gpio_chip *chip,
> +				     unsigned offset, int value)
> +{
> +	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
> +	struct snd_soc_codec *codec = wm8903->codec;
> +
> +	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
> +				   WM8903_GP1_DIR_MASK | WM8903_GP1_LVL_MASK,
> +				   value << WM8903_GP2_LVL_SHIFT);
> +}

These should also set GPn_FN - to zero for GPIO output, 3 for GPIO
input.  Otherwise changing between input and output mode at runtime
won't do the right thing.  As a side effect of that you probably
wouldn't need to specify the GPIO configuration in platform data.
