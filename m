Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6D4C77B73
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Jun 2023 18:27:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 179B53E7;
	Sat,  3 Jun 2023 20:27:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 179B53E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685816873;
	bh=CyHnvgwbbTnvyu+y6mMFVx5dMbHiktLmRPvt8izXq64=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QVIbX18g7VS6dJkq782+/UgC/xIXwtQLr9WUZUqtSDse3y/3fv9ryM41cHNi9EnHF
	 Ufwb85pMQ980BfpgSr8IW7yddAQnLTHzjSP5qUGsuT1h66+5hxY3lc4sQ78BL4IZHr
	 tNmKU0aepQyXccMA2rF0QNJWYMU7ciER10+Fn/V0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 245C6F80149; Sat,  3 Jun 2023 20:26:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A40BF80149;
	Sat,  3 Jun 2023 20:26:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CCCAF800BD; Sat,  3 Jun 2023 20:26:30 +0200 (CEST)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi
 [62.142.5.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8DA7FF800BD
	for <alsa-devel@alsa-project.org>; Sat,  3 Jun 2023 20:26:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DA7FF800BD
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 228430b1-023c-11ee-abf4-005056bdd08f;
	Sat, 03 Jun 2023 21:26:20 +0300 (EEST)
From: andy.shevchenko@gmail.com
Date: Sat, 3 Jun 2023 21:26:19 +0300
To: Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <ZHuFywIrTnEFpX6e@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-8-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151223.109551-8-herve.codina@bootlin.com>
Message-ID-Hash: 6IZ5SELA5OILPBPQIFFINRQMCY6GZG6W
X-Message-ID-Hash: 6IZ5SELA5OILPBPQIFFINRQMCY6GZG6W
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6IZ5SELA5OILPBPQIFFINRQMCY6GZG6W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Tue, May 23, 2023 at 05:12:21PM +0200, Herve Codina kirjoitti:
> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be fully
> integrated in the audio path.
> 
> This support allows to consider these Industrial I/O devices as auxliary
> audio devices and allows to control them using mixer controls.

...

> +// audio-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components

Putting file name into file is not a good idea in case the file will be renamed
in the future.

...

> +struct audio_iio_aux_chan {
> +	struct iio_channel *iio_chan;
> +	const char *name;
> +	bool is_invert_range;

If you put bool after int:s it may save a few bytes in some cases.

> +	int max;
> +	int min;

Wondering if there is already a data type for the ranges (like linear_range.h,
but not sure it's applicable here).

> +};

...

> +	if (val < 0)
> +		return -EINVAL;
> +	if (val > max - min)

Btw, who will validate that max > min?

> +		return -EINVAL;

...

> +	return 1; /* The value changed */

Perhaps this 1 needs a definition?

...

> +static struct snd_soc_dapm_widget widgets[3] = {0};
> +static struct snd_soc_dapm_route routes[2] = {0};

0:s are not needed. Moreover, the entire assingments are redundant
as this is guaranteed by the C standard.

...

> +	char *input_name = NULL;
> +	char *output_name = NULL;
> +	char *pga_name = NULL;

Redundant assignments if you properly label the freeing.

...

> +	BUILD_BUG_ON(ARRAY_SIZE(widgets) < 3);

Use static_assert() at the place where the array is defined.

...

> +	BUILD_BUG_ON(ARRAY_SIZE(routes) < 2);

Ditto.

...

> +end:

out_free:

> +	/* Allocated names are no more needed (duplicated in ASoC internals) */
> +	kfree(pga_name);
> +	kfree(output_name);
> +	kfree(input_name);
> +
> +	return ret;

...

> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		chan = iio_aux->chans + i;
> +
> +		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot get max raw value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

It sounds like a part of ->probe() flow, correct?
Can dev_err_probe() be used here?

> +		}
> +
> +		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot get min raw value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

Ditto.

> +		}
> +
> +		/* Set initial value */
> +		ret = iio_write_channel_raw(chan->iio_chan,
> +					    chan->is_invert_range ? chan->max : chan->min);
> +		if (ret) {
> +			dev_err(component->dev, "chan[%d] %s: Cannot set initial value (%d)\n",
> +				i, chan->name, ret);
> +			return ret;

Ditto.

> +		}

...

> +		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
> +			i, chan->name, chan->min, chan->max,
> +			chan->is_invert_range ? "on" : "off");

str_on_off()

> +	}

...

> +	count = of_property_count_strings(np, "io-channel-names");
> +	if (count < 0) {

> +		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
> +		return count;

		return dev_err_probe();

> +	}

...

> +	for (i = 0; i < iio_aux->num_chans; i++) {
> +		iio_aux_chan = iio_aux->chans + i;
> +
> +		ret = of_property_read_string_index(np, "io-channel-names", i,
> +						    &iio_aux_chan->name);
> +		if (ret < 0) {
> +			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);
> +			return ret;

Ditto.

> +		}

> +		tmp = 0;
> +		of_property_read_u32_index(np, "snd-control-invert-range", i, &tmp);

> +		iio_aux_chan->is_invert_range = tmp;

You can use this variable directly.

> +	}

Btw, can you avoid using OF APIs? It's better to have device property/fwnode
API to be used from day 1.

...

> +	platform_set_drvdata(pdev, iio_aux);

Which callback is using this driver data?

...

> +static const struct of_device_id audio_iio_aux_ids[] = {
> +	{ .compatible = "audio-iio-aux", },

Inner comma is not needed.

> +	{ }
> +};

...

> +static struct platform_driver audio_iio_aux_driver = {
> +	.driver = {
> +		.name = "audio-iio-aux",
> +		.of_match_table = audio_iio_aux_ids,
> +	},
> +	.probe = audio_iio_aux_probe,
> +};

> +

Redundant blank line

> +module_platform_driver(audio_iio_aux_driver);

-- 
With Best Regards,
Andy Shevchenko


