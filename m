Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5082C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jun 2022 05:04:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22B1F3E8;
	Wed, 29 Jun 2022 07:03:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22B1F3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656479072;
	bh=3HQGRjmPKvddqdq+bhX+Ji/uvhDxPk0WOY8eh/FI0eE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aUD4M2F0DNY7viLSAKparzA8em+RFviUQ6q7GkZjfWesw/ld8oM3YpayyRCypeXPM
	 2m6aXGKgRqB4v++WhFhPuSjwVeKbn0UzdcldPuSGfjPseR6eGFfxo5lqtN4E7hcnBI
	 ndYv7e36RiTBJ825jvu2jVipzu18Eo7FOYMx0peo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE3A1F80115;
	Wed, 29 Jun 2022 07:03:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86331F8020D; Wed, 29 Jun 2022 07:03:39 +0200 (CEST)
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AFEEFF80115
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2022 07:03:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFEEFF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="Rf99ksM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1656479017; x=1688015017;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VEdJqhOh3yH/m1FuRD7+jl00FLtfIpFlcJjFxurhIMk=;
 b=Rf99ksM5nT3qFDP9heY1maF5CMboRWrZrB5UMgC1dYBXUAffk7fGlD7P
 pL0HM0+6KqS9zqcPIkJVbRxYMorKIxEu8lf0W/GD9ehxl2gGfL8Gu39JQ
 D4TX5u05EpesPTy+xkKEIacqSuiWa9RGjdhgaaUihC4LzRyRdecAb5Ht5 I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jun 2022 22:03:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 22:03:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 28 Jun 2022 22:03:32 -0700
Received: from [10.216.11.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 22:03:26 -0700
Message-ID: <c9e75687-fadb-2a0f-56c6-37830799774d@quicinc.com>
Date: Wed, 29 Jun 2022 10:33:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/2] Add software clock gating requirement check
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
References: <1654863815-3970-1-git-send-email-quic_srivasam@quicinc.com>
 <YrQfs7HUIOV5x8Ub@matsya> <7b532c96-e36b-207e-532c-8b41f7106831@quicinc.com>
 <YrvcVOo+f3+W4aoz@matsya>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YrvcVOo+f3+W4aoz@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
 tiwai@suse.com, agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
 quic_plai@quicinc.com, bjorn.andersson@linaro.org, judyhsiao@chromium.org,
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


On 6/29/2022 10:30 AM, Vinod Koul wrote:
> On 27-06-22, 18:01, Srinivasa Rao Mandadapu wrote:
>> On 6/23/2022 1:39 PM, Vinod Koul wrote:
>> Thanks for your time Vinod!!!
>>> On 10-06-22, 17:53, Srinivasa Rao Mandadapu wrote:
>>>> This patch set is to add software clock gating requirement check
>>> This fails to apply for me, please rebase on sdw-next and resend
>>>
>>> Thanks
>> It seems one patch is missing in your branch, which accepted by Mark brown.
> Ok. Pls send on -next and if there are conflicts we can coordinate with
> Mark.

The same patches were sent on -next branch. If the previous applied, 
it's being applied directly.

Please correct me If my understanding is wrong.

