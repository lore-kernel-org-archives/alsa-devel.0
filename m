Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2292C4363C
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:15:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD320797
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZH1HVXsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XtU5tYzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD320797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DDEE16CE;
	Wed,  7 Oct 2020 09:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DDEE16CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602054899;
	bh=JeoI3ziz+NTXrap41CW7jZogjojeC8FcdQLS4rEkkYg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZH1HVXsqPqvP50RMZ4dD90DPDbPIUGEN60232t3qWX5WqTfNGQ2mL378TY4u24noC
	 DsalLMUgp9uVVnKEn52t2Uo5WHwY+tL7niKDe+sUuedEDa0HcP6lF1pUGdxz063g2P
	 aTh4L1AMC72NSi5ODOCpvvpBlUntslqZ8W6TeSbU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1226BF800EE;
	Wed,  7 Oct 2020 09:14:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE802F80128; Wed,  7 Oct 2020 09:14:06 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5156F800EE
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 09:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5156F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="XtU5tYzm"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f7d6a810001>; Wed, 07 Oct 2020 00:13:05 -0700
Received: from [10.25.101.204] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Oct
 2020 07:13:53 +0000
Subject: Re: [PATCH v3 09/13] ASoC: dt-bindings: tegra: Add schema for audio
 graph card
To: Rob Herring <robh@kernel.org>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-10-git-send-email-spujar@nvidia.com>
 <20201006203433.GA2786434@bogus>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <a5bc07d8-fb2e-e86e-f0d3-be19166ad7bb@nvidia.com>
Date: Wed, 7 Oct 2020 12:43:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006203433.GA2786434@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602054785; bh=/ogdgdqjxjkT33GrVdiECGAlj2ugqSEXgT8/zYZImUA=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=XtU5tYzm3GfSAkuTvH6PQaSeYmYjAL/rAufBtULI6I/l1BCpFnrNWb/u2GuIbET8t
 i9+b6WyIVw6t7dplUat1O/UItoSMD+DLVdQpI/cO+KuU/hnS/2S5nBq68dA2uta/88
 EFJ7am0x2CxfeZL6GidrchQR7m+aunCB5+y8/ks4sh/U5cMdr7333eVaUndl7oPAeW
 UXfO6g2OvKhr0dMtWH2w7yvC1UzE/E72L4Le8CnulD1cPXxUlLQR4Lt6S9tZclsBUZ
 jaix0aRqcfKO+B0Koj1B02Wb6SmWrQin/EkmitiWvaH1osQU03KklCXK3vKK6NA+Qq
 zglpDOr/HxZMA==
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, linux-kernel@vger.kernel.org,
 nwartikar@nvidia.com, tiwai@suse.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, devicetree@vger.kernel.org, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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


>> Add YAML schema for Tegra audio graph sound card DT bindings. It uses the
>> same DT bindings provided by generic audio graph driver. Along with this
>> few standard clock DT bindings are added which are specifically required
>> for Tegra audio.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../sound/nvidia,tegra-audio-graph-card.yaml       | 70 ++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
>> new file mode 100644
>> index 0000000..b73fbe5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-graph-card.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Audio Graph based Tegra sound card driver
>> +
>> +description: |
>> +  This is based on generic audio graph card driver along with additional
>> +  customizations for Tegra platforms. It uses the same bindings with
>> +  additional standard clock DT bindings required for Tegra.
>> +
>> +  See{LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt
>> +
>> +maintainers:
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Sameer Pujar <spujar@nvidia.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: nvidia,tegra210-audio-graph-card
>> +      - const: nvidia,tegra186-audio-graph-card
>> +
>> +  clocks:
>> +   minItems: 2
>> +
>> +  clock-names:
>> +   minItems: 2
>> +   items:
>> +     - const: pll_a
>> +     - const: plla_out0
>> +
>> +  assigned-clocks:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  assigned-clock-parents:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +  assigned-clock-rates:
>> +    minItems: 1
>> +    maxItems: 3
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - assigned-clocks
>> +  - assigned-clock-parents
> Where's the graph? You need to define the ports and reference the common
> schema.

I am looking to reference the bindings used in below doc which is not 
yet in YAML format. Only additional properties I listed here.
{LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt

Should I keep this doc to *.txt format as well and later move to YAML or 
is there a way to reference *.txt doc here?

