Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F08C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Mar 2022 01:53:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 448B318A9;
	Thu,  3 Mar 2022 02:52:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 448B318A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646272391;
	bh=XfrjREq9+Lt0/PDEq4RtZKOe7Yuy3MBWVk0EQX5EWDg=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Krr45ez0+LV4nDHpvzctgnfI5fnotpzuz2uB99hDCFzpPdqekHSnmWNDqcRyTgdhQ
	 0L55+mWMjUgz4jEzSGQxwhC3WS4JU3bcXMfk+SbqlsuAspeW5fwArzILVAIe/c/tli
	 Ulk3ug6WH+78sujjp50yL42aX0RpFIk+ZtEZ0lvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D331CF80171;
	Thu,  3 Mar 2022 02:52:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9FA7F801D5; Thu,  3 Mar 2022 02:52:18 +0100 (CET)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28D0FF80054
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2022 02:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28D0FF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="SZB4SmPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1646272335; x=1677808335;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=icOWcKXZ8RLcuFhBmkMKn2v/xS0KeI078BnGvm3HMPU=;
 b=SZB4SmPhAnRDuUJoeKRU0L/ENzgeu9ke4GMY5/MaQb8DXXNQmFeoCpxK
 jlqpO2ChZwJApRZVT2lNw091YEhqFOdPo1GO0Mx3rTh0TEUZe2cILtqBG
 OHJDJ0I8m81+epY4PzYDDnFXXU2+tnq3/T69wR6FRLWQmGVpQklJy1EzV 4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 17:52:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2022 17:52:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 17:52:09 -0800
Received: from [10.216.42.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 2 Mar 2022
 17:52:03 -0800
Message-ID: <6a1a4129-00af-4db2-6bd5-974784646e50@quicinc.com>
Date: Thu, 3 Mar 2022 07:21:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 1/3] soundwire: qcom: Add compatible name for v1.6.0
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-2-git-send-email-quic_srivasam@quicinc.com>
 <Yh+Qs6P3pm2mHDjJ@matsya>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yh+Qs6P3pm2mHDjJ@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, yung-chuan.liao@linux.intel.com,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, rohitkr@codeaurora.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, quic_plai@quicinc.com,
 sanyog.r.kale@intel.com, bjorn.andersson@linaro.org, judyhsiao@chromium.org,
 Venkata Prasad Potturu <quic_potturu@quicinc.com>,
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


On 3/2/2022 9:13 PM, Vinod Koul wrote:
Thanks for Your time Vinod!!!
> On 02-03-22, 18:13, Srinivasa Rao Mandadapu wrote:
>> Update compatible string and master data information in soundwire driver
>> to support v1.6.0 in lpass sc7280 based platform.
> Where is the documentation of this new compatible
The compatible name already exists in 
Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/soundwire/qcom.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 5481341..fc41210 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -1348,6 +1348,7 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>>   static const struct of_device_id qcom_swrm_of_match[] = {
>>   	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>>   	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>> +	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_5_data },
>>   	{/* sentinel */},
>>   };
>>   
>> -- 
>> 2.7.4
