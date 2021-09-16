Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA349C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:03:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0EC60FC0
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD0EC60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74EE11896;
	Thu, 16 Sep 2021 17:02:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74EE11896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631804628;
	bh=aUo7lQcT0Cwg28oblpbQoaX701e9yT6AM1LeDKkriWM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FISjFsQoAgKGA2V2EedSsrzawRqndHIYqfgCF3AyaPhtbhrgVodbf99EpWOfVNnLg
	 am4GA0OaNThpGB5CqdG+erqtH8M/9qHRWSq3D6x/HL7e3iTxirBYhNvbhtosKAYdyV
	 jfXcN7SOFRXjHb9j3AumB/RxbhXXsxyksmnflRLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55447F80117;
	Thu, 16 Sep 2021 17:02:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D319FF804AE; Thu, 16 Sep 2021 17:02:22 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EB71F80271
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:02:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EB71F80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Z664gqGs"
Received: by mail-wm1-x333.google.com with SMTP id
 j17-20020a05600c1c1100b002e754875260so4720263wms.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4st4d0n/c6mOCznyfG1WKwjyR2c2WbGE6A+uf+Jpfts=;
 b=Z664gqGshV6QS/uZt8KAROXekXdyXiPwjqcEHXCgCcXK/U2baJVNkI+UlrvCSE88te
 2Tj9siVf8KKPpbIDzDPBk5XmlVg5TQo23PJ4RCr7LnAE9it21FyHrL/LwoIe1zyt4scJ
 k3yqMFXWLNiOVfc8QXZft82bWvrvsqBQEDXzSh/ujMwUrSL8l37uOEGv5cyEcYkwtN8t
 Tr2EhK8wrCmQ7EPyAy5mep10E6K0Z0cFUQJH31GqjJ/l+O1dCUN7ucKhWkrRjskM02r+
 m8Y94PihWPZBcACFBw7sDc/PN2TZeWnzJMFDmZsptqQmWCURFG+dDRNcpmbHvjWuKIc7
 brVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4st4d0n/c6mOCznyfG1WKwjyR2c2WbGE6A+uf+Jpfts=;
 b=DbaBKU+Neglt5Q3G0HxPZnKNfihWMtAskbMBQ8BGpimQN4qdmkk11QTCJFuniHTpiO
 fifm3RA8sA6tNifp1KLP8wYNXtnsSBjSGhVQbX6VawaXgoR0+tIFMogcyzjUkPiR2xL9
 YVuX0pV8RWyGVvIEHxQ+VS6HMM+JK/FvUy58djhM6ceMNoUqjN8JTIz/7Ehxpbtokoww
 L52bkkBwaUN3Y5QZs8O5doI2aHrKLkT7qjnRFHNI8XSm1T+/TLDMLmWNGcL0AWJqnyLJ
 MCqSFPfpfS6QPnRk3a5zJ1jtMl9urfZA2Z35P3LQxPeUgznMEpvwgk5Bxar5Au1lf2KC
 yvZQ==
X-Gm-Message-State: AOAM533LsRpe8UQkr3EVdImX70dCxrZuu7kKE8LM6qhKLa/8HBUJ90iq
 xmdeXX2WyP0qW3pEIetL+bHnKA==
X-Google-Smtp-Source: ABdhPJxuGMPwZqNTuMGal9SnScfBsFWd/A9g+0vbtND8vr1Ldf8Z2LsCupcin5UZzRzQJfSn0eTeFA==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr10498262wmg.25.1631804535434; 
 Thu, 16 Sep 2021 08:02:15 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id o2sm4264200wrh.13.2021.09.16.08.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 08:02:14 -0700 (PDT)
Subject: Re: [PATCH v6 14/22] ASoC: qdsp6: audioreach: add basic pkt alloc
 support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
References: <20210915131333.19047-1-srinivas.kandagatla@linaro.org>
 <20210915131333.19047-15-srinivas.kandagatla@linaro.org>
 <c6082189-5788-0973-2fba-699f1cc7e4ae@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7132182e-32d3-5d60-6c56-a779f24a5c19@linaro.org>
Date: Thu, 16 Sep 2021 16:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c6082189-5788-0973-2fba-699f1cc7e4ae@linux.intel.com>
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

On 15/09/2021 16:54, Pierre-Louis Bossart wrote:
> 
> 
>> +#define APM_SHMEM_FMT_CFG_PSIZE(n) ALIGN( \
>> +				sizeof(struct apm_sh_module_media_fmt_cmd) + \
>> +				n * sizeof(uint8_t), 8)
>> +
>> +/* num of channels as argument */
>> +#define APM_PCM_MODULE_FMT_CMD_PSIZE(n) ALIGN( \
>> +				sizeof(struct apm_pcm_module_media_fmt_cmd) + \
>> +				n * sizeof(uint8_t), 8)
>> +
>> +#define APM_PCM_OUT_FMT_CFG_PSIZE(n) ALIGN((sizeof( \
>> +				struct payload_pcm_output_format_cfg) + \
>> +				n * sizeof(uint8_t)), 4)
> 
> nit-pick: sizeof on the same line for consistency/readability?
> 
Its fixed in next version.

--srini
