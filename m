Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E631FC433E9
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 07:00:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662EC64E3E
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 07:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662EC64E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA46316C7;
	Wed, 10 Feb 2021 07:59:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA46316C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612940407;
	bh=IVynKrVv1a9kT0KESPlMPp+wYUNRXQTps3ENAzA2oow=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6DIevS4tuUSOmm5oNVRxPzqA5mwU2PUuge+lAn6nEUZfrovQgI4MrzZKdweBYxgk
	 UIIX4CXggu6t8vkjCl/KjHLKOZ4N8tloemEwft3PndInQZ3ZuwO//CnjBqC5OqmHXS
	 saQ+NmO0zcY1NmNAH0mXV1irihIPHLlmAI3GVzZY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43AA9F8010D;
	Wed, 10 Feb 2021 07:59:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0A75F8022B; Wed, 10 Feb 2021 07:59:13 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3565DF80165
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 07:59:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3565DF80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="DLPHblKc"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B602384360001>; Tue, 09 Feb 2021 22:59:03 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:59:02 +0000
Received: from [10.25.99.168] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:58:57 +0000
Subject: Re: Re: [PATCH v2 1/9] ASoC: dt-bindings: rt5659: Update binding doc
To: Thierry Reding <thierry.reding@gmail.com>
References: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
 <1611944866-29373-2-git-send-email-spujar@nvidia.com>
 <20210205152933.GA3089668@robh.at.kernel.org>
 <eb490eb1-d7e2-a188-8e62-496f9a1d99bc@nvidia.com>
 <YCLgPKtLyT9PL1/6@ulmo.localdomain>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <e33e5266-e0d3-5318-a9e5-4dcb00b9b708@nvidia.com>
Date: Wed, 10 Feb 2021 12:28:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <YCLgPKtLyT9PL1/6@ulmo.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612940343; bh=7yrhYOs91UiuNjgRtR9OoL0rm9nKEiCtcwwaAr+kPyU=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=DLPHblKcUPz5LIi6RZ4luT7p0nXHB9E5zZ5rznJdfK21hdskQHNXHS1hqPxp548HT
 EROhRygrhadbwWF5xrTmfu0og2FgaCAHT3H9tACOMcIJZlt4h+Xg6wtWnm8DWBkxOj
 LI5KH5zicct9QycE5C65zGgoKp3nXcFQ1f1bpvGaBIST5DlYH1Mgc08CTpYf5vNV9C
 OpR9otAQ24fXvxFceyh3mvqdBYc+XHVMkwyUpFtHkgEC7jsdhGzOGY2gBvrL5Tc5H2
 IPUiZPTH9U7nFy5gVkx9zncycaqnuKCpuY54G+Jdt+ExVuNqMpDQKigqbP9NsEtp9A
 D7oOSFJRmLrNw==
Cc: Oder Chiou <oder_chiou@realtek.com>, Rob Herring <robh@kernel.org>,
 alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 devicetree@vger.kernel.org, lgirdwood@gmail.com, jonathanh@nvidia.com,
 sharadg@nvidia.com, broonie@kernel.org, linux-tegra@vger.kernel.org,
 Bard Liao <bardliao@realtek.com>
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



On 2/10/2021 12:49 AM, Thierry Reding wrote:
> On Tue, Feb 09, 2021 at 06:51:58PM +0530, Sameer Pujar wrote:
>> Hi Rob,
>>
>> On 2/5/2021 8:59 PM, Rob Herring wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Jan 29, 2021 at 11:57:38PM +0530, Sameer Pujar wrote:
>>>> Update following in rt5659.txt binding doc
>>>>     - Add JD source for Intel HDA header: Commit 041e74b71491
>>>>       ("ASoC: rt5659: Add the support of Intel HDA Header")
>>>>       added driver support. Add missing info here.
>>>>
>>>>     - sound-name-prefix: Used to prefix component widgets/kcontrols
>>>>       with given prefix.
>>>>
>>>>     - ports: Helps to use the Codec with audio graph card
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Cc: Oder Chiou <oder_chiou@realtek.com>
>>>> Cc: Bard Liao <bardliao@realtek.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/sound/rt5659.txt | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
>>>> index 56788f5..c473df5 100644
>>>> --- a/Documentation/devicetree/bindings/sound/rt5659.txt
>>>> +++ b/Documentation/devicetree/bindings/sound/rt5659.txt
>>>> @@ -37,10 +37,21 @@ Optional properties:
>>>>    - realtek,jd-src
>>>>      0: No JD is used
>>>>      1: using JD3 as JD source
>>>> +  2: JD source for Intel HDA header
>>>>
>>>>    - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
>>>>    - realtek,reset-gpios : The GPIO that controls the CODEC's RESET pin.
>>>>
>>>> +- sound-name-prefix: Please refer to name-prefix.txt
>>>> +
>>>> +- ports: A Codec may have a single or multiple I2S interfaces. These
>>>> +  interfaces on Codec side can be described under 'ports' or 'port'.
>>>> +  When the SoC or host device is connected to multiple interfaces of
>>>> +  the Codec, the connectivity can be described using 'ports' property.
>>>> +  If a single interface is used, then 'port' can be used. The usage
>>>> +  depends on the platform or board design.
>>>> +  Please refer to Documentation/devicetree/bindings/graph.txt
>>> Please read what that file says now.
>> Sorry, I did not understand above comment. Can you please elaborate a bit
>> more?
> I think what Rob meant to point out is that graph.txt now contains a
> mention that the file has been moved to a more central location, which
> is the dt-schema repository. So instead of referencing the graph.txt,
> which then redirects to the graph.yaml in dt-schema, it'd be better to
> directly reference graph.yaml from dt-schema.
>
> That said, I'm not aware of a good or standard way to make such a
> reference. Perhaps in this case, given that the rt5659 binding is not
> very large, you can convert the file to json-schema first and then use
> standard json-schema references for this.

OK, in that case I will try convert this binding to json-schema in a 
separate patch. Thanks.
