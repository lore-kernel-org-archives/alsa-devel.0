Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB6C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:02:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0172F24677
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TfivRJVf";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg9j5KJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0172F24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AE5E851;
	Tue, 10 Mar 2020 15:01:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AE5E851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583848948;
	bh=KYkDfpx/696TDrbh885sJllEq+R5Da/AAD0RVIxHPpM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TfivRJVfszWekPRjgyA0MNlW+4bt9CiVpmQnpVl27LvvKW9c5mngLo3rdxqL+jtL+
	 Z+T3FkwJH2zmBw0udkJ644Dhis5NQmM9RA3YEwE9CThlsiteOAdFV0W6OXHkMGIQTD
	 8YzMm/uJ2e2U1YyJlp7wK8g9N/ohH2lgptXQ+D2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96617F800BC;
	Tue, 10 Mar 2020 15:01:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69621F80217; Tue, 10 Mar 2020 15:01:35 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D839DF80123
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 15:01:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D839DF80123
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Pg9j5KJ9"
Received: by mail-wr1-x441.google.com with SMTP id v9so15992153wrf.10
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AnADibbBZNTbkXF8oP66EJ2LJrhavRvEH5BdYa4Z43I=;
 b=Pg9j5KJ9zBcxILALXyg3gWGW7/Stl3nDwqDBu50I4TaRt3m76JyHsQ33/vAbB8E4DS
 N2SVSJq3bfMIINej22L0ObEE9D9LOT7ZNOVxV/QW+oMokDluh7G9hVa2LZdTtbK3YmwQ
 9vkoPwdSUFk4Zd5ENqC82QO9dpU3c/lWcUaZxzAmUl1crb4+IeC7Od0byO1kFeKaMMwm
 GC1TzchHvo2y7X6XRjlXvM8h7shcu2xmS4xB+5QQCTVMU457W3C8Zk/oYH+/QkO5D7U/
 dGz/XCd8UC82saEVqT9/blCgLTBUhqxfDqIizN6Z8bmny0ZTKiZx2YeJCnQLtxSRY714
 zI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AnADibbBZNTbkXF8oP66EJ2LJrhavRvEH5BdYa4Z43I=;
 b=UFFLGrPdhW26DYqjmSGSyHm5uvoP1rTEvOSAzRZ2khNxvNzbTfYaUjq4P7h8RMzamF
 +AlwdYMlj6rQpN4rmv67jj2gfnRMZ/kRa102+DGn9cYNI26FnRrFQwdc/ScShPfXCwrW
 c1MtrGNiSQS4qqqB6a/2Se5/8uIO8K94EwN6I0N8WFmVzwO3yHH6rpY317VhBPKJTgD+
 s1YMGJFiuWLqhk92JHHbHsjSHg4A5+xDLbbBKa+m+hLxilG0b5a0NRx44kuC+8GdLRIH
 VgyaFtZbURkcvelmFTwW3Vs5ihOrGFGysuyWbdhPPG9qVJtKKFu0p1l0aNILJ6KjKsYR
 ChBQ==
X-Gm-Message-State: ANhLgQ3UJ+elgvAKGIbUHE6ZR3XcCaor1dp6C1EjmaE0wCtjlgBqR6TC
 XYcimnuoWpAE3CfF2o4xhBmV3Q==
X-Google-Smtp-Source: ADFU+vtrFiSPgHeTnpNZFmkHKh2VMNUzxHfW2YQYEVtGmsqDarT61MtKoEjE1bMeApA7NHSvLPnpKg==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr27238694wrs.272.1583848890432; 
 Tue, 10 Mar 2020 07:01:30 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id q7sm12887765wrd.54.2020.03.10.07.01.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Mar 2020 07:01:29 -0700 (PDT)
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
 <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <92d3ae1b-bace-1d20-ef99-82f7e1a0a644@linaro.org>
Date: Tue, 10 Mar 2020 14:01:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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



On 09/03/2020 18:05, Pierre-Louis Bossart wrote:
>  > My recommendation would be to add a DisCo property stating the
> WordLength value can be used by the bus code but not written to the 
> Slave device registers.

Does something like "mipi-sdw-read-only-wordlength" as slave property, 
make sense?

--srini
