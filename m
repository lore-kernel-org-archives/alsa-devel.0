Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C78C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:59:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5A72067D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eJw87GY2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="h1W+ShGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5A72067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C23421677;
	Wed,  8 Jul 2020 12:58:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C23421677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594205940;
	bh=sb49Lhx9GDHwB0c8xewVQKEXzyqzx3TRM/zX3M8b7Ms=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJw87GY2IOHlczr5dq0DT7Bz8qQSs34eBjWFJ7uZHgHGxOBFMF6dEY6QeFtPBplN2
	 4v0nmXn2uNWeuc3clKXKTR22daMsrrVffFB8glGbwE2i+7VYD7Nv3o4oAamB/uk2dG
	 FyWffXjgKrdnMg3RH+kKJ4z976YjYo2Xkc07jjYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5924BF80150;
	Wed,  8 Jul 2020 12:58:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28DE9F8015A; Wed,  8 Jul 2020 12:58:09 +0200 (CEST)
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88212F800AE
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 12:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88212F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="h1W+ShGR"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1594205879; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=XH6S1HvL7E7qoaCSA4Oa2h+z4LdFnJsuWn/J2aZDrbY=;
 b=h1W+ShGROOytnAjo9/9aRBJvAcFqx3SVbLehndquQklQJhfZvZt5ow0kR3kJ6q07hEVEBcDk
 hXD8VEEdk7jcjr0UH/aiOV8W0P+i14pypM2hBsZnOmH+U6NdhbLSG+CwHNmVdDcGpxDA4WIC
 ry+3kIZ1lOWCBmK0NafEGrFM24M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f05a6b355886724ffb10483 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Jul 2020 10:57:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 909FEC4339C; Wed,  8 Jul 2020 10:57:55 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: rohitkr)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C084C433C8;
 Wed,  8 Jul 2020 10:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C084C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [RESEND][PATCH v3 7/8] ASoC: qcom: lpass-sc7180: Add platform
 driver for lpass audio
To: Mark Brown <broonie@kernel.org>
References: <1594185286-11323-1-git-send-email-rohitkr@codeaurora.org>
 <20200708103301.GG4655@sirena.org.uk>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <e7986896-3ffd-f565-7590-0638eb6f7641@codeaurora.org>
Date: Wed, 8 Jul 2020 16:27:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708103301.GG4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 srinivas.kandagatla@linaro.org, agross@kernel.org,
 Ajit Pandey <ajitp@codeaurora.org>, bjorn.andersson@linaro.org,
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


On 7/8/2020 4:03 PM, Mark Brown wrote:
> On Wed, Jul 08, 2020 at 10:44:46AM +0530, Rohit kumar wrote:
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> Add platform driver for configuring sc7180 lpass core I2S and
>> DMA configuration to support playback & capture to external codecs
>> connected over primary & secondary MI2S interfaces.
> I only have patch 7 here, no other patches or cover letter.  What is
> going on?

Hello Mark,

Sorry for the confusion. I posted complete patchset and resend only 7th 
patch as

it had invalid mail id in Signed-off. I should have probably updated it 
in Patch v4.

Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

