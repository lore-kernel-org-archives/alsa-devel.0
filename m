From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v2 1/4] ASoC: WM8903: Expose GPIOs through
	gpiolib
Date: Thu, 20 Jan 2011 09:23:45 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03109556B6@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295470205-26501-2-git-send-email-swarren@nvidia.com>
	<20110120115317.GC2551@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id B86E4103A85
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 18:24:48 +0100 (CET)
In-Reply-To: <20110120115317.GC2551@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote on Thursday, January 20, 2011 4:53 AM:
> 
> On Wed, Jan 19, 2011 at 01:50:02PM -0700, Stephen Warren wrote:
> 
> This looks good, one query and one minor omission though.
> 
> >  /* Used to enable configuration of a GPIO to all zeros */
> > -#define WM8903_GPIO_NO_CONFIG 0x8000
> > +#define WM8903_GPIO_NO_CONFIG 0x10000
> 
> Why this change?  The top bit in the registers is never actually used,
> really they're all 15 bit.

Some other registers appear to have bit 15 defined, so I made sure this flag
was completely outside any valid register bits.

Although mainly, I just made it consistent with wm8962.h, which I assume
picked that value for the same reason.

That said, the original value was OK for the GPIO registers, so I can revert
that if you want.

> > +static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
> > +{
> > +	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
> > +	struct snd_soc_codec *codec = wm8903->codec;
> > +
> > +	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
> > +				   WM8903_GP1_DIR_MASK, WM8903_GP1_DIR);
> > +}
> 
> > +static int wm8903_gpio_direction_out(struct gpio_chip *chip,
> > +				     unsigned offset, int value)
> > +{
> > +	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
> > +	struct snd_soc_codec *codec = wm8903->codec;
> > +
> > +	return snd_soc_update_bits(codec, WM8903_GPIO_CONTROL_1 + offset,
> > +				   WM8903_GP1_DIR_MASK | WM8903_GP1_LVL_MASK,
> > +				   value << WM8903_GP2_LVL_SHIFT);
> > +}
> 
> These should also set GPn_FN - to zero for GPIO output, 3 for GPIO
> input.  Otherwise changing between input and output mode at runtime
> won't do the right thing.  As a side effect of that you probably
> wouldn't need to specify the GPIO configuration in platform data.

Ooops. I didn't notice that. How does this interact with bit 7; GPn_DIR? I
assume both need to be set appropriately since they're both defined bits.

-- 
nvpublic
