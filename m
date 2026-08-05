Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10205C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:29:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E996860225;
	Wed,  5 Aug 2026 12:29:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E996860225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925791;
	bh=04zhSZ670lYOcIV4KZHkxxs+lNy0FvVzAb9cYGTI2PY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ssXrP3Kbdkzw7dQjAKgDKWYdXvhTfpa0viNOvEX79yGKbhWrW7426qk7irV/ptU/o
	 wCoVHrKUk9TvLyVFUELJnW8D9XHjTaB6uhKlBL/Od8xPePSW7GjQxCCC4rzfBUfdFc
	 Kqunck5dRQuo01EVeAt1BgNxfjhc7dWj5GrwfYeQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BD5CF80652; Wed,  5 Aug 2026 12:28:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B0A9F80652;
	Wed,  5 Aug 2026 12:28:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2DF8F8027B; Wed,  5 Aug 2026 11:05:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785920720;
	b=ggu+wFZM7c/WEMWXwKGVCaBkPNCpV1TKpP3r30EeFG2hGvX+g8nKkX1q9syEodGJrELQ
	 wPaARu8hYoWgs6+UPJum1oeyPTqrUZI7Hs+5OLFIZ1SDS/2nYLFdJLf5+6Lu2xhY/9QJ9
	 uss6Euv7oy7I3suLiJyFSjY49G3FwhQWCfcGMY3CnXtW2iKEE/2ERgI4jPtuIW8hKCjbS
	 a4MIm8MFce7y6OAxtonXxjArIViDThY9ieqsufBqT0iLoxZtLcKnO15MS0JFFqPtnV1wV
	 OS5zb6tR3BPJv4hz7nU7EIZp1/T8mgeJoC7X/8eEjcwYnKTXBzIErOrpUDmt68ggXbw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785920720;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=04zhSZ670lYOcIV4KZHkxxs+lNy0FvVzAb9cYGTI2PY=;
	b=GSU3iuDLSzQhfDaFHuc4F7Yf8vNCNjkwWy7SRD80g5ihGgzMZATdaDvdD1E40Pbkb7OH
	 QoNurmby/eXrN2uFuFQ0PeiqUFEVaeYdX41dwk54OnX3tCPRXqgmq4EXGANrNV8JlvC6/
	 0AsFps7j0klYZLg5wDb3QGsIMDJGe31B978IYvAUViGc3Y01k0D4bm4HAG9K6BgGE+xQl
	 L8HitaaUPRDEwZyvL3BA2bxWJJRV5TYVNuPy1p6bDqJquzJR97Dq4pmVW+JDmmYrXt6Er
	 JsZZzfHr4zts7gGKjriVqxj4Hvncx+SalSEvwDA+MN7T+54/YPleFk99pYx8EpaPvFQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o35MAlLl;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C538BF800C1
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 11:05:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C538BF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o35MAlLl
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc97653887so8822435ad.1
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785920718; x=1786525518;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpmaDgjr0urIee4VasgeTATeKfxoGE87IfxMDoS57nE=;
        b=o35MAlLlqqI/tNn9lZjOSnX+Z0bsEYlTMmzaEbjx2w8cSa5X3LtpwdOsOJMlSmm3ea
         g/QX18r2JI087zz+uoArO90FoIhP7myd+rO1be4MUpF3akKM5oqy4K63hV6eZb/brnfr
         OPjb2uUzUBzaZ+NqDrzLarMtSLmSyj3h2MxTHPUW9KtW3WKun1kl4A6DuO1JV7RXnfOR
         RqjR6qtT211l3uBhEbhq86eZqBwYO5/M4ozFxoADlGjynE6taFPwXJ1acbQwu2g+vIaq
         60bBsarvNahRIz05zWP8DVusKa05fHg7ctDSwrPyfpv18YpItSzfUTNyXR2p5qwvm5H1
         Bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920718; x=1786525518;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpmaDgjr0urIee4VasgeTATeKfxoGE87IfxMDoS57nE=;
        b=FC1ntuQBPbvULYHRnQBCiPJpVT6YGewQyB0UPyw3f1KjLC80vLomnLK+C5skpwWVE+
         NK1nwcDGrTbEhKkmpE4vB0PeL9IA3hV8A8vvTNwaFLyfvA+K5+6svNZI3EDF7NvQktNo
         UsqfV9iVrH6r9Zmped1b/JPVry7+jf3E7C4cpBJRwQ3yGuSx6S2uWo6telB43F7vYVMG
         LqhgluvqE+fmquLIuzMpL069IbSyr57nKEQTkgPla4jvBY5mhIjnvMKgBTdQHXUKZi6J
         3j/9tH4TrXs4RSoE09pRzsJufKV5tTbXQ0U7Jbi55DxzLC1Nrlxyb8QNJBwJ3IZv08Af
         mkvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RotV5uw4UexA50C0BrFDdkuE19EcnOhIuXb2lCPCOmDaGF39LbCECzyPue9twu5vDeXrXfNyRI8uR6R@alsa-project.org
X-Gm-Message-State: AOJu0YzvwB+SRWw+5tdoMqwZW3dDpnCN3T0ddSeXB4FQfKCiO73Jhd1m
	9LEBSgjwK9pxUlSmmMdQGv0DsD7Y/7t+jh6MRP6vPdMZgGMvyel/cBMs
X-Gm-Gg: AR+sD10nNnmjxVcpAxPWt37VjktRW8tcy//HYndiW/GQe4yLlh/Hqgh9loxl0DuoQhB
	+KhRwO2hN4gR8knM67W2ykJCnig0VxfEJNYW7JVWqFmR562cjn32HDjSpgDlmGobmGSvImepdsO
	ICMAfCbAZBLkZ3beTvSboA8ntWPpEpNp2VkFXiJKr6mOIEX262e3Yl6bz6lnx35huhaRvFg1Tlz
	aKxJm7pNan5MQWg76Ktn7JTHwZbTDVEebteIUS0R7HoucNVufykJUVHb89Wb78fjLGJvBNr6eBs
	ldGp7UjCZ3hHqi7Ufb1f3q6xrF28ymtxK6Tg2S6W1N9M1PKKq40d2NMoHKP0zApWCsHsNGgmTh9
	UYYyiOGT/CIjLR7kXhap0P/w8WvCAThLywxqpvR6HmpGkKDBZQnri4QmAlfQwi7jYYOBFVTxKgo
	UTSuBmmrItp5IeLj2SpR6DiUNnnUsyvH0H/mzrrgs0UKr1kUCeJsIxJ+SeOmHBAHWilChbdXm/5
	51lQkpTlTXkTzZMeBs6uAsEqt6A
X-Received: by 2002:a17:90b:2745:b0:381:3b5d:30f4 with SMTP id
 98e67ed59e1d1-3903c535d84mr6018465a91.1.1785920717467;
        Wed, 05 Aug 2026 02:05:17 -0700 (PDT)
Received: from [172.20.10.2] (114-137-35-218.emome-ip.hinet.net.
 [114.137.35.218])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3903927dddbsm2516074a91.9.2026.08.05.02.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:05:16 -0700 (PDT)
Message-ID: <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
Date: Wed, 5 Aug 2026 17:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EBMHCZMRB2ODNZFWDULBCBEAE3CYMMHV
X-Message-ID-Hash: EBMHCZMRB2ODNZFWDULBCBEAE3CYMMHV
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:28:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EBMHCZMRB2ODNZFWDULBCBEAE3CYMMHV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 8/4/26 23:58, Mark Brown wrote:
> On Tue, Aug 04, 2026 at 11:29:51AM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>> +
>> +#include <linux/delay.h>
>> +#include <linux/firmware.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <sound/soc.h>
>> +
>> +#include "nau8360-dsp.h"
>> +#include "nau8360.h"
> You use bitfield.h so a direct include would be safer.
Got it. I will add #include <linux/bitfield.h>.
>
>> +static int nau8360_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> +{
>> +		break;
>> +	case SND_SOC_DAIFMT_LEFT_J:
>> +		ctrl_val = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_LEFT;
>> +		ctrl1_val = NAU8360_TX_OFFSET_LEFT;
>> +		break;
>> +	case SND_SOC_DAIFMT_RIGHT_J:
>> +		ctrl_val = NAU8360_FRAME_START_H2L | NAU8360_RX_OFFSET_RIGHT;
>> +		ctrl1_val = NAU8360_TX_OFFSET_RIGHT;
>> +		break;
> NAU8360_RX_OFFSET_LEFT and NAU8360_RX_OFFSET_RIGHT are defined
> identically, presumably at least one of them is wrong and certainly one
> of the above cases is.

Thank you for pointing out the problem. There is indeed a mistake here.

The configuration missed the left/right justify settings. I will correct 
both the register definitions and the case logic in the v8 patch.

>
>> +static int nau8360_set_sysclk(struct snd_soc_component *cp,
>> +	int clk_id, int source, unsigned int freq, int dir)
>> +{
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
>> +	struct device *dev = nau8360->dev;
>> +	static const char * const idtab[] = { "DIG", "ANA", "Internal" };
>> +	static const char * const srctab[] = { "MCLK", "PLL", "HIRC48M", "BCLK" };
>> +	int ret;
>> +
>> +	if (dir == SND_SOC_CLOCK_OUT) {
>> +		dev_dbg(dev, "sysclk: freq %d (out)", freq);
>> +		return nau8360_set_sysclk_output(nau8360, freq);
>> +	}
>> +
>> +	switch (clk_id) {
>> +	case NAU8360_CLK_ID_INT:
> Usually we don't have a lot of fine grained control of the internal
> clock dividers of the device, things are a lot easier when the device
> just figures out what it needs based on it's input clocks.
Thanks for the feedback.

To make sure I understand: Should we remove the internal clock IDs from 
set_sysclk and handle clock configurations automatically inside the 
codec driver?

Does this mean we should avoid configuring them via the machine driver 
entirely? If so, what is the preferred way to handle clock fallback when 
playback stops or MCLK is absent

(e.g., via PCM shutdown hooks or DAPM events)?

>
>> +static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
>> +{
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +	struct regmap *regmap = nau8360->regmap;
>> +	int ret;
>> +
>> +	/* disable Sense at standby */
>> +	snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
>> +	snd_soc_dapm_sync(nau8360->dapm);
>> +
>> +	ret = nau8360_dsp_setup(component);
>> +
>> +	regcache_cache_only(regmap, false);
> We start the DSP with the device in cache only mode - that seems odd?
Got it. I will fix this in the v8 patch by disabling cache-only mode 
before DSP setup.
>
>> +static struct snd_soc_dai_driver nau8360_dai = {
>> +	.name = NAU8360_CODEC_DAI,
>> +	.playback = {
>> +		.stream_name = "Playback",
>> +		.channels_min = 1,
>> +		.channels_max = 4,
>> +		.rates = NAU8360_RATES,
>> +		.formats = NAU8360_FORMATS,
>> +	},
>> +	.capture = {
>> +		.stream_name = "Capture",
>> +		.channels_min = 1,
>> +		.channels_max = 8,
>> +		.rates = NAU8360_RATES,
>> +		.formats = NAU8360_FORMATS,
>> +	},
>> +	.ops = &nau8360_dai_ops,
>> +};
> Do you need symmetric_rates, the hw_params looks to program the same
> registers for both direction?
  Yes. Since playback and capture share the same configuration 
registers, I will add symmetric_rates in the v8 version.
