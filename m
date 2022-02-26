Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFA4C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 26 Feb 2022 12:51:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A33671926;
	Sat, 26 Feb 2022 13:50:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A33671926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645879864;
	bh=Kvyq8ShhXMm0gyA/XIx1U6PdbtxenUupg6yBGMs+Rbw=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nc3xgovucHSOxX4KIiJyYpZfS+FB3u99SmY4m8jgbG8ZbUgmVvYPOycBhZ46e4SOD
	 RODeKcEDFbBZJaYUlXNuKh/+WfpfWEvSk8eNjQf3afamKwV1rLVTG+GWqpxbXZwi0+
	 TW62QR3yh6ivI2mcagnJU+NZ3oOy/u94OtCmkcdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44EA9F8012B;
	Sat, 26 Feb 2022 13:50:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45096F8012E; Sat, 26 Feb 2022 13:50:13 +0100 (CET)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD7E7F800ED
 for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2022 13:50:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD7E7F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="kbdzN50K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645879808; x=1677415808;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1P2Ald/OcCTFw9/tPkaIRqeNCWPrecaJnymxn1sUGis=;
 b=kbdzN50K/jy6cT3Kn0zE5pK32DMI8jobBmFGshDRucDM91VW5cDFQkTy
 xx44eCxQWCmFzyQz0ppzzYZ7oO1xsvI9/aXmI8E1czXm7acVhoLDjhie8
 2FnkMQ+IAxuRXDvNgm9lTm5YjvhiVorV/eztquUCiKzZQnfIWSaM9UMxl A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Feb 2022 04:50:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2022 04:50:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 04:50:04 -0800
Received: from [10.216.36.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 26 Feb
 2022 04:49:56 -0800
Message-ID: <90408caa-6b3b-bd09-10ca-bc6c4431111f@quicinc.com>
Date: Sat, 26 Feb 2022 18:19:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] soundwire: qcom: remove redundant wait for completion
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, <agross@kernel.org>,
 <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <robh+dt@kernel.org>, <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <rohitkr@codeaurora.org>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <swboyd@chromium.org>, <judyhsiao@chromium.org>,
 <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>
References: <1645800257-27025-1-git-send-email-quic_srivasam@quicinc.com>
 <a99a59eb-cd59-f566-b98d-486c94f32eec@linaro.org>
 <06650d56-eed3-73ad-d6b4-6b56a5a70669@linux.intel.com>
 <4811be6f-7e86-2a62-94cf-98504d5e64e7@linaro.org>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <4811be6f-7e86-2a62-94cf-98504d5e64e7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>
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


On 2/25/2022 11:33 PM, Srinivas Kandagatla wrote:
Thanks for Your time Srini!!!
>
> On 25/02/2022 15:43, Pierre-Louis Bossart wrote:
>>
>>
>> On 2/25/22 08:45, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 25/02/2022 14:44, Srinivasa Rao Mandadapu wrote:
>>>> Remove wait_for_completion_timeout from soundwire probe as it seems
>>>> unnecessary and device enumeration is anyway not happening here,
>>>> hence this api is blocking till it completes max wait time.
>>>> Also, as device enumeration event is dependent on wcd938x probe to be
>>>> completed, its of no use waiting here.
>>>> Waiting here increasing the boot time almost 4 seconds and impacting
>>>> other modules like touch screen.
>>>>
>>>> Fixes: 06dd96738d618 ("soundwire: qcom: wait for enumeration to be
>>>> complete in probe")
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>
>>> LGTM,
>>>
>>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> I don't get the idea, sorry.
>>
>> If you look at the code, these are the cases where this 'struct
>> completion' is used
>>
>>     struct completion enumeration;
>>     complete(&ctrl->enumeration);
>>     /* Enable Auto enumeration */
>>     init_completion(&ctrl->enumeration);
>>     wait_for_completion_timeout(&ctrl->enumeration,
>>
>>
>> so if you remove the wait_for_completeion, then you might just as well
>> remove the whole thing and revert 06dd96738d618
>>
>> what am I missing?
> Yes, that makes more sense to revert it, as it is the only user of 
> this completion.
> We could add it back when we really need this again in pm runtime 
> setup if required.
>
> --srini
Thanks for confirmation. Sent revert patch.
>>
>>
>>>> ---
>>>>    drivers/soundwire/qcom.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>>> index 5481341..9a32a24 100644
>>>> --- a/drivers/soundwire/qcom.c
>>>> +++ b/drivers/soundwire/qcom.c
>>>> @@ -1309,8 +1309,6 @@ static int qcom_swrm_probe(struct
>>>> platform_device *pdev)
>>>>        }
>>>>          qcom_swrm_init(ctrl);
>>>> -    wait_for_completion_timeout(&ctrl->enumeration,
>>>> -                    msecs_to_jiffies(TIMEOUT_MS));
>>>>        ret = qcom_swrm_register_dais(ctrl);
>>>>        if (ret)
>>>>            goto err_master_add;
