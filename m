Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DB5C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806DF64E2B
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 15:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806DF64E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8D811770;
	Mon,  1 Feb 2021 16:51:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8D811770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612194727;
	bh=iG3ua2iUBWPBnjj4sUNbMMd/GLtoK476ZCkTqx7F/9s=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8DJ6J4hg1lorulCGLwAkHwX/WwDp4J9Nws1GTd438Fj01VzkPGQbYB9EFyzIADLt
	 LAL81rWVn6rDSzSrW5jHvIfeW9skdfyV7c6BCXtp33t02lLggObWBeIexanEYxXFHQ
	 iiNn86OQZRewKv/zQmQgMcm+IoGmgH/kKqixR5VY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10399F80155;
	Mon,  1 Feb 2021 16:50:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47FE5F80154; Mon,  1 Feb 2021 16:50:30 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A77DBF80154
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 16:50:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A77DBF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="YyHaK4nx"
Received: by mail-wr1-x42f.google.com with SMTP id p15so17057622wrq.8
 for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2021 07:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qH2QKnpkKtv2v7miYr/6O0hwnSs48bF9jSY/Wu7YY6U=;
 b=YyHaK4nxBs3RWREyZodtI2kE3kTl/JHASvlXuJxJ2Rxj0PtSlsmDLXsQmoHPVbxRZN
 WRJ0tfbyBt3G+M8wsY0kzL3L7OBVFEepkIHwV8YCjAHkwpP0eDACSesq9puzLzWNkt3e
 FVixlTQ21Yt45OTLNvWaE8+MxsGyz9x9h4d3jc2e4VDOH6wOlltM4Mwa4uxWME+MaLGa
 UkqAHXrM2bNXuHCJc+8nwYxxCU4hGiQwAthF0HBEA+606b9RzbF3iQucBXQloPpviTav
 jA96LxQ6hM/IN5gshgvO8AEMPQuVO0e5oBtERZQx3YDFw5m1fXlxr5NicHCczhwMS6TL
 5NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qH2QKnpkKtv2v7miYr/6O0hwnSs48bF9jSY/Wu7YY6U=;
 b=e/izmOrI7keCcG6sJj5dn5r9xT6mJSuRoxLLKdUc+SoFhvzDQnltUXoWn5Yxi9r9JE
 eSXce5aFam7wiS8CyZzTkgvpoB+lsko96N0DIgkfwT3LQ7Fe0xGfpWNUrLI+SPI6WVy/
 NQoqJDj2GFO7b/CTclcR3ZUX6AtH0ov8sIwtvOwU5N3V/xgvgXVLzX3EopafA2pETdl0
 M6AnGGUQ1D6bwD0wgowBMLg/t0BdZvl3BZ9fnUmS675PSEjgxGfx9NMC5xf+PKR4v3sj
 LUfwcf+l8mQuv5jY92HI6lo95kjL4POn6O923w6s6wC1/l8UsBsOIOyB58WhtaOAK6Yp
 4knA==
X-Gm-Message-State: AOAM532hbHSScYtu36nFjkhDux3NbNGSM6LcpwwEY0GuBHFBhw5kO2lX
 q6bz1MGu1+9J+FIZAYkdMcVladvTMseKMw==
X-Google-Smtp-Source: ABdhPJx+fpVnGk/D6O8Vqf1D2v0j/tla3RgrDrTu+WQwxDYkaSaQWWoNEtHw8+WQT0Eo1z7hdT04aw==
X-Received: by 2002:adf:decb:: with SMTP id i11mr18519129wrn.78.1612194624190; 
 Mon, 01 Feb 2021 07:50:24 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id b11sm26826114wrp.60.2021.02.01.07.50.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Feb 2021 07:50:23 -0800 (PST)
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To: Vinod Koul <vkoul@kernel.org>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
 <20210201141345.GA2771@vkoul-mobl>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c52aaad5-513a-8dee-bc5b-3bb5a4ffe18b@linaro.org>
Date: Mon, 1 Feb 2021 15:50:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201141345.GA2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 01/02/2021 14:13, Vinod Koul wrote:
>> +
>> +	ret = of_property_read_u8_array(np, "qcom,ports-hstop", hstop, nports);
>> +	if (ret)
>> +		memset(hstop, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> why not memset the whole area here and then populate it..?

That is other way to do it!, I can do that in next spin!


--srini
>> +
>> +	ret = of_property_read_u8_array(np, "qcom,ports-word-length",
>> +					word_length, nports);
