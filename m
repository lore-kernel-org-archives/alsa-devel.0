From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 1/7] OMAP4: PMIC: Add support for twl6030 codec
Date: Mon, 28 Sep 2009 14:56:06 +0100
Message-ID: <20090928135606.GI31899@rakim.wolfsonmicro.main>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391DF@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E90A391DF@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 25, 2009 at 09:02:32PM -0500, Lopez Cruz, Misael wrote:

> +#if defined(CONFIG_SND_SOC_TWL6030)
> +#define twl_has_codec()	true
> +#else
> +#define twl_has_codec()	false
> +#endif

This ifdef won't match if the CODEC driver is modular.

> +
> +	if (twl_has_codec() && pdata->codec) {
> +		child = add_child(CODEC_SUB_CHIP_ID, "twl6030_codec",
> +			pdata->codec, sizeof(*pdata->codec), false,
> +			0, 0);
> +		if (IS_ERR(child))
> +			return PTR_ERR(child);
> +	}

I'd be inclined to print a warning here if no platform data is supplied,
or have the CODEC handle missing platform data to make it easier for
people to diagnose any problems with instantiating the device.
