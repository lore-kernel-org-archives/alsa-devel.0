Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D7606A31E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Z89zt2uN;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v9s7/WQX
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D608B60209;
	Mon, 23 Nov 2026 13:03:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D608B60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435398;
	bh=wF9r9AzBt1UeKWw6+Dq2iCpVdGdG0BIF6WfHzyKIZVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z89zt2uNUqt19fVLJoPV7wH3sLvi3AU8AdxUim4iqR5chTJyKg9cMSM7q3Y4B9lxw
	 G3IECMrOMei/vmVXtvzjHPJEaT19VNgMDmdZFYhMc/WXiGoGA7FQjxaUn90E7HOrYN
	 4IAQb3aDVy49tNFxD/nZTpPWd8XT4HpXXWzKUV7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5AA0F8061E; Mon, 23 Nov 2026 13:02:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6793EF80610;
	Mon, 23 Nov 2026 13:02:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7882EF805A8; Tue, 17 Nov 2026 04:45:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794887133;
	b=LiLh8tCfZj9d25FXuci7qvF3hQvNCjeF7nYTLegE6nehkWEpOV3ZWwDhvIAnI1HJBt0e
	 0oZwR6uzIXSLvsjhtS8i+/JZhC/aR+WHybsUXMjlky4IH6fE7HAjB+DFoT93+AZNHGsUa
	 vj8cHS3lQElVuj9tpKDl/d3zGTxx+5Y0muQZQ+Wr8hQmrKojrc/h8v8rYWcQ55N7wyy6o
	 DzC8i6K9AYFTocx77xjGlcGlQrPsM9HhyA+qCNQQEjX6cQjH/IbruZLO6jmTUQZr/k6XB
	 0vxd9FgX8CW4G7vAsqmxutJLiMKvYPsPnMnv2erQueNhEfqzEIxo6pFT5ZF8RdO9hxA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794887133;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=wF9r9AzBt1UeKWw6+Dq2iCpVdGdG0BIF6WfHzyKIZVA=;
	b=kAN2FmaN1ZiIGNYF+XHGM8y000WEPKSfH3fpZ7In2vSRn6psOsM1ZPex3LKZKdfQtCX3
	 ZP7nkz3v+aC88hFcrjJSOu3gTQTLkJXTyY8ss3mxQr0TVknmpC66AluV511ugjH4lng+S
	 JXD9GtUaoX+6Ou6V9hBAF91kR/TpLoMUMc/Iuyj5UBA6IVQTUs6SQntOdlGMUqc+L/2g8
	 vVGUTW7OYyKGMG0pM1O7nM5r9dGfctMxNYFQRJwlwrD24NhHaPITsdIfEvkOJDxJH5MZW
	 lCkpSyAaanPMw1+71Dd0skRVHeqiaidbDv98BdcIHqLnx6URou2UJ0ByEuVu/wLV/5w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="v9s7/WQX";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE1EEF80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 04:45:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE1EEF80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=v9s7/WQX
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ada4c06b7bso2253029a91.2
        for <alsa-devel@alsa-project.org>;
 Mon, 16 Nov 2026 19:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794887130; x=1795491930;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAKEG6F3NngM39Nhk+BCauWEhF43gL0skdjARbMmqnM=;
        b=v9s7/WQX2Bz67qqbJywGx5tC39m7sBNduw8dNcOQUVzIVARjtMGB2Ew4CIEQaEY/uA
         7xxpjZiWvaJ4mCx8lDPOHRr08+g15E1cMOK0vq+/gXelbxFL3N72514HZBCmY22AUl1b
         C81ntDXuwgIJSbvPumXN6/2oN7Gr8LNX5VZ15ejKadVOjq2H3ioXh2DVDbled+Js35Jt
         xXBJzE9xx72ACe7yfJaGdl49tXi1tO/h64iIpr2oSoOqE2sLKNFEI0/+JXela+CeJGMM
         h/6ITFlyAB+tW0hc6B+skm4Kgb/lGYOsBBwm4HmRbYML+4GJkSgY92A+P02HQjbsRPuj
         Xepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887130; x=1795491930;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAKEG6F3NngM39Nhk+BCauWEhF43gL0skdjARbMmqnM=;
        b=LPTIabATEJtWB8Q1DBF+mWAF04CfimMKGCLnTTRzs+nUjll6TpjwGUE7DZhWJNH2XQ
         OJjG4qOsIulkvaLY/6ylQpUThIngIL261VL3T85+E5ydcB6o0bU9QUwWMOUG3+j17xBD
         P/my8ggupHvUNigym56WsJdxy/FnXwnIoSD/9IOp9VaOZle6bg8AfbKgkYQjApXyJY5X
         Ubcb+eVx88V8jv8O0MjCSC2dHOuGh44sYZyhUyBpwS75eMvyb0Ql0oOYrFg+RBZS+p+i
         6DuNqF5YmIdgspaSbA5f+Rty3OlnZMfRRtNeM9FAonJQe6chKUXJQkGcS8GMShN9BMsb
         lgoQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEuBr23mDoKJ5DuUSsOqb17SKqwvncwYBxaJ5oPUhUNGlMg+UM2icIPBuGPvzp49fSuTeajNiMtgNbE@alsa-project.org
X-Gm-Message-State: APuU4Z+X/eXhNwSWEVv32qzAn+wFKAh6ns1KMyme9zs8EMBigPwbs9la
	YcPFtIgwFl2n9LYCCWqXs3Gxu0I4cliZIWb/KVL/xaXu2Ds8FsxL7d0V
X-Gm-Gg: AZFdTZcNBjRKY8Lzbdv8DepWKR7nCkH3kFGxGSYxQgky4NzylOhIszosue6j+BYXvCG
	m4n5I92kfG2jJaxW5WvYzt5A1q24ZMe/Qbvas/wn0sNXGcViKsulEe0iWBVazdooBSPdWghK/9A
	RSYG9/uJYqCqUDXDahYfKrI6SdZ9YJYv3MxmPQPEXL999ifABH/PZniB4GTcVblgMh7Lse61nzj
	+6URxOsoh9keee7wSJVB8+Ven0ZdaBNXDfv/T/lSQoTXnCaiZapomOHRbGbGYv/4Oxy6wyrqmBu
	rj1svgdlB0I9vyKbe0KKH1bZrf+Arz4K8NRVs53x1cjwc8+PbZoeMNe0bfVfUBTpMvFbgRhfNpK
	XOz5GFIdHV2e6f2uMGduas6Cc5ySxhVaqzG28zFXxuo9WYb7BZqRAm/knQldCeUgx6R9C8TIjvy
	8+pBgcPIGOTnRwMAic99t4jmNwoFlbqf+FU+IsuynhUOchlwOH2YWJ0V8HGS6RdFh0HYQ7ckssU
	30wku88Z9iBHdOUWN66Bk+9WM9j76qwrH6UxmL1fnAGlKLMeGYdhmUulqkr4XR5ZPMFLMv0Ezlb
	tkJYKjPqwPBeqUdNaCgbkDug3ROEMJH8a/lusszdVc1FMHy+BPbHRo4xbj8K
X-Received: by 2002:a17:90b:1b09:b0:3ac:a11a:7c84 with SMTP id
 98e67ed59e1d1-3b1b0cccc43mr11659049a91.65.1794887129620;
        Mon, 16 Nov 2026 19:45:29 -0800 (PST)
Received: from [172.20.10.2] (42-79-72-63.emome-ip.hinet.net. [42.79.72.63])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac70ea45sm1720814a91.17.2026.11.16.19.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 19:45:29 -0800 (PST)
Message-ID: <6d7f4ecd-bac0-44d6-a704-57cdd2877729@gmail.com>
Date: Tue, 17 Nov 2026 11:38:20 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 lkp@intel.com
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-3-YLCHANG2@nuvoton.com>
 <20261109-myna-of-noble-downpour-e09d3e@quoll>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20261109-myna-of-noble-downpour-e09d3e@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EC6EBGJJVCMXZHMNEWPJ4YLMNX5GUSW3
X-Message-ID-Hash: EC6EBGJJVCMXZHMNEWPJ4YLMNX5GUSW3
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:13 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EC6EBGJJVCMXZHMNEWPJ4YLMNX5GUSW3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


On 11/9/26 21:15, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 01:12:51PM +0800, Neo Chang wrote:
>> +static void nau8310_init_regs(struct nau8310 *nau8310)
>> +{
>> +	struct regmap *regmap = nau8310->regmap;
>> +	unsigned int clk_det = 0, ana_ctrl = 0;
>> +
>> +	/* Latch IIC LSB value */
>> +	regmap_write(regmap, NAU8310_R02_I2C_ADDR, 0x0001);
>> +	/* Block MCLK */
>> +	regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL,
>> +		NAU8310_MCLK_SEL_MASK, 0x7 << NAU8310_MCLK_SEL_SFT);
>> +	/* stall DSP */
>> +	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
>> +		NAU8310_DSP_RUNSTALL, NAU8310_DSP_RUNSTALL);
>> +	/* Default ADCI from slot1, ADCV from slot 0. */
>> +	regmap_update_bits(regmap, NAU8310_R0C_TDM_CTRL,
>> +		NAU8310_ADC_I_SEL_MASK | NAU8310_ADC_V_SEL_MASK,
>> +		(0x4 << NAU8310_ADC_I_SEL_SFT) | 0x4);
>> +	/* Set I-sense digital gain to +10.25dB */
>> +	regmap_update_bits(regmap, NAU8310_R14_ADC_VOL_CTRL,
>> +		NAU8310_ADC_GAIN_L_MASK | NAU8310_ADC_GAIN_R_MASK,
>> +		(0x1 << NAU8310_ADC_GAIN_L_SFT) | 0x62);
>> +	/* PGA in Class A Mode */
>> +	regmap_update_bits(regmap, NAU8310_R76_BOOST,
>> +		NAU8310_STG2_SEL_CLASSA, NAU8310_STG2_SEL_CLASSA);
>> +	/* Set I-sense PGA Bias Current to minimum,
>> +	 * Disable PGA Common Mode Lock.
>> +	 */
> Even netdev does not use that format of comments anymore. And this is
> not netdev in the first place.
Got it. I will change the multi-line comment to the standard kernel format:
/*
  * Set I-sense PGA Bias Current to minimum,
  * Disable PGA Common Mode Lock.
  */
>
> ...
>
>> +	nau8310 = devm_kzalloc(dev, sizeof(*nau8310), GFP_KERNEL);
>> +	if (!nau8310)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(i2c, nau8310);
>> +	mutex_init(&nau8310->lock);
>> +	INIT_WORK(&nau8310->load_fw_work, nau8310_load_fw_work);
>> +
>> +	nau8310->regmap = devm_regmap_init(dev, NULL, i2c, &nau8310_regmap_config);
>> +	if (IS_ERR(nau8310->regmap))
>> +		return PTR_ERR(nau8310->regmap);
>> +
>> +	nau8310->dev = dev;
>> +
>> +	nau8310_reset_chip(nau8310->regmap);
>> +	ret = regmap_read(nau8310->regmap, NAU8310_R46_I2C_DEVICE_ID, &value);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read NAU8310/20 device id: %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	nau8310->silicon_id = value & NAU8310_REG_SI_REV_MASK;
>> +	ret = nau8310_read_device_properties(nau8310);
>> +	if (ret)
>> +		return ret;
>> +
>> +	nau8310_print_device_properties(nau8310);
>> +	nau8310_init_regs(nau8310);
>> +
>> +	return devm_snd_soc_register_component(dev, &soc_comp_dev_nau8310,
>> +		&nau8310_dai, 1);
>> +}
>> +
>> +static void nau8310_i2c_remove(struct i2c_client *client)
>> +{
>> +	struct nau8310 *nau8310 = i2c_get_clientdata(client);
>> +
>> +	cancel_work_sync(&nau8310->load_fw_work);
> This looks safe, but still error-prone and discouraged. Use same order
> of cleanup as order of init/allocation in probe.
>
> See also include/linux/devm-helpers.h
Got it. I will use devm_work_autocancel() in probe instead of manual 
cancellation in remove().
>
>> +}
>> +
>> +static const struct i2c_device_id nau8310_i2c_ids[] = {
>> +	{ .name = "nau8310" },
>> +	{ .name = "nau8320" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, nau8310_i2c_ids);
>> +
>> +static const struct of_device_id nau8310_of_ids[] = {
>> +	{ .compatible = "nuvoton,nau8310" },
>> +	{ .compatible = "nuvoton,nau8320" },
> This suggests devices are compatible, but was not expressed in the
> binding (and then second entry is redundant).
I will add the actual silicon ID into the .data field of both 
i2c_device_id and of_device_id to validate it against the hardware ID in 
the probe stage.
>
> Best regards,
> Krzysztof
>
