Return-Path: <SRS0=4JIF=JE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1AC43462
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 02:05:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEAE613B7
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Apr 2021 02:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEAE613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1C6D1661;
	Wed,  7 Apr 2021 04:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1C6D1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617761113;
	bh=Xf7acD44xqRewo59TpyrG2oCFO8lk6jKVWXRH6Sokls=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=joGk36C4dFnYTAYgRHSrPDK6O2wjazoizXppXCYdCoUsnX5Q2emAO2PT9T0Jvnf3n
	 7BzNjzAwQhDaHcSGiJjCpjTOrLGeCFDvQ8al1zMoJUKoavs47N1Lu9O0GaxDNCQUa5
	 rWshnvnBD9tJQqAC/IFpcVU0MyBYKRUibT0sGaeU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A9CCF80162;
	Wed,  7 Apr 2021 04:04:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C36A4F8016A; Wed,  7 Apr 2021 04:04:20 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 169F0F80124
 for <alsa-devel@alsa-project.org>; Wed,  7 Apr 2021 04:04:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 169F0F80124
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFSL86MN4zPnsj;
 Wed,  7 Apr 2021 10:01:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 7 Apr 2021 10:04:02 +0800
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
To: Rob Herring <robh@kernel.org>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
 <20210331091616.2306-3-thunder.leizhen@huawei.com>
 <20210401202056.GA947212@robh.at.kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a1aed23d-a9d2-5e05-b1f5-3b48ac8d17f1@huawei.com>
Date: Wed, 7 Apr 2021 10:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210401202056.GA947212@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Cc: devicetree <devicetree@vger.kernel.org>,
 alsa-devel <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
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



On 2021/4/2 4:20, Rob Herring wrote:
> On Wed, Mar 31, 2021 at 05:16:16PM +0800, Zhen Lei wrote:
>> Currently, if there are more than two ports, or if there is only one port
>> but other properties(such as "#address-cells") is required, these ports
>> are placed under the "ports" node. So add the schema of property "ports".
> 
> A given binding should just use 'ports' or 'port' depending on it's 
> need. Supporting both forms is needless complexity.

Right, I'll adjust this patch again.

> 
>> Otherwise, warnings similar to the following will be reported:
>> arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: \
>> sound@ec500000: 'ports' does not match any of the regexes: \
>> '^rcar_sound,ctu$', '^rcar_sound,dai$', '^rcar_sound,dvc$', ...
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> index 384191ee497f534..a42992fa687d3f3 100644
>> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
>> @@ -115,6 +115,11 @@ properties:
>>      $ref: audio-graph-port.yaml#
>>      unevaluatedProperties: false
>>  
>> +  ports:
> 
>        $ref: /schemas/graph.yaml#/properties/ports

OK, thanks

> 
>> +    patternProperties:
>> +      '^port@[0-9]':
>> +        $ref: "#/properties/port"
> 
> Then this should be: $ref: audio-graph-port.yaml#

OK, thanks

> 
> Also, what each port is should be defined, but that's a separate 
> problem.
> 
>> +
>>  # use patternProperties to avoid naming "xxx,yyy" issue
>>  patternProperties:
>>    "^rcar_sound,dvc$":
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

