Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13133C55184
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:59:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49C98601FA;
	Tue,  4 Aug 2026 17:59:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49C98601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785859173;
	bh=Uj+hqmUGSDBh3V5sSr8hvpvP2lfDmrKY/nrjhfGjB5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=U5TN74IR/wW6vSPm/XsLWouPfY/z90KAvvYt3+ayidrsucFqLDBTc2R6GnvIUeUJ8
	 yCzA9gKaq56eav98rdncH8v3fKf/KqayD6vFo6zUaMpXmLWr4BC046kxGK9Cd7rbU1
	 iGSJvyq2cZwHZnFwRhxoTVr3m1mjMsPyTT2Gb7Fw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 109EDF805FD; Tue,  4 Aug 2026 17:58:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A486EF80601;
	Tue,  4 Aug 2026 17:58:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EC97F805A8; Tue,  4 Aug 2026 17:58:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785859128;
	b=PbAVpCB6sJQTPZQp6H44X1DrA5HVtVN6bAGqOGrS+Z48CtAeA7u4lvaGE9eYHQ2nv+uY
	 XJ/ixKe80yL6zsa4bfjJKWZzpI9QuJnPK/3donQ2nRwNN3H19HhqI+Bg6L4I4ApTVrjFr
	 2O6fL05rGr0D9Lnq3SE1S/wPaRUJ2vE22NbbaGkQMOAi2tIbAVJAtu3Lz3JUnuYAlNco1
	 pVHrVTbmlclJ2YSiVB7rqj00RVOTeW2Wr/FuemomSoBg9/5m7JHDX32DswgfrRtuOoNY7
	 yqobn1AynztXRUW5UJxBUmDOFtISZB7P8Owh8/kTepDMpeCnKPvwZsq/M+QULva1XcA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785859128;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Uj+hqmUGSDBh3V5sSr8hvpvP2lfDmrKY/nrjhfGjB5I=;
	b=BvQDMujfe3cY/jCUgeD59k1Ju/D6FTDeYTGrlh6dEU3LSUF/vc0/xSGAw123FmIP7i9j
	 Ucl65Qo6zcUAePwDlxdwBNKIItdkxa2XREMejo4KbP8jhzK5v43kKnG0iPMfg/7otj1GA
	 tZU4Lkp0uvF0lmoCFX+1rOVAC8YgoniW0WDfAQdsBW19/rfW/lR3hV4pfYUTBNn0S41nw
	 Sl2HNFfVIk8Etf7L54Dz42LClAJio9zupR3gUPOpMdMAHoE+0RPmRWPuDz6crg9J+z3Rf
	 3Uo8I4L0QndeREtDLPboqKVQS0uCxyF022kkX4eM/gTeYU+mBf9ZHu9IIhLhEpK9pSg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RSk39xSB;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E7FEF8011B
	for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2026 17:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E7FEF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RSk39xSB
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FF6841AC9;
	Tue,  4 Aug 2026 15:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2E1F00A3A;
	Tue,  4 Aug 2026 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785859123;
	bh=BPuTDH8BEneJyLhanFOACvP5cUhQGXzhtwpAlvQiPRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSk39xSBIJnLq/lTw7yoicTJ2+iY2XJ1bhHUB3W1sUbJoqo4MBQ9DdmwyQRop2khs
	 zsHqz5Fy9UKGzIEBIilBXglOlsBC8F7b9E236shPE9OE3r12tlXlapDb57bGG246fp
	 axNj7ixqaOIJo3tL0fE98C320FM1scosF5T8/f0LrG7f3P+gyRLiJfv/WHhblnwcRo
	 wLzZlDvX0Uv5h4WcOfpmLwS49Hm3gYkRBFSyP2fTfL9YEubK0sRMl9ZnSnUVFfs7+6
	 R+qcbfMe95pNT/bjO+jUK1L7RPggOxeGLm7fg/Fny1uPyCVql4PQs1yvLtqXrb1g5z
	 WAlrDcFPQEjPA==
Date: Tue, 4 Aug 2026 16:58:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XTeMuZ7doSQ6INCv"
Content-Disposition: inline
In-Reply-To: <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
X-Cookie: Biz is better.
Message-ID-Hash: B24ZG6I4ZLCJXHIJFH45YIE6TIKJXVUN
X-Message-ID-Hash: B24ZG6I4ZLCJXHIJFH45YIE6TIKJXVUN
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B24ZG6I4ZLCJXHIJFH45YIE6TIKJXVUN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--XTeMuZ7doSQ6INCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2026 at 11:29:51AM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> +
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <sound/soc.h>
> +
> +#include "nau8360-dsp.h"
> +#include "nau8360.h"

You use bitfield.h so a direct include would be safer.

> +static int nau8360_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{

> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		ctrl_val = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_LEFT;
> +		ctrl1_val = NAU8360_TX_OFFSET_LEFT;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		ctrl_val = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_RIGHT;
> +		ctrl1_val = NAU8360_TX_OFFSET_RIGHT;
> +		break;

NAU8360_RX_OFFSET_LEFT and NAU8360_RX_OFFSET_RIGHT are defined
identically, presumably at least one of them is wrong and certainly one
of the above cases is.

> +static int nau8360_set_sysclk(struct snd_soc_component *cp,
> +	int clk_id, int source, unsigned int freq, int dir)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
> +	struct device *dev = nau8360->dev;
> +	static const char * const idtab[] = { "DIG", "ANA", "Internal" };
> +	static const char * const srctab[] = { "MCLK", "PLL", "HIRC48M", "BCLK" };
> +	int ret;
> +
> +	if (dir == SND_SOC_CLOCK_OUT) {
> +		dev_dbg(dev, "sysclk: freq %d (out)", freq);
> +		return nau8360_set_sysclk_output(nau8360, freq);
> +	}
> +
> +	switch (clk_id) {
> +	case NAU8360_CLK_ID_INT:

Usually we don't have a lot of fine grained control of the internal
clock dividers of the device, things are a lot easier when the device
just figures out what it needs based on it's input clocks.

> +static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
> +{
> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
> +	struct regmap *regmap = nau8360->regmap;
> +	int ret;
> +
> +	/* disable Sense at standby */
> +	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
> +	snd_soc_dapm_sync(nau8360->dapm);
> +
> +	ret = nau8360_dsp_setup(component);
> +
> +	regcache_cache_only(regmap, false);

We start the DSP with the device in cache only mode - that seems odd?

> +static struct snd_soc_dai_driver nau8360_dai = {
> +	.name = NAU8360_CODEC_DAI,
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 4,
> +		.rates = NAU8360_RATES,
> +		.formats = NAU8360_FORMATS,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 8,
> +		.rates = NAU8360_RATES,
> +		.formats = NAU8360_FORMATS,
> +	},
> +	.ops = &nau8360_dai_ops,
> +};

Do you need symmetric_rates, the hw_params looks to program the same
registers for both direction?

--XTeMuZ7doSQ6INCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpyDC4ACgkQJNaLcl1U
h9AahQf9F5kK6n9yrZew7//ocl7ez/1yPjOehgMQ2zHFn1Bqjb3f7ACqmhu5fxXL
z1EtIsw8T6KHAsRgh0z3JWFPqqFsHyKE5ahsEaNH3l4rssxIblKASLjmLud5PC2R
6B95uhA5uZOO7tzwQ5uHynnte1R8i5YoeW8PXToTYcZSYkg09WTtGlCxWvUsoVMZ
gjEj1IjtbEDTg8iNa0npAf/lDMssfePe69UOpB1A3Ls63W1CIvf0F5On97tJGk95
v/QAOh3u9nM0FbQ2G7HfXnuKQWMNUL30g+1+hRix3HG1QnO+ICZd9uOzwmExvYF7
gzjoNvlZIe2get3PoOZGi93KrNQGEA==
=kmsg
-----END PGP SIGNATURE-----

--XTeMuZ7doSQ6INCv--
