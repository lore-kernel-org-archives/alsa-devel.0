Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73627C77B73
	for <alsa-devel@archiver.kernel.org>; Sat,  3 Jun 2023 14:07:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486A43E8;
	Sat,  3 Jun 2023 16:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486A43E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685801229;
	bh=vs+tCTl4b+QattGRqImucIYkjyFG1yI4ADdMp04oxb0=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rkOTrYSYYXMFvS9/T4i1754yxazb8OqiHqS4l5ZMIyGm+O1lpgmX+FXEv20tKRxcS
	 2b1IBFdfxWdRp+rjW7NqN+9xt4V2r647Mq9A7OtQNrZ/eZXbYYZkdjp7ecTnbPdoWy
	 8TTJx1z/VFOSCoyat1xlN1G9q6JBNzA884WFb1Yc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14DDEF804DA; Sat,  3 Jun 2023 16:05:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BE68F80149;
	Sat,  3 Jun 2023 16:05:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 406CAF80149; Sat,  3 Jun 2023 16:04:47 +0200 (CEST)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi
 [62.142.5.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 72F3EF800C1
	for <alsa-devel@alsa-project.org>; Sat,  3 Jun 2023 16:04:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72F3EF800C1
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 93641df7-0217-11ee-a9de-005056bdf889;
	Sat, 03 Jun 2023 17:04:38 +0300 (EEST)
From: andy.shevchenko@gmail.com
Date: Sat, 3 Jun 2023 17:04:37 +0300
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
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <ZHtIdTZbULl6t4RT@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-6-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523151223.109551-6-herve.codina@bootlin.com>
Message-ID-Hash: 6FXU3ONEBZYRPCNNHELIJFOPETNAI4YT
X-Message-ID-Hash: 6FXU3ONEBZYRPCNNHELIJFOPETNAI4YT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6FXU3ONEBZYRPCNNHELIJFOPETNAI4YT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Tue, May 23, 2023 at 05:12:19PM +0200, Herve Codina kirjoitti:
> A helper, iio_read_max_channel_raw() exists to read the available
> maximum raw value of a channel but nothing similar exists to read the
> available minimum raw value.
> 
> This new helper, iio_read_min_channel_raw(), fills the hole and can be
> used for reading the available minimum raw value of a channel.
> It is fully based on the existing iio_read_max_channel_raw().

...

> +static int iio_channel_read_min(struct iio_channel *chan,
> +				int *val, int *val2, int *type,
> +				enum iio_chan_info_enum info)
> +{
> +	int unused;
> +	const int *vals;
> +	int length;
> +	int ret;

> +	if (!val2)
> +		val2 = &unused;

It's a single place, where this is used, can you move it there?

> +	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case IIO_AVAIL_RANGE:
> +		switch (*type) {
> +		case IIO_VAL_INT:
> +			*val = vals[0];
> +			break;
> +		default:
> +			*val = vals[0];
> +			*val2 = vals[1];
> +		}
> +		return 0;
> +
> +	case IIO_AVAIL_LIST:
> +		if (length <= 0)
> +			return -EINVAL;
> +		switch (*type) {
> +		case IIO_VAL_INT:
> +			*val = vals[--length];

> +			while (length) {

			while (length--) {

will do the job and at the same time...


> +				if (vals[--length] < *val)
> +					*val = vals[length];

...this construction becomes less confusing (easier to parse).

> +			}
> +			break;
> +		default:
> +			/* FIXME: learn about min for other iio values */

I believe in a final version this comment won't be here.

> +			return -EINVAL;
> +		}
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


