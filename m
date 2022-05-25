Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAFEC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 12:31:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5314163F;
	Wed, 25 May 2022 14:30:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5314163F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653481872;
	bh=3uocaVIHsPj/lmM3zXrwynXAvlfKLTYbPpHZZ/HLPrM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eQS1Yn3Zx20zlwtp7/q2+WIegsCKSTPLwEFLG9xLooanTJ9s1O5NRPj05KuwNwBld
	 wt/VJnqksXRq6Pb7LElxKSdYeWM85bgSLD5BkldGAahZuB284PWDcF5CWGc/41vT/J
	 9YsCvAbMUlPBLFf7RyCm5OPqcU2pXcD22hkk84Ik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D58EF80169;
	Wed, 25 May 2022 14:30:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7340F8016D; Wed, 25 May 2022 14:30:20 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EFE1F80169
 for <alsa-devel@alsa-project.org>; Wed, 25 May 2022 14:30:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EFE1F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="jCDdo5yi"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PCK9qm022732;
 Wed, 25 May 2022 14:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bPVKOjeRLgXhCaHSGPSwKkUnur7RswwoIBP9rTXhPjQ=;
 b=jCDdo5yiVDPtLuDw4vitdYjaky4ixEwyDDa//s/LwSA+o1NuoKVKs6DK6TKzVxFvkmtP
 qWpzv0rUNCdU6bZssDznIsZHKp5EycQgTe7D6UhvUJdzcx7Poi2hV7O/XlfGPgLfzMex
 HjzSmEBK3RnQpxj7hkHKUIh8McLyh3Vh0GAZIqGBQr1QfLI8RR5iiNkYptBQlB2EY3g3
 xH/iPLzvbApkgc1+lKG6lapfF/tfdZe38lKZDmzUMU7CmAfPpHlNu0z6TyATDdr94yTx
 OhIKgeRRtqE4nPAgszg/iQCiJXs6zDzy99XQoP7SeUgxWJ0lO+kOddgLxGk1ls1StD4D +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g93v864rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 May 2022 14:30:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEDD9100034;
 Wed, 25 May 2022 14:30:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A28FE229A8D;
 Wed, 25 May 2022 14:30:14 +0200 (CEST)
Received: from [10.211.12.178] (10.75.127.47) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 25 May
 2022 14:30:13 +0200
Message-ID: <b346eb00-fde1-2dc0-e6e3-09dbf1359c20@foss.st.com>
Date: Wed, 25 May 2022 14:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: stm32: sai: Use
 of_device_get_match_data()tosimplify code
Content-Language: en-US
To: tangbin <tangbin@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
References: <20220519124235.21100-1-tangbin@cmss.chinamobile.com>
 <69d5cef3-57c0-9bc7-a83b-a85ef1c4cf29@foss.st.com>
 <YovZAf4S0XphBsco@sirena.org.uk>
 <3fb8d7f8-4506-3b28-22cb-863bda1f21c8@cmss.chinamobile.com>
 <d5ab354a-eb10-d31c-d55e-46a4c4d1a4ce@foss.st.com>
 <cd375914-a3e6-37c7-4a16-551937006f92@cmss.chinamobile.com>
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <cd375914-a3e6-37c7-4a16-551937006f92@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_03,2022-05-25_02,2022-02-23_01
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, alexandre.torgue@foss.st.com, tiwai@suse.com,
 mcoquelin.stm32@gmail.com, arnaud.pouliquen@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

Hi Tang,

On 5/25/22 09:36, tangbin wrote:
> Hi Olivier：
> 
> On 2022/5/24 22:30, Olivier MOYSAN wrote:
>> Hi Tang,
>>
>> On 5/24/22 03:44, tangbin wrote:
>>> Hi Mark & Olivier：
>>>
>>> On 2022/5/24 2:57, Mark Brown wrote:
>>>> On Mon, May 23, 2022 at 03:28:48PM +0200, Olivier MOYSAN wrote:
>>>>
>>>>> The current patch requires a change in the driver.
>>>>> Either changing STM_SAI_x_ID enums, or replacing data by a struct.
>>>>> For instance:
>>>>> struct stm32_sai_comp_data {
>>>>>     unsigned int id;
>>>>> }
>>>>> struct stm32_sai_comp_data stm32_sai_comp_data_a = {
>>>>>     .id = STM_SAI_A_ID;
>>>>> }
>>>>> struct of_device_id stm32_sai_sub_ids[] = {
>>>>>     .data = &stm32_sai_comp_data_a},
>>>>> }
>>>> Either approach works for me (or a revert for that matter).
>>>
>>>      Thanks for your advice, I was thoughtless.
>>>
>>>      I think change the date of STM_SAI_x_ID maybe simple. But if we 
>>> don't change the id,
>>>
>>> what about add a "#define" like the line 47:
>>>
>>> #define STM_SAI_IS_SUB(x) ((x)->id == STM_SAI_A_ID || (x)->id == 
>>> STM_SAI_B_ID)
>>>
>>> then in the judgement, wu use:
>>>
>>>      sai->id = (uintptr_t)of_device_get_match_data(&pdev->dev);
>>>
>>>      if (!STM_SAI_IS_SUB(sai))
>>>
>>>              return -EINVAL;
>>>
>>>
>>> if you think that's ok, I will send patch v2 for you .
>>>
>>
>> If we allow null value in STM_SAI_IS_SUB(sai) check, we can miss real 
>> NULL pointer error from of_device_get_match_data().
>>
>> The simplest way is to change STM_SAI_x_ID enums I think.
>> But honnestly, I feel more comfortable to let the driver unchanged.
>>
> Oh，you are right, I am sorry.
> 
> Please forget this patch, I'm sorry to have wasted your time.
> 
> But I saw some codes is useless in the line 48 & line 49, I think we can 
> remove it.
> 

Yes, these two defines are no more useful.
Feel free to send a cleanup patch.

BRs

Olivier

> If you think so, I will send this patch for you.
> 
> 
> Thanks
> 
> Tang Bin
> 
> 
>> BRs
>> Olivier
>>
>>> Thanks
>>>
>>> Tang Bin
>>>
>>>
> 
> 
