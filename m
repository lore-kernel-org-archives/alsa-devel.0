Return-Path: <SRS0=e+ka=QF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C799C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 10:06:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D4C6108B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Nov 2021 10:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10D4C6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFF4017C6;
	Thu, 18 Nov 2021 11:06:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFF4017C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637230015;
	bh=0fk/mhOOhRm0ATMCTgNO4kKu5h52r3egP9Fe8A23V+A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/k+hLRV6sjXgNDMtdKb3HmXtUu1jdhxa9OARDSXbz+QL4HgrzMMBQlJ10D6mmK16
	 G2xdA3ppIXnDWdCwWbQD4P4lrTGFmpUqB9PQ1bvuc7Gs2nAh3qCF3Rfchw8u4dMEaH
	 hRoQfAxKujUdAbX0xFVdmxh2ryktUXbn/thiNxF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC9CF8026D;
	Thu, 18 Nov 2021 11:06:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB76EF80272; Thu, 18 Nov 2021 11:06:02 +0100 (CET)
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93D16F800FA
 for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2021 11:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93D16F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="SNHIYQKD"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1637229956; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=aa4GMuDD9gBxObbJT1ejXAr5fy0x2AqK6SqkkPflRc4=;
 b=SNHIYQKDf7QZ39GJ5iKzfnUFPYgL2G4Kzz1bLeGIRfS6KGFvVtl9SLnOX+moWXOq+sDbHJZf
 94Gua10F0m/iavPhqkbQaNjMPqCdcYXNlnq+ANjhvvwpuCBuhq1Nim4hSAsqUViktHSDHkz4
 JYalQeCcDU85hU2cQrIFIiedwbw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61962582665450d43ab06519 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 10:05:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5C508C43460; Thu, 18 Nov 2021 10:05:53 +0000 (UTC)
Received: from [10.242.143.72] (unknown [202.46.23.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A623C4360C;
 Thu, 18 Nov 2021 10:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8A623C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v4 00/10] Add support for audio on SC7280 based targets
To: Mark Brown <broonie@kernel.org>
References: <1635838265-27346-1-git-send-email-srivasam@codeaurora.org>
 <YZUT6BQKz00jXov9@sirena.org.uk>
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <e01729cd-0b2b-fe27-809b-c75ccbb6fac4@codeaurora.org>
Date: Thu, 18 Nov 2021 15:35:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZUT6BQKz00jXov9@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, rohitkr@codeaurora.org,
 swboyd@chromium.org, judyhsiao@chromium.org, linux-kernel@vger.kernel.org
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


On 11/17/2021 8:08 PM, Mark Brown wrote:
> On Tue, Nov 02, 2021 at 01:00:55PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> This patch set depends on:
>> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=570161
>> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=572615
>> 	-- https://patchwork.kernel.org/project/alsa-devel/list/?series=559677
> None of those links seem to show any patches (or errors)?

Sorry for Inconvenience Rob. I think due to it's status change patches 
are not being appeared on provided link.

With removing filter able to see patch set. Below are the links with 
view filter change.

-- 
https://patchwork.kernel.org/project/alsa-devel/list/?series=570161&archive=both&state=*

-- 
https://patchwork.kernel.org/project/alsa-devel/list/?series=572615&state=%2A&archive=both

-- 
https://patchwork.kernel.org/project/alsa-devel/list/?series=559677&archive=both&state=*

>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

