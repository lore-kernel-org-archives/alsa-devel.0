Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F864C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:03:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F92561216
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F92561216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B8761884;
	Thu, 16 Sep 2021 17:02:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B8761884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631804585;
	bh=4oakNQtciC9ApNawPDuJs2rgf9ryqlbEczwtIupyVzw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EVoeIPj/q6aLiCO8JIJkarZd6tit20qSSDFWtGPbbIazV4hhSh45JTkBP5cS761lt
	 wxFPwDGdZSfBPpSmIsRU+M4njXrvdqd0Rwo8QEVu76B1yoCIGOw1+bfuxzHSydTlsb
	 Hu1s40Uizc+bb7qmEIYW5GhXPBn12Yf4dTT6EKek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9885FF8025A;
	Thu, 16 Sep 2021 17:02:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B1A1F8025E; Thu, 16 Sep 2021 17:02:13 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9716F80113
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9716F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="LYPGj0po"
Received: by mail-wr1-x42a.google.com with SMTP id q11so9993713wrr.9
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=csQ1MWc5sV0qhfV6R4T1gxw/hYapqEzRXs9dv7ZLsGQ=;
 b=LYPGj0poWIctsfOuBHXwVqe8+7faAzwKMZkHv8w/oBHTuxFYsuDi/WTO1vYXzcLhMB
 K6Wdiaswd88e0undEeQLqPzp1lzE/JaRg2Dk6JJWOxbi6ZJg5XlVREThmdUzuFes9DIk
 PbjY+q8R2GBTg8YswrbFJvLEiLyw+mTGj+Q6n78/jowXZeMNRgG6V7KsDr7lt8uN2NL8
 z/zl6nJiqeqmKLMC/4Iwd4X85As5F/FBKTFf5fI+OCNnRXDLANYVOAqr8JI3VpTajms6
 V2MOUpNUFLBT1yMBZCTK84tT3aYhJVQ9Th5k3fyKVshAR25CWEdVkpDe2bJnea3JXE4Y
 urEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=csQ1MWc5sV0qhfV6R4T1gxw/hYapqEzRXs9dv7ZLsGQ=;
 b=k4awc24UhDbmlZUsdRN3MZlYvnkV1HjLwDj1IstIJLIgOkL0zjPN0z5R2jddl6EfEv
 qKi72GzAPBwQfZpsXjF2KZ2PS9fedWh7GV3V6FCfIyzoRG7uWOl1jOwci+cptIAyGdoS
 oVQYps1rOuIubwqW3j9ZZFcvSf9ppcEWiaGg35Es2zXT/3XLFKOzBte7LCwXuEmphsax
 IyWbdt/W+XulKa7UGRDVOD/R8S0RCXEfL34m2al9saDZ+XXAFJ5qwDOUHYEN1bPNZ2DN
 zpQnXS2ItDGySAsvAKU4ZMJuGJxcuXh7ejvdAie1+8vz8XET1zZTRSJxcLVQvmN/3t62
 XVVg==
X-Gm-Message-State: AOAM5329kYD/XO5s7xjqO2clPB+Ier5Q1R/Korhbt4TQrzp0sJcitUBM
 TVg5UTPik5aUS/Y/EcsWO9JlCA==
X-Google-Smtp-Source: ABdhPJyytYPgs97uBMV0kIWC2G4lKa6lnjW2JayT2BL8liWzxGpiTeW5ACLrmyPYxEeCjzEC2i+Bmw==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr6792001wrw.402.1631804529677; 
 Thu, 16 Sep 2021 08:02:09 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id d7sm3771387wrf.3.2021.09.16.08.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 08:02:09 -0700 (PDT)
Subject: Re: [PATCH v6 05/22] soc: qcom: apr: Add GPR support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
 <20210915131333.19047-6-srinivas.kandagatla@linaro.org>
 <83c503aa-7cb2-e6fa-e22a-b359a9cb9059@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f71f5c7-42c4-6419-5f79-26ed83695793@linaro.org>
Date: Thu, 16 Sep 2021 16:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <83c503aa-7cb2-e6fa-e22a-b359a9cb9059@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Thanks Pierre,

On 15/09/2021 16:47, Pierre-Louis Bossart wrote:
> 
>> +gpr_port_t *gpr_alloc_port(struct apr_device *gdev, struct device *dev,
>> +				gpr_port_cb cb,	void *priv)
>> +{
>> +	struct packet_router *pr = dev_get_drvdata(gdev->dev.parent);
>> +	gpr_port_t *port;
>> +	struct pkt_router_svc *svc;
>> +	int id;
>> +
>> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
>> +	if (!port)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	svc = port;
>> +	svc->callback = cb;
>> +	svc->pr = pr;
>> +	svc->priv = priv;
>> +	svc->dev = dev;
>> +	spin_lock_init(&svc->lock);
>> +
>> +	spin_lock(&pr->svcs_lock);
>> +	id = idr_alloc_cyclic(&pr->svcs_idr, svc, GPR_DYNAMIC_PORT_START,
>> +			      GPR_DYNAMIC_PORT_END, GFP_ATOMIC);
>> +	if (id < 0) {
>> +		dev_err(dev, "Unable to allocate dynamic GPR src port\n");
>> +		kfree(port);
>> +		spin_unlock(&pr->svcs_lock);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	svc->id = id;
>> +	spin_unlock(&pr->svcs_lock);
>> +
>> +	dev_info(dev, "Adding GPR src port (%x)\n", svc->id);
> 
> nit-pick: isn't this a bit verbose?

Yes, Its now removed.

> 
>> +
>> +	return port;
>> +}
>> +EXPORT_SYMBOL_GPL(gpr_alloc_port);
> 
>> +struct gpr_pkt {
>> +	struct gpr_hdr hdr;
>> +	uint32_t payload[0];
>> +};
> 
> looks like a zero-length array?
> 
looks like I missed this one, its fixed now.

--srini
> should this be
> 
> struct gpr_pkt {
>      struct gpr_hdr hdr;
>      uint32_t payload[];
> };
> 
> ?
> 
