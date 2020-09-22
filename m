Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC5C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:54:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024282399A
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dYz9YcYK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lpMj6ywC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024282399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 120B81710;
	Tue, 22 Sep 2020 14:53:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 120B81710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600779260;
	bh=MT4Y1aIPh0Oqx/ShxQroYgOFvJ6UJF8+RhbXKqCC/9g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dYz9YcYKqwmsqaIfO6JjdHoLJBOv20qi1hD9nIr/vMaLd/93naFv15POUgPd+uc9f
	 S8p8Xg90vsm3meDoAf2xfWUzk3B/ZMGkQQHRBW2OFti2DKOY3h1JqjdWu0ahDOvcbQ
	 Aks7IkpxDVlVhNB9ZMSk/EvWVCfdWWes83oSpKN0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90E3DF80229;
	Tue, 22 Sep 2020 14:53:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5179F80232; Tue, 22 Sep 2020 14:53:24 +0200 (CEST)
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78E4AF8015F
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 14:53:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78E4AF8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="lpMj6ywC"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600779194; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=hbKrx2SwcynLY6Cgk+5NmFAHVfb6P5BLBtwJdA9I6rQ=;
 b=lpMj6ywCj7Pq8CAGHVV/J5nEfBORC1MnGhXFgNMUAIzhQm5Pq1TKo1y2pDizJHiS2bY/pHYm
 KuR4zktK4CjKVV+xjzZyUU6BqgM85CIJD67o/nQTJSthfpgAKcWO0wSml6EL4kUHgYH/LOq6
 uFN3E0ME2OMx3sixuEyet/jXois=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f69f3b60492bd2f0f95a93f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 12:53:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D9935C433CA; Tue, 22 Sep 2020 12:53:09 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.141.209])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: rohitkr)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 553B1C433C8;
 Tue, 22 Sep 2020 12:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 553B1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v6 3/5] Asoc:qcom:lpass-cpu:Update dts property read API
To: Mark Brown <broonie@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <1600409084-29093-1-git-send-email-srivasam@codeaurora.org>
 <1600409084-29093-4-git-send-email-srivasam@codeaurora.org>
 <040290a8-26a3-ab9c-04dc-beb23ee827e8@linaro.org>
 <20200922110825.GN4792@sirena.org.uk>
 <3866ce69-b7d0-5eb5-e0aa-874d150cd47a@linaro.org>
 <20200922114319.GR4792@sirena.org.uk>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <7f682cf9-0f2a-0227-d5d8-8bedf1f06b00@codeaurora.org>
Date: Tue, 22 Sep 2020 18:23:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922114319.GR4792@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, linux-kernel@vger.kernel.org
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


On 9/22/2020 5:13 PM, Mark Brown wrote:
> On Tue, Sep 22, 2020 at 12:22:38PM +0100, Srinivas Kandagatla wrote:
>> On 22/09/2020 12:08, Mark Brown wrote:
>> I agree with you on this and I see the point, but Rob had a very different
>> opinion about the reg-names bindings to start with.
>> This topic been discussed in the past with Rob in many instances ex: https://lore.kernel.org/linux-devicetree/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/
>> According to him, reg-names seems to be highly discouraged as it came along
>> for the OMAP folks and was related to the hwmods stuff.
> That's very much specific to reg, it's not true of the use of names in
> general - Rob mentions cases like interrupts for example.

I see that patch to support hdmi adds another reg-name along with 
"lpass-lpaif".

So, platform_get_resource_byname() is better option.

+       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, 
"lpass-hdmiif");

Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

