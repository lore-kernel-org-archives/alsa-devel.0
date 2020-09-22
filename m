Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FFC2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:23:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0B8238A1
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nCW64zma";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFkCRyZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0B8238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 902F116FB;
	Tue, 22 Sep 2020 13:22:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 902F116FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600773820;
	bh=nanek3e98LCrmaqR0PELR9Ui+LyUP0r7qiry6my0GQk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCW64zmaGKcAWiJsjOQDkjTGKt65qk9+vWo/gtcuGaldkjKVQo6ZouUrVxeRjQJMZ
	 3V4p3j+6/fBHNTyY7HY4VL43gxcFh046nSlk45EUbNSTEhDVB/CmonmHyeq4LrlJKE
	 Gk0Z941snZWObiUgvKdjxyaQu3li/zb72eAAtPQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F6F1F8015F;
	Tue, 22 Sep 2020 13:22:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABBBDF80229; Tue, 22 Sep 2020 13:22:48 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB7C9F8010A
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 13:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB7C9F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="HFkCRyZ/"
Received: by mail-wr1-x443.google.com with SMTP id a17so16603579wrn.6
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KcHBNX7nlokKK8kXMf7m8iqw5HFaqgsL1z5AnKdw5mI=;
 b=HFkCRyZ/G04J1NQM/rjpr4zU+6zo1oRGQLNqubIT4svzl5PHzy4iRgnOurNoDiI+Gi
 MXvyGTRi0Z0M5B6IopUrBYm9enSxRWJM5DL+VfI4K6tad9FBRV3XF4cJiW1MiSQVyF+I
 35Fg2wVjsjmBxcuTvBy+PbR0MjEnh5qRCk3phLYnJYAauDA71gn39IDbMsgXObjAgK0p
 i+KukRYF9A5kA/Xz1g7Ln4BZBwE2A/IlGSJKr19MLpYW9bHEWY8jbr+rrX94VtW/S1+p
 aLBNlVR6tinobS/05m0JH2pXzvGToQ2BIMswIsiwvB3e2DeUqzQmUmYtBDnC6ufG5KP7
 6BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KcHBNX7nlokKK8kXMf7m8iqw5HFaqgsL1z5AnKdw5mI=;
 b=E1njCClJHUJsIt5Q8odtbvcI2viMLHFSdHcYIIX6TX7uk0eCemzCS3ct+mmgRhsOj2
 O5A7gaV2g6W6hNBf/TGn8Jqbegjt6hXh1QLfX1u4YnOGP8ORiK0/00Is8Y6es8PWZjvt
 EyqPcN18qDVNXJi19o4JVqxEinn7hJb1o+1PzvhccyoPRew5qhuXPE/LVuw/YghHLhlx
 OT2cUfPnKQIodcdXUoE7sLJU7X8u3FE+yRv4cmp70FJFV70J9wC016eEj/lFO6V0O8je
 EMDByU9Mby/DUUFyvFh2Jc1Mfw90v7hnSgq/6zuZAAVlr+Q2ZEDyR6V8nGJIGU1UMQ6z
 7+dQ==
X-Gm-Message-State: AOAM532olxajKwJkuQb+NmR2dllkm3XgO3aERSqWod/sG5HbyK9IHqpH
 VrZ+dRG+WHE2WvPrgkInNC9f1w==
X-Google-Smtp-Source: ABdhPJwoirXaeQd83hSfKFcPFFMyZX+E/QOqT24xhgtDSOc64OlQ49XFn+VCUoLu28OplXJhN5OQGg==
X-Received: by 2002:a05:6000:109:: with SMTP id
 o9mr4276415wrx.364.1600773760449; 
 Tue, 22 Sep 2020 04:22:40 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id n10sm4494807wmk.7.2020.09.22.04.22.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 04:22:39 -0700 (PDT)
Subject: Re: [PATCH v6 3/5] Asoc:qcom:lpass-cpu:Update dts property read API
To: Mark Brown <broonie@kernel.org>
References: <1600409084-29093-1-git-send-email-srivasam@codeaurora.org>
 <1600409084-29093-4-git-send-email-srivasam@codeaurora.org>
 <040290a8-26a3-ab9c-04dc-beb23ee827e8@linaro.org>
 <20200922110825.GN4792@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3866ce69-b7d0-5eb5-e0aa-874d150cd47a@linaro.org>
Date: Tue, 22 Sep 2020 12:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200922110825.GN4792@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, rohitkr@codeaurora.org,
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



On 22/09/2020 12:08, Mark Brown wrote:
>> On 18/09/2020 07:04, Srinivasa Rao Mandadapu wrote:
>>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
>> Index is always preferred over name w.r.t device tree bindings, so lets
>> stick with that for now!
> It is?  That's not usually the case...
> 
>> Unless you have any strong reason to lookup resource by name?
> Looking things up by name tends to make the DT easier to read (since
> things are named).

I agree with you on this and I see the point, but Rob had a very 
different opinion about the reg-names bindings to start with.

This topic been discussed in the past with Rob in many instances ex: 
https://lore.kernel.org/linux-devicetree/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/

According to him, reg-names seems to be highly discouraged as it came 
along for the OMAP folks and was related to the hwmods stuff.


--srini

