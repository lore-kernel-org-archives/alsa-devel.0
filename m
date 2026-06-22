Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFB4CDB46B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:45:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8884B6026E;
	Mon, 22 Jun 2026 09:45:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8884B6026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114315;
	bh=k/jKiLG5T7SlsMN6SZ5eXOClaqTNEE4Ub90SlxnqtLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pbyBfqwPGp1KiboOPgue//EziJ6xQ4rYknQaCFlUbOcZiVwTg+cfZI0bjv6LETn0Z
	 kw65a1gH/Ya/UQIV4LIzn5fl1unFaXxxbF2JnPjats0NcWIGpDAiklT0qDECHgsk5T
	 HncdQkgejmI8lw+qpppF/BbxVSGFKmkCOfWDHo3g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3214F806CD; Mon, 22 Jun 2026 09:43:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58CF7F806CA;
	Mon, 22 Jun 2026 09:43:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93248F805D3; Mon, 22 Jun 2026 08:12:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782108769;
	b=VsigPKio/jiVMtXguA+ksv/vm6JvQMAI7CLZJHMBoybIq7wQHnYt0xJ1DYDwDcN2ZE5H
	 SS6B9ljIeCV+FPjtcfvK7qmm7urC0GCSlAWOJKZuAVEcGw+p6hqWPS6llNyzCnjf3yjsq
	 1LVkI4qfAOClIXU4FXCE/inR94P4M4DzU8OfhZ5aq1XGXHCVtwSkY0s9XH0xU5Mhq3/VB
	 lP1xvVp13R2di8PlHDhXxdYEwvCKzoeOHfJVsb56joo8aYkfsDr+mt5zMgcQC/dR8PreV
	 SIVxgj5HX1KfhBx8xDi6tgFSixClm5nA/0McA1mqhIknwOcVXAF2sKto8tp+tlqc+qg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782108769;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=k/jKiLG5T7SlsMN6SZ5eXOClaqTNEE4Ub90SlxnqtLU=;
	b=jIELD5He/CXcBxjkL85Y+G4GQTO2jri5w057ng9F+DTUe1E3f1Y7hXV/c0biTTJMHfof
	 xm1f/33vze4XyfI5boFvJqrGOeBGCr9xrs9tMakFKEEtSfM8NcFBnGHUmR1GHHIcXUDgu
	 Nkgh3Nufy/NvZ+FP75YUDWZHHkrVlIn8UMuOSD5s3OG+VXTKoVPXitQvwyD3LHfXtAXDP
	 7l6VoVTgflt7dg2THmFBYDU7UyffVH5HEnw45TywOUJZIfTyiGawGSevYe0ajETJsQ0xB
	 27Pp4UqVvLSNJ1JLg/Btg4fXrN+EmUKxJyUN9lEHEtKPnSMGojC4X+C4NP1yTCEmSiQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L0GjTcQG;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 45CDCF805C4
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2026 08:12:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45CDCF805C4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L0GjTcQG
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8423f236418so1947465b3a.1
        for <alsa-devel@alsa-project.org>;
 Sun, 21 Jun 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782108765; x=1782713565;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UYItOtv5cbHbHn81xG9uaSAtTwXvVojgVomA6lyfc4=;
        b=L0GjTcQGcHBFeVEfk8XmkZM8hYR6eOT34tlP8Q1zJaKPcrNfchW6qK2sNSqwQms1zZ
         PfB5+N+5fW9pDnYoc69CnYijz5gVoqoaKfapLGkwSf4aJlWGLQ3oPTSB1ONT0KGVIvuf
         M5kW+SkpIrpxoefBpCtHVnF0zQRPZ1shXupgVhUATrKxpESCeCAciCjDuLNOhGu2CXO9
         sV9Hli2Pv3P0u2vTB6v3Phn9W+bG6fsvAmt4lKfFEclXUdbI58yDYLDRfbtESQ7b8Vuk
         cjL2roxUa6uJVQj2z00u4Y8cVKAHungsJj0jKcbHXaVR+2PH+Fp2Wyt6GjVkj3dxp1x2
         QhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108765; x=1782713565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UYItOtv5cbHbHn81xG9uaSAtTwXvVojgVomA6lyfc4=;
        b=bGskwL0KxDR78IOmtFJ/m4y795WWy3eESclvbJ7ZV+gi/r9P/Gj36mqbnGUhFUSnPu
         cDcOQ6WJ5WN1xNK/pMU0PB88eq4Yt1uBfpX6FSQgiiWKskhXvDlApYb/iucy2fJrG00p
         Z3wP1+tZ8RTLMmfU356ym8gSuVNGYOspzeJUqfJroV/k/ujT4eGohxB8E3sHU8eNqGJI
         ur5s7m9SK87g2BB30azrqaG43C/S652NeyKweTx573WyFG0u4VCmIlKq2sv9IMdbllg9
         OZQXgAs2G+Qg3Ofr3lmwdGqQMgqeI+TjuiXbqfxRlTtx5tORoQNFnHp1g0RfF2ZUYw21
         kLSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cFdYWJs93OoIFVyiwxVH/SzrzOi7zNXCus66I0zS3s02tiqPl2ze9euXTBMBJsIEJOggOIYUVUh3r@alsa-project.org
X-Gm-Message-State: AOJu0Yxj5S8TA89RxkN4LKWZkjp399CSpgYWo0de31LJIyE3AWmB041l
	lfpLXaSrdW1y/Vm1+ey9VMjneKbt0q1ymEdxSxW1gEI3QfkQ+jwljvLB
X-Gm-Gg: AfdE7clq1uI8aT3T7jt+vg+Oghbno/FiX9yA77VIyCKje15A+YnK+c4rp5ucQj0NxOd
	Qey7UROOk2BNkGVaXHF6md9mREn2ekZ6GL35P3J2gaCq9Wmc7hI6s9cBHRYuQoygsJ8Vzvu38Qk
	+4n8g4HVbDYRxcG1U3ZZeh19hPI8vFnjjvuauuKzXdMziuoifZwFST2vBZpKF6DqfAT6/mipn6l
	tzX1vGT2mVktf2uME/x2XnqdJdHBG62PDU2r5IIcvSiVn9cftEOQWP1vKp9AbT2sInqRYlufrMO
	a0Atj5YZzkwEUO++Zv2AP6DoMetS41rCcZumE5Fz4l5ieHFHQf04r49ZjbN5I1vrvh90ZQUlMs8
	5r3vKC+laWwakPok0T+HGHgfkOpKLmeoWw6WYiDYWwWHkpmZQddsEbe3JI8DeUbJa7qS5kS5OAt
	05kW51ifPj9KFFaOi35dSROMM9MjF1zG8Pqs5Z/UqYU0AOCtOjpzEXCws=
X-Received: by 2002:a05:6a21:a395:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3bb34e6a0cfmr14815480637.39.1782108765381;
        Sun, 21 Jun 2026 23:12:45 -0700 (PDT)
Received: from [172.20.10.3] (42-79-6-161.emome-ip.hinet.net. [42.79.6.161])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc5ef74ecsm6497888a12.29.2026.06.21.23.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 23:12:44 -0700 (PDT)
Message-ID: <cc417a12-a327-e63e-020b-00650a22d6d9@gmail.com>
Date: Mon, 22 Jun 2026 14:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
 <20260609024128.585938-2-YLCHANG2@nuvoton.com>
 <20260609-hysterical-rhino-of-resistance-d7e1da@quoll>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20260609-hysterical-rhino-of-resistance-d7e1da@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UWSU6Y25UPYQC6DPKYMP5HDLM6JASCKM
X-Message-ID-Hash: UWSU6Y25UPYQC6DPKYMP5HDLM6JASCKM
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:43:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UWSU6Y25UPYQC6DPKYMP5HDLM6JASCKM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 6/9/26 15:04, Krzysztof Kozlowski wrote:
> On Tue, Jun 09, 2026 at 10:41:27AM +0800, Neo Chang wrote:
>> Add device tree bindings documentation for the Nuvoton NAU83G60
>> audio amplifier.
>>
>> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
>> ---
>> Changes in v4:
>> - Refine the `firmware-name` description to clarify the loading order
>>   (Left then Right) and the PBTL mode behavior.
>> - Remove the "dsp bypass" option description.
>> - Update the example node to follow devicetree coding styles.
>>
>> Changes in v3:
>> - Remove colon to resolve YAML build warnings.
>> - Fix 'firmware-name' property definition to comply with binding schemas
>>
>> Changes in v2:
>> - Dropped the word "driver" from the description.
>> - Removed runtime/software configuration properties:
>>    nuvoton,low-latency, nuvoton,anc-enable, nuvoton,aec-enable,
>>    nuvoton,vbat-microvolt, and nuvoton,tdm-channel-length.
>> - Added missing "nuvoton,dac-cur-enable" property for static speaker impedance matching.
>> - Removed unnecessary '|' formatting from single-line descriptions.
>> - Fixed typo in firmware-name property.
>> ---
>>   .../bindings/sound/nuvoton,nau8360.yaml       | 83 +++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>> new file mode 100644
>> index 000000000000..2d19aedf1419
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8360.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton NAU83G60 Stereo Class-D Amplifier with DSP
>> +
>> +description:
>> +  Stereo Class-D Amplifier with DSP and I/V-sense.
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
>> +    description:
> You want |
>
> Or this could be just enum of addresses, no need to copy paste address
> decoding from datasheet.
Thank you for the suggestion. I will modify it to an enum of addresses 
and remove redundant description in v5.
>
>> +      The I2C address of the device. The address is determined by the external
>> +      hardware configuration of GPIO1 and GPIO2 pins.
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
>> +  firmware-name:
>> +    minItems: 2
>> +    maxItems: 2
>> +    description:
>> +      Assign firmware filenames for Left and Right DSP cores.
>> +      The first firmware is for the Left channel,
>> +      and the second is for the Right channel.
> Drop all above and just list the items with description
>
>> +      In PBTL mode, the Left firmware is ignored and only the Right is applied.
> Combining also this.
>
> items:
>   - description: ...
>   - description: ...
Got it, I will format this using items and merge the descriptions in v5.
>
>
> Best regards,
> Krzysztof
>
