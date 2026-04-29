Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8F0CD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:34:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A90F6020A;
	Mon,  4 May 2026 13:34:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A90F6020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894475;
	bh=R0RT5BudhmrI8eGI91Vu5+RO1GtIP27et4c/aLQbjPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kNnEpF0JKSMtriuGAAQ5d5sQXc9Fkgt3bYYJHVcki42+o8GRvVHeYK3qLve/9LZPb
	 8Ok7npUQ9DKiHsI69wuPljL9dXU+USRLRVMkKQ84KvTMHKfT3gEU+2T6QjWA0Wiont
	 gcIZOzWwHFQxurHlciD8suqqpSTpTB9knuGLP8zs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08EE4F80678; Mon,  4 May 2026 13:33:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7952F80679;
	Mon,  4 May 2026 13:33:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86EDCF80544; Wed, 29 Apr 2026 05:11:33 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C032F8016D
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 05:11:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C032F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ETwqjAu6
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso4840973a12.2
        for <alsa-devel@alsa-project.org>;
 Tue, 28 Apr 2026 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777432289; x=1778037089;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bDYfcj76Nr80y55FIaIDI9diKj6yFZhFoo5wVmqGbE=;
        b=ETwqjAu6Hq2Pgmx1zZEydEBjcDMapB7hI8F76hH3KbAlqBu0KncZcSOtuAKpk7jtMJ
         XJcDc25BmdjlASQOywAsOTk7jY7enpxOmqlQf8SaQRpBABdw0qP3uB+YSk7cJgxwHOI1
         TgYTgSALQ7c4LPROZAsJF7VsPCJszSKkSNu3CAlpOITDDNHDsl2Wf2ZBDLo35bgP7UVV
         +V7QCPI2m16BdiP8o6XjWPzNvb8w9VC6l0kmMG8v3mnJEPfiqwq8KTGcZsuFiohdnnxH
         B9b+dVQOnkq0HtvSFhmMhFV99MIKwLfjmQe4WmmHD5Uc3AqV6o6SrOA88o4Vh7YRuHq8
         RUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777432289; x=1778037089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bDYfcj76Nr80y55FIaIDI9diKj6yFZhFoo5wVmqGbE=;
        b=AUbeC7gfspg6VgZ1yg7gyTAiapgwWT+Xit7D1CJYh0lE0TgyZrvlFDc9oNaob78sVE
         +qxybLLBZVc8hvvxqpQ9H9NYPgLHgw/DE7YAqcbw3S7b3HnDgurRfWXFoO/jrJ1uhtvB
         LFgpgPze6lnaN0H1h5NlA2x696iyB+qBg4kPHl1FyUzKkjXlE8gE9rHoOZxzvnk+b2KR
         y/ZcTXjhLJTWdr7Zlu1B+t9Lt4oPwyN/NDfGHOOcR06U+6mJz+ZwKh2GHKaWQ1ZMQl74
         49xA5aP4OhL3vFrdkVEVBNCSwz7Dpj8nlhLTIzo8euqaZH852JFAKIyzNWsHTMKSy2gM
         3b0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QgOWu5ibA2Rnzyi8snDA/d9+vEUEL4L+8TJU7HtHmwGc/nFCinqe7o8ozE3FuPn0U+9qoEr70YqPL@alsa-project.org
X-Gm-Message-State: AOJu0YwzAczwY2oVlJjZO2dAECSAHpHP6Tczl+Xu5fIsS6ikzWu+1fhC
	PxihFmGl+LXZvR/70yn8hvJsBPJcOSfhx5fyjE72T1jeHVZODkKgpuCs
X-Gm-Gg: AeBDievPySxo+zQKDkMiW4vNE194wydMY6zJvbgOGqfPLKWFVwG54VY5pjhpdMWtW99
	f9Z8IaZRdjxjJKk4D1nyEaF0rINXeYIRVr68s0VfKUmWy8Bo7Ye6a89UQJEhDXRRRCa3y3MSkA7
	PHVFCZOsh0Gy4xTRmumFizzV8ggAl4EZTJAxxy9mNVnw8FR0JaJSnOVQXbSpmIVrR5ZuFVf1A+Q
	nf4svJcm/d9hmbw8QhcjzRxt+fkYxvaZCBjUNghIvbwb/sY/WnpZsjtqC5u1DsjoFLAd9O7uavG
	pYF+iey3Lp6pIlsUk9zQkJFQqWNj7zCYrX3of+QqOaxxGRtqNY8Ea6QyCg/RMhAE+vaUEiOEOWa
	XPNnhKNcO3xM0e9YEwTKYB+rZfAwGpX9OWYwp/N2EdtxQPMwWW72cPTeSu5Tm8jHL4b8SN1NhOM
	CKwIffJtYHBeIFkjXoyw4dYj/rRqO8Tr0H5YMsiqkynnMT6sNX77kjHoHLGY+Oqi+9jTXa
X-Received: by 2002:a05:6a20:2443:b0:3a0:aee6:acc3 with SMTP id
 adf61e73a8af0-3a3af660d37mr2332904637.38.1777432289396;
        Tue, 28 Apr 2026 20:11:29 -0700 (PDT)
Received: from [172.20.10.2] (42-79-67-210.emome-ip.hinet.net. [42.79.67.210])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd6506f0csm483483a12.27.2026.04.28.20.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 20:11:28 -0700 (PDT)
Message-ID: <8449eb0e-0e16-bf3e-0dc8-0b2869d75753@gmail.com>
Date: Wed, 29 Apr 2026 11:11:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
 <20260424033953.280520-3-YLCHANG2@nuvoton.com>
 <a76fe4d7-5726-41a9-b569-e676ad94f353@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <a76fe4d7-5726-41a9-b569-e676ad94f353@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YZW5VWBWKV2FNWT6FLYU6EHUYZ5ADLCX
X-Message-ID-Hash: YZW5VWBWKV2FNWT6FLYU6EHUYZ5ADLCX
X-Mailman-Approved-At: Mon, 04 May 2026 11:33:21 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YZW5VWBWKV2FNWT6FLYU6EHUYZ5ADLCX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 4/24/26 23:56, Mark Brown wrote:
> On Fri, Apr 24, 2026 at 11:39:53AM +0800, Neo Chang wrote:
>
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
>> +	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
>> +	int i, ret, reg = nau8360_peq_regaddr(kcontrol->id.name);
>> +	__be16 *data;
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST,
>> +		NAU8360_HW1_MEM_TEST);
>> +	for (i = 0; i < params->max / sizeof(u16); i++)
>> +		snd_soc_component_write(cp, reg + i, be16_to_cpu(*(data + i)));
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST, 0);
>> +
>> +	kfree(data);
>> +
>> +	return 0;
> This should return 1 if the value was changed to generate notifications.
I will modify this and returns 1 when the value actually changes in v2..
>
>> +/**
>> + * nau8360_set_tdm_slot - configure DAI TDM.
>> + * @tx_mask: 4-bits value representing each active TX slots. Range: 0 (skip), 1~8. Ex.
>> + *	bit 0-3 for left AEC output channel selection
>> + *	bit 4-7 for right AEC output channel selection
>> + *	bit 8-11 for left Isense output channel selection
>> + *	bit 12-15 for right Isense output channel selection
>> + *	bit 16-19 for left Vsense output channel selection
>> + *	bit 20-23 for right Vsense output channel selection
>> + *	bit 24-27 for Junction Temperature (Tj) data output channel selection
>> + *	bit 28-31 for VBAT measured data output channel selection
>> + * @rx_mask: Bitmask representing active RX slots. Ex.
>> + *	bit 0-7 for left DAC channel source selection
>> + *	bit 8-15 for right DAC channel source selection
>> + *	bit 16-23 for left ANC channel source selection
>> + *	bit 24-31 for right ANC channel source selection
>> + *
>> + * Configures a DAI for TDM operation. Only support 8 slots TDM.
>> + */
>> +static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
>> +	unsigned int rx_mask, int slots, int slot_width)
> That's not the way the API is supposed to work, the mask should be which
> slots are active as a bitmask.  It looks like what you want here is a
> series of muxes which control the routing to some AIF widgets
> representing the TDM slots.
Got it. I will rework set_tdm_slot() so tx_mask and rx_mask are used 
only as active slot bitmasks.
The default routing will be TX slots for AEC and RX slots for DAC.
Slot-to-function assignment will be handled through ALSA kcontrols instead.
>
>> +static const struct regmap_config nau8360_regmap_config = {
>> +	.reg_bits = NAU8360_REG_ADDR_LEN,
>> +	.val_bits = NAU8360_REG_DATA_LEN,
>> +
>> +	.max_register = NAU8360_REG_MAX,
>> +	.readable_reg = nau8360_readable_reg,
>> +	.writeable_reg = nau8360_writeable_reg,
>> +	.volatile_reg = nau8360_volatile_reg,
>> +	.reg_read = nau8360_reg_read,
>> +	.reg_write = nau8360_reg_write,
>> +
>> +	.cache_type = REGCACHE_RBTREE,
> Use REGCACHE_MAPLE unless you've got a particular reason to use
> something else, it's a more modern data structure than _RBTREE and makes
> choices more suited to current hardware.
I will change this to REGCACHE_MAPLE in v2.
>
>> +	/* DAC gain setting 0dB by changing current cell current. */
>> +	regmap_update_bits(regmap, NAU8360_R6E_DAC_CFG0, NAU8360_DAC_CUR_MASK,
>> +		NAU8360_DAC_CUR_0DB);
> Things like gains should normally be user visible and left at the chip
> defaults, that way we're not making use case specific decisions.
Agreed. I will remove this setting and leave it at the default in v2.
>
>> +static void nau8360_read_device_properties(struct nau8360 *nau8360)
>> +{
>> +	nau8360->pbtl_enable = device_property_read_bool(dev, "nuvoton,pbtl-enable");
> This is missing from the binding documentation.
I double-checked the patch, and it seems this property is already 
documented in the YAML file.
>
>> +static int nau8360_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	return snd_soc_register_component(dev, &soc_comp_dev_nau8360, &nau8360_dai, 1);
>> +}
> Nothing unregisters this, you should use devm_snd_soc_register_component()
Got it. I will switch to devm_snd_soc_register_component() in v2.
