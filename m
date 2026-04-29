Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E61CFF885A
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:34:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D240F601C6;
	Mon,  4 May 2026 13:34:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D240F601C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894460;
	bh=w71dxo57Zrri0BmXfwEUcuG0+jv+nEEnhsJ7Ls9Yk0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NBqYeqZUiuSa0lapXu8lpaOQNrJANuv13ES1RCCMlos2nxEko01FmycfoExVik8V8
	 vSBKmkKC/tw6phdX6uIRAZV7t0n+MAe/Sg0ze8lW+w2QyrLXZoVfoIHyfCymTuPOcX
	 pLiRrCMH5BYTkDeuZt0erjHZD/OAbWtat4GC/m9w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94DDBF8063D; Mon,  4 May 2026 13:33:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3960EF8063A;
	Mon,  4 May 2026 13:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 877B0F80544; Wed, 29 Apr 2026 05:03:58 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 427F8F8016D
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2026 05:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 427F8F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kxjritad
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2b788a98557so64366965ad.2
        for <alsa-devel@alsa-project.org>;
 Tue, 28 Apr 2026 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777431834; x=1778036634;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iaJ/54PXSumlBHm/F5PZT9zPYaknG4mMWl6w5wLw/w=;
        b=KxjritadCZqP4RdjQUCANobhzR3Nqx8u2iS+fVi56MXg6h4tJjWo6tT+naV7G6JMqm
         SxglyQM7LlHE3hIPcjg6yiAP6jL/c44zklKucFqwJae1yex9f4WVdTuVszYPgA+m3FJg
         mrGl8n3n9Os59db/IgusEuzcyNbB+2BA4AjgUDZG3HLDcmdZHytW3Fi1rNE1l29uRqKl
         5i/6G2mo9IxuSxyCItc37/lh4pNJHK+a/XiVXNky4eA8SovrtsHVOYUI7JBMJi+EvlC/
         +UspuWjvBPA6n0deqnTWBs2WmNH91ajTVFMDX/AqiyqhjXBn4hArJrSY8bE7SW/O5n0o
         dwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777431834; x=1778036634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iaJ/54PXSumlBHm/F5PZT9zPYaknG4mMWl6w5wLw/w=;
        b=Kl5jF4mlDRwNrxwA7PL/0K3/pfUr8G2L59tekddVIOLOZxEu+WkgplTg2Wfno8JIth
         30t4n/yqHJ3kCSsG6wqzRK02mPkRcRpyKF5FaluhXpSgt6innEjO1RwBAStTLga6gG7c
         HxNsZ4dWTFkjOisg4JRVxUXY42Q4weLkDAqXBdH4V1J8/cZh4zP6JMNP4EHrBejoXIPZ
         PkS0U/eS6WszUrProu/IPfeLNeVMIAScXsOLY0R/Y/cfQ811o5iNHXA2WvZiigEVKZQw
         6te58DPOFhEwx5viiY/Fad/gZ1YCMSrC4sIHwJbTS+wxSvQyXcYOHyTdUawfmYKgLNZ4
         VFRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pgGyiK8dE1BBSKA10sOIYoNLSuKaPSVUoeOrkH+egFk6tiRjl3QQNkbxhPrR6WmFvi0CQWrj/i8yz@alsa-project.org
X-Gm-Message-State: AOJu0YyPW8N0O0/4c9GZcc3yePzxg/uvOyoozR2ivqGcUwEqJkG6QAub
	hRet9sXdBGPdncwDlFL4T6Bw2c2oyZ6jM85QM4wyt19pYxg1DvfQJNND
X-Gm-Gg: AeBDieuaxyc/Ss2tYyHKBIhap25icNx8CjkhSbR86Gdo7G6eDOyWYyfcZF/JjwKBrye
	NwYmHdUvkVSBeFBdx8Yz3q3HhC0rYxL9/otX+iV4aeEvKYoEPIBcO9r465V8kWKAaovcIFdYjEt
	l++QV5KE6MCwKfl8MHZUltpfj2ovfN1F8/c47hCzgt5KWx9MvZXzsbRZvwrSAmj2Eg6qZr/WHt5
	6BIyKPOssnb34XgoslWVnU4rmYS6q4WQ56dubGVj9K7Fj217hsdYeujayja8Fosdt51n5Kv+qld
	egnXc0hU23iags9zEyjyZo3T/f/a6TWqnWA842YePtitPrTdfUV+n2x95S4B9Gy9SxcN9uO5tBo
	fnptqK1i7bgVPvQOFbk/3ZreIH7aIeFCh+Gc89pMwNVkW6R2nyf9+wxVdGrby98m8VwOkqf3Xm4
	C83L7+gZGKcNUx+KgkQz2TBq4dYOBNrzWYdcJ4Ep6yyLPpIBN7dPaMsLV1koOkwE5xVpGA
X-Received: by 2002:a17:903:2b0d:b0:2b0:5ec1:97c1 with SMTP id
 d9443c01a7336-2b97c3d6b08mr55442745ad.7.1777431833794;
        Tue, 28 Apr 2026 20:03:53 -0700 (PDT)
Received: from [172.20.10.2] (42-79-67-210.emome-ip.hinet.net. [42.79.67.210])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98893f132sm5877035ad.49.2026.04.28.20.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 20:03:53 -0700 (PDT)
Message-ID: <909885cd-286e-3fbe-9e06-26334c1bb96e@gmail.com>
Date: Wed, 29 Apr 2026 11:03:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add bindings for
 NAU83G60
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
References: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
 <20260424033953.280520-2-YLCHANG2@nuvoton.com>
 <20260425-independent-puzzling-pigeon-a3fd84@quoll>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20260425-independent-puzzling-pigeon-a3fd84@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IYCVVFHZMHZFUIRCMIPMXHC6QO3WEI22
X-Message-ID-Hash: IYCVVFHZMHZFUIRCMIPMXHC6QO3WEI22
X-Mailman-Approved-At: Mon, 04 May 2026 11:33:17 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYCVVFHZMHZFUIRCMIPMXHC6QO3WEI22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 4/25/26 18:13, Krzysztof Kozlowski wrote:
> On Fri, Apr 24, 2026 at 11:39:52AM +0800, Neo Chang wrote:
>> Add device tree bindings documentation for the Nuvoton NAU83G60
>> audio amplifier.
>>
>> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
Got it. I will fix the commit subject in v2.
>
>> ---
>>   .../bindings/sound/nuvoton,nau8360.yaml       | 115 ++++++++++++++++++
>>   1 file changed, 115 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>> new file mode 100644
>> index 000000000000..29b10155c4f9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8360.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton NAU83G60 Stereo Class-D Amplifier with DSP
>> +
>> +description: |
>> +  Stereo Class-D Amplifier with DSP and I/V-sense driver.
> If "driver" as in "Linux driver" then please drop the word.
Got it. I will drop the word 'driver' in v2.
>
>> +  This device supports I2C.
>> +
>> +maintainers:
>> +  - Neo Chang <YLCHANG2@nuvoton.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,nau8360
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: |
>> +      The I2C address of the device. The address is determined by the external
>> +      hardware configuration of GPIO1 and GPIO2 pins:
>> +       - 0x1a (GPIO2=Low, GPIO1=Low)
>> +       - 0x1b (GPIO2=Low, GPIO1=High)
>> +       - 0x4a (GPIO2=High, GPIO1=Low)
>> +       - 0x4b (GPIO2=High, GPIO1=High)
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: mclk
>> +
>> +  nuvoton,dsp-bypass:
>> +    type: boolean
>> +    description: |
> Do not need '|' unless you need to preserve formatting.
Got it. I will drop the '|' in v2."
>
>> +      Forcibly disable/bypass DSP path.
> Why would that be hard-coded for given board?
Our intention was to use this property only to set the initial DSP 
enable/disable state during probe,
while still exposing an ALSA kcontrol so userspace can change it 
dynamically later.
>
>> +
>> +  nuvoton,low-latency:
>> +    type: boolean
>> +    description: |
>> +      Enable low latency mode.
>> +      Please note the feature helps sensing performance
>> +      but worsens power consumption.
> I could imagine that low-latency needed for certain use-cases, like
> realtime audio, thus not really board-level DT configuration, but
> runtime.
I will drop these properties from the v2 DT bindings.
>
>> +
>> +  nuvoton,anc-enable:
>> +    type: boolean
>> +    description: |
>> +      Enable ANC (Active Noise Cancellation) feature.
> This as well.
I will drop these properties from the v2 DT bindings and expose them as 
ALSA kcontrols instead.
>
>> +      NAU83G60 provides configurable low latency ANC path to Advanced DSP through TDM-RX.
>> +      To reduce latency, the ANC path only supports 48 kHz sample rates.
>> +
>> +  nuvoton,aec-enable:
>> +    type: boolean
>> +    description: |
>> +      Enable AEC (Acoustic Echo Cancellation) feature.
> As well.
I will drop these properties from the v2 DT bindings and expose them as 
ALSA kcontrols instead.
>
>> +      NAU83G60 provides Advanced DSP processed audio data as AEC reference through TDM-TX.
>> +      The AEC path only supports 48 kHz sample rates.
>> +
>> +  nuvoton,pbtl-enable:
>> +    type: boolean
>> +    description: |
>> +      NAU83G60 supports PBTL mode for mono output.
>> +
>> +  nuvoton,vbat-microvolt:
>> +    minimum: 8000000 # 8V
>> +    maximum: 24000000 # 24V
>> +    description: |
>> +      VBAT supply voltage in microvolts.
> This device does not have any supply, so how could you set its voltage?
> Plus, regulator bindings define it, not per-device propeties. Drop the property.
>
> Also, add missing supply.
Sorry, I misunderstood the standard regulator framework.
I will drop the nuvoton,vbat-microvolt custom property in v2.
Instead, I will add the standard vbat-supply property to the binding.
>
>> +      This is the analog power supply, provided by an external power source
>> +      or battery, and must be between 8V and 24V.
>> +
>> +  nuvoton,tdm-channel-length:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [16, 24, 32]
>> +    description: |
>> +      Assign TDM channel length.
>> +      The length must be 16, 24, or 32.
>> +
>> +  nuvoton,dsp-fw-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    minItems: 2
>> +    maxItems: 2
>> +    description: |
>> +      Assign firmware filenames for left and right DSP cores.
> Please use standard properties. This is the second one you re-implement.
> If there is one single thing which upstream kernel hates is the
> reimplementation of standard things by each vendor.
>
> firmware-name:
> (and see other examples how to write it - items: with descriptions)
Got it. I will use the standard firmware-name and dai-tdm-slot-width 
property instead and drop the vendor-specific one.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        codec@1a {
>> +            #sound-dai-cells = <0>;
>> +            compatible = "nuvoton,nau8360";
>> +            reg = <0x1a>;
>> +            nuvoton,dsp-bypass;
>> +            nuvoton,vbat-microvolt = <12000000>;
> Add the rest of properties o make this complete.
Got it. I will complete the rest in v2
>
> Best regards,
> Krzysztof
>
