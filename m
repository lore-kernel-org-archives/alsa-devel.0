Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B55F606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=lxq1I/Oj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K6/fTI1+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0FCE60218;
	Mon, 23 Nov 2026 13:03:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0FCE60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435416;
	bh=XqPMNEDL2VvRD7Ay8391CbOjwSGsB/urG3/g5l8+OK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lxq1I/Oj2RRnjWnSHV0wsXxR1ROgm8pzr3G/UDr7oEtODS4GugNCvr41anf3XdXtr
	 VfoV6xbFBLeHYrjnyJz8SJItK5g5XVmn+Ws/mRvXP+Z3oXK1+RnRQcsuHvplPHTOYI
	 GVlYfoXQSGmbyavdyWN3YNAxmqf2Pys+AiaIoyes=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC348F8065E; Mon, 23 Nov 2026 13:02:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3ED2F8065D;
	Mon, 23 Nov 2026 13:02:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 146CBF805A8; Tue, 17 Nov 2026 04:45:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794887137;
	b=LfkN028k4lJUCrnxmRigWgp4kVcWbRY4sgE9OhMg6MIxMmVCA9GLkGW2bIGHqwA6HC91
	 C/Uv8mnpxlLMbkAhXF4DugeY3Oywp3nTlAqSj+tlEq1R2/VEouYZfwlL7itvy8gRGQhAR
	 hb/XaSCbc0PXfr1T9bPFjhPlXHbJV7mIIKiFvLChbcjGoK/IgKM1GlCzN/jygtdmx3ktS
	 PvbL44QXIJDrTN+DOduRM9tdPqLzAnpzfxL1az82NK2tESdK0Er2M0TM01s6BXoywxu4o
	 jykuTDsA0orgjsStMmIvJbLwEGgfV1At1Q0pu4Xcq9Z0ScATYrGRGsgoJdP1AOZ9aPQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794887137;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=XqPMNEDL2VvRD7Ay8391CbOjwSGsB/urG3/g5l8+OK8=;
	b=WyM+0/m/dKsKq6PWahdzzC60X2Pii+xNJS0INFpwWa2dsRiIIuQxaXz6hs4Ncr/kVANE
	 WTak1KnQxQ8DpuNsQRAm6xmZ9G4BlC/JJGR2319XmNvFOtsLQI6dkCbjjM7ACFArMzHlz
	 W1iuOIIi1ZBWmtN3Vd4GtCvzXz9lJZotEnbz9y4duetqRg5BYFX4Qs3YXxfIMZduhcd0W
	 1p0sOpYt37zEqPH3q6xJK5XS96tTQqmetfZB/ZlAstp9MqjnNCy8ewUKYFnrvfcacNVn0
	 qp5MN0RPIcvIi9sYg/spAUbk+elYIAqe1JHuAM9GqOFh45bejWdH8bkLQprtgaOiMpg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="K6/fTI1+";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 425BCF80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 04:45:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 425BCF80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=K6/fTI1+
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3b0a519049aso4133573a91.1
        for <alsa-devel@alsa-project.org>;
 Mon, 16 Nov 2026 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794887134; x=1795491934;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/hLof7T98UFzgwiFM30+8SkQ46zhWKH/5V6aesQdyI=;
        b=K6/fTI1+7v0rOVej4GBj8x9+EIDO+7mxgNpQO0GHG3Q6DraqIJjX0oq/t7JrfZVNfB
         AKxe0j95tbtPhXfjlNuY18o/T5avBGbNS2MbsPBU6prqEsSuRB4n+tnmT911C/4KWpTh
         E5dfZ+MK+5qXjD2D2sNeS7xholVCt+V6uv9mLfmkVta0T4Zc6ZXHUd5flKWFLw8rZcMt
         4tcgym5PI2yhT78jbfOYO98idfyavXAfHYryAQq/jWRPM9jRjapzn8n3FBqT+FkpWTgD
         jcDVEbd4uC/k63jea7Dnt+XDEh2pNN2y6AlwzwlrYwlat2Cwd4fqXFVbKguX7LsP7p82
         ESlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887134; x=1795491934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/hLof7T98UFzgwiFM30+8SkQ46zhWKH/5V6aesQdyI=;
        b=QF4VpFcm912LG9LV66iSAV0ItV4Xg9DFfAIIND/dCzND3gjNunr6EHWF/XpLUGGaVC
         yI/qNyPqMqAr+HOy9xqQq79RdtWTSyfq56N/Dfw7P9zFikuh2cqp7TaMHwr7m6JMHjFg
         ndmPZdfZzvZEOYLqpbTFJgDy3uTBojhQvl4iHwjMEugBmXSyboG/KkDb3Nm7dadJpf7y
         LGA3lZMjjLr5SVnGbk1yBCbWKFn8AKso8XGkvZoLnCbIImLGUMOCX1gcoJA+Y2JWnfnH
         zmEpzwj6aEabJoOkO2NAtlJYcxRUyGXjd0QqJho6ruMK9PnUj7J8Ce6R7YzfaS/tzNXD
         /o2g==
X-Forwarded-Encrypted: i=1;
 AL+hErGhtPuj9wRFgCbHAxazbfuTF2xVPe4Ni0VjDrAKB8oGL1BOPqfjqo+DPj5FnpHUNuRHc77vl5swrVA1@alsa-project.org
X-Gm-Message-State: APuU4Z8idm0xztWNQ0Hfuv4yrxVCED0JGMKDTrTBqZQc+LBNo0SZI9t7
	3gdHhZhjkJqbBA1xMXXP0m7vsVHa7tWQM4bTKyq+5ogyVUQFdN/aj1sx
X-Gm-Gg: AZFdTZfQcqx+KJwpcBRVQKHc5IYjk2g5t1VxMSGjVI5TI2Lslv6u2WRw65/dlj9sn+H
	qfp8YCr/Tf1Ia8VSepxsMbz57pb9eveSL+279Dg9LBTYISk8ktex+fh6XRkISLvbQZNZvSpCBjv
	36RN63xnvwBj/ED4ScPUzk+K1KY2XLq0r3wIMYFh7te2H59Neq57E5BEe0K5IVS89a+Q8XAZiGF
	Bbmqf6wN4BWD5qRWSA7TqeWS/cAaRIuh5AP/yRFb9TLkWMDtZ2iBvaznM//yjKZ7Q34eLBacnLr
	NrnAi0wi3owCeJZaytCGyapbZb/439XZxZ07lmmQ8JkfGdaunU2lq2nS6dcDRDRXDPq1LHjSU3c
	Mgl1Wm32FbASLSVKJWCiPVcUjxtKI1MbCR6KVCzTKayys/ERdWaO8gcNWcnydIV3QcKbRuqPsre
	hfb00+hy5rqs7K7lR2bs96P8NiP3mfyeg/r5PD/y6zwUJkFlTvnrcb+n7bc2mUOn0Yb60j+cIeG
	SgF0bHAQlIGiIKngb1TqYm8Q0uUfNR1/ExgfKhxOOl5J4tOeRT/ZJ93ZkqAwqjx5ZhLoXNVziiZ
	C3oszLRrpvqo1pR+SCYYxsMGr756Gg5re/yCjlFZ2WwEPVsrgPyZQ6qDFJE5
X-Received: by 2002:a17:90b:5105:b0:3b0:d0c5:c10e with SMTP id
 98e67ed59e1d1-3b1b0b546f7mr12821409a91.17.1794887134435;
        Mon, 16 Nov 2026 19:45:34 -0800 (PST)
Received: from [172.20.10.2] (42-79-72-63.emome-ip.hinet.net. [42.79.72.63])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac70ea45sm1720814a91.17.2026.11.16.19.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 19:45:33 -0800 (PST)
Message-ID: <e87bc85d-c9e3-44b5-99e6-007944d75200@gmail.com>
Date: Tue, 17 Nov 2026 11:39:57 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 lkp@intel.com
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-3-YLCHANG2@nuvoton.com>
 <179425369963.3711751.8538085283431158098.b4-review@b4>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <179425369963.3711751.8538085283431158098.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: W7HW6LOFVAYPBALTVVBRNBXK2RJSDZ2Z
X-Message-ID-Hash: W7HW6LOFVAYPBALTVVBRNBXK2RJSDZ2Z
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:13 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W7HW6LOFVAYPBALTVVBRNBXK2RJSDZ2Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


On 11/10/26 03:48, Mark Brown wrote:
>> Add support for the Nuvoton NAU83G10 audio amplifier.
>> The NAU83G10 is a mono boost Class-D audio amplifier with
>> integrated DSP and I/V-sense support.
>> +config SND_SOC_NAU8310
>> +	tristate "Nuvoton Technology Corporation NAU83G10 Mono Boosted Amplifier"
> This handles NAU83G20 as well.
Got it. I will update the config description to include NAU83G20 in the 
next version.
>
>> +static int nau8310_dsp_idle(struct snd_soc_component *cp)
>> +{
>> +	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
>> +	struct regmap *regmap = nau8310->regmap;
>> +	unsigned int idle_pattern, timeout = NAU8310_DSP_IDLE_RETRY * USEC_PER_MSEC;
>> +	int ret = 0;
>> +
>> +	ret = regmap_read_poll_timeout(regmap,
>> +		NAU8310_RF000_DSP_COMM, idle_pattern,
>> +		idle_pattern == NAU8310_DSP_COMM_IDLE_WORD, USEC_PER_MSEC, timeout);
>> +	if (ret) {
>> +		dev_err(nau8310->dev, "Timeout waiting for DSP idle state: %d", ret);
>> +		nau8310_sw_reset_chip(regmap);
> If you need to reset the chip you should probably also resync the cache,
> and there's some redundancy here with nau8310_software_reset().
This reset function only resets the internal state machines without 
clearing the register values, so a cache resync is not necessary.
I will remove the redundant function in the next version.
>
>> +int nau8310_dsp_init(struct snd_soc_component *cp)
>> +{
>> +	struct regmap *regmap = cp->regmap;
>> +
>> +	nau8310_sw_reset_chip(regmap);
>> +
>> +	/* wait for the power ready */
>> +	msleep(120);
>> +
>> +	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
>> +		NAU8310_DSP_RUNSTALL | NAU8310_DAC_SEL_DSP_OUT, NAU8310_DAC_SEL_DSP_OUT);
> NAU8310_DAC_SEL_DSP_OUT is used by DAPM, you might want to solve this
> the way nau8360 does.
Got it. I will remove NAU8310_DAC_SEL_DSP_OUT from here in the next version.
>
>> +static int nau8310_biq_coeff_put(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
>> +	struct snd_soc_component *cp = snd_soc_dapm_to_component(dapm);
> This is the same issue as was fixed in nau8310_clkdet_put() in this
> version.
Got it. I will fix it in the next version.
>
>> +	/* Boost Control Target Value Limit. 0.16 V per step. */
>> +	SOC_SINGLE("Boost Target Limit", NAU8310_R17_BOOST_CTRL1,
>> +		NAU8310_BSTLIMIT_SFT, NAU8310_BSTLIMIT_MAX, 0),
> The binding describes nuvoton,boost-target-limit/-margin as having
> 0.19V steps - either that or the comment here is wrong.
Got it. I will fix the comment/binding to match the correct value in the 
next version.
>
>> +	ret = nau8310_clock_config(nau8310, fs, nau8310->mclk);
>> +	if (ret)
>> +		return -EINVAL;
> Just return ret in case it's more descriptive.
Got it. I will return 'ret' directly instead of -EINVAL in the next version.
>
>> +static struct i2c_driver nau8310_i2c_driver = {
>> +	.driver = {
>> +		.name = "nau8310",
>> +		.of_match_table = of_match_ptr(nau8310_of_ids),
>> +		.acpi_match_table = ACPI_PTR(nau8310_acpi_match),
> We don't need the wrappers for these pointers these days.
Got it. I will remove the wrappers (of_match_ptr and ACPI_PTR) in the 
next version.
>
