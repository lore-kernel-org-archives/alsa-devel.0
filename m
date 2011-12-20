From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dsd1791: Introduce driver for TI
 DSD1791 stereo codec
Date: Tue, 20 Dec 2011 00:39:17 +0000
Message-ID: <20111220003916.GE2860@opensource.wolfsonmicro.com>
References: <1324320810-17948-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A13F1038DD
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 01:39:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324320810-17948-1-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lrg@ti.com, leon@leon.nu
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 19, 2011 at 01:53:30PM -0500, Michael Williamson wrote:

> +/* DSD1791 register cache (16 through 23 are used) */
> +static const u8 dsd1791_reg[] = {
> +	[16] = 0xFF,
> +	[17] = 0xFF,
> +	[18] = 0x50,
> +	[19] = 0x00,
> +	[20] = 0x00,
> +	[21] = 0x01,
> +	[22] = 0x00,
> +	[23] = 0x00,
> +};

Use the regmap API.

> +	reg = snd_soc_read(codec, DSD1791_REG_AUDFMT);
> +	reg &= ~(DSD1791_FMT_MASK);
> +	reg |= fmt;
> +	return snd_soc_write(codec, DSD1791_REG_AUDFMT, reg);

snd_soc_update_bits().

> +static const struct snd_kcontrol_new dsd1791_snd_controls[] = {
> +	SOC_SINGLE("Left Playback Volume", DSD1791_REG_DIGATT_L, 0, 255, 0),
> +	SOC_SINGLE("Right Playback Volume", DSD1791_REG_DIGATT_R, 0, 255, 0),

This should be a single stereo control and you should supply dB data.

> +	/* enable attenuation control */
> +	reg = snd_soc_read(codec, DSD1791_REG_AUDFMT);
> +	reg |= 0x80;
> +	snd_soc_write(codec, DSD1791_REG_AUDFMT, reg);

This should probably be runtime controllable, or if it's got a good
reason for not being it should be using snd_soc_update_bits().

> +	snd_soc_add_controls(codec, dsd1791_snd_controls,
> +				ARRAY_SIZE(dsd1791_snd_controls));

Initialize the controls from the driver.
