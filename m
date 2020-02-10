Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0BCC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:32:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B612082F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K3/qOj44";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SVT3B09p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B612082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD63715F8;
	Mon, 10 Feb 2020 12:31:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD63715F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581334324;
	bh=s1fJD3bpJ96QXPN1HtkVlFHAIBdJ+xctR5YaZjePuwc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K3/qOj44KbaycNn4OvOzpp6YfOK0YQYN++uy4Y31GLJ1XrUu/DSJaeLZdPsUC7+tn
	 dSCe7OOQSuhWA2NpLuzvaGF2cbbF3yT0k8aAmNNhm6YmAUzAFROJBpKYIfHnP+eqK0
	 +wz93jWZBWn9cjsgl1mxC029CQMP2GDghNka8dj0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3993EF8014F;
	Mon, 10 Feb 2020 12:31:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA130F80157; Mon, 10 Feb 2020 12:31:11 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B651F80118
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 12:31:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B651F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="SVT3B09p"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e413eba0000>; Mon, 10 Feb 2020 03:30:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 10 Feb 2020 03:31:05 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 03:31:05 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 11:31:00 +0000
To: Rob Herring <robh@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-2-git-send-email-spujar@nvidia.com>
 <20200206181045.GA31521@bogus>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <af58b6b2-25b2-e968-73c9-d87e1a9e2746@nvidia.com>
Date: Mon, 10 Feb 2020 17:00:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206181045.GA31521@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581334202; bh=DYL3dZJkEVqUGlDqhgL79tzAopnW50b/PvD3VPtCz4U=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=SVT3B09puLJ0HA8nQ33vpaM1nSIdapHPpPnu06IUpu6honXcI8z48njhrgA2mAZVG
 Nraii4NI7mW14tzzXDSmK6n3Uf1quCemwdC7G82dHNDVcstYy35pggrAGt4+UUx0S1
 E9v+MH6n2NXFeQHHX40HsnW0nyVyJ74rTPbi5pWyhWL6HICigtZ6dHb3bDtYSXLR8C
 0TPAFT3Uz/sLBp+VQS2esmGLOTMfQkxxSXT1yfSzyoBdTjxTTk9iTdAvgNe/ce7AQy
 denV6bBbJj8R+Jal58cfw4tXqtdRCAEE0QkHf2XjPbvUcWD82evOMzxqBBvd2mdisZ
 rlgcvULu9P1mA==
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, atalambedu@nvidia.com,
 linux-kernel@vger.kernel.org, spujar@nvidia.com, lgirdwood@gmail.com,
 tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
Subject: Re: [alsa-devel] [PATCH v2 1/9] dt-bindings: sound: tegra: add DT
	binding for AHUB
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 2/6/2020 11:40 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jan 30, 2020 at 04:03:34PM +0530, Sameer Pujar wrote:
>> Audio Hub (AHUB) comprises a collection of hardware accelerators for audio
>> pre-processing and post-processing and a programmable full crossbar for
>> audio routing across these accelerators. This patch adds YAML schema for DT
>> binding of AHUB and few of its following components. These devices will be
>> registered as ASoC components.
>>   * ADMAIF
>>   * I2S
>>   * DMIC
>>   * DSPK
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../bindings/sound/nvidia,tegra186-dspk.yaml       | 105 +++++++++++++
>>   .../bindings/sound/nvidia,tegra210-admaif.yaml     | 165 +++++++++++++++++++++
>>   .../bindings/sound/nvidia,tegra210-ahub.yaml       | 130 ++++++++++++++++
>>   .../bindings/sound/nvidia,tegra210-dmic.yaml       | 105 +++++++++++++
>>   .../bindings/sound/nvidia,tegra210-i2s.yaml        | 112 ++++++++++++++
>>   5 files changed, 617 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
>> new file mode 100644
>> index 0000000..dc9fef3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
. . .
>> +    items:
>> +      - description: initial module clock rate
>> +
>> +  "#sound-dai-cells":
>> +    const: 1
>> +
>> +  sound-name-prefix:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Used as prefix for sink/source names of the component. Must be a
>> +      unique string among multiple instances of the same component.
>> +      The name can be "DSPK1" or "DSPKx", where x depends on the maximum
> Sounds like a constraint.

Is there a better way to convey the recommended strings above?

All the other comments I will fix in next revision. Thanks.
. . .
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
