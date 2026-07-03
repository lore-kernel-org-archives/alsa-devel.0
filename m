Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E384C43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:00:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 392F0601F2;
	Sun,  5 Jul 2026 12:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 392F0601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783245628;
	bh=W1AVsX43qvUOKE59T/ObWlrtbrXrPJZCWiEaPeSDmIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=t03/Sh378FxSJuS3afpxGfBSmkF4nVpMYaYPT61W4k1RtIeX7NN9rTnIGI74lpFPI
	 k/gUXstK5x6dQhvfWaLsLCtVs3snDG95MB4OJIAdxGBwVxstqGVzGSt7KMAyl02VyY
	 KfVLexhw7wjoNW8sIzwquL3NHw/BHgyXSYeuaFoA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14AC8F80602; Sun,  5 Jul 2026 11:59:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE116F805FB;
	Sun,  5 Jul 2026 11:59:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22BCEF80579; Fri,  3 Jul 2026 05:22:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783048920;
	b=Ewbx2N4hjWkm6sXF7H9IwCmEhwGR0Yl6GJUN53vcIjhgoPTQVS1BTJk02pLpS4bSyfTp
	 3j/Om+GxcCccGMtIzjUOsJSF2HoPQmV3HAMyV7xekguS3HvFd/H1Wg/f2bwvHJMoQ+Uc2
	 i9zrfRuxpgNahXoWTOVCM1OZDX3Ryb1eqaZ7dL+rGD0hF35IpJu+3LtDNn42869siTB+t
	 QiDcx6aFUdcvG93d4CW8JwqeWv6kE4hAVVZRVn0lLFjSg2SKAJom7PabCnz1UN2wpbfIj
	 O/EifWnVTxxJwoRPtNSdtYXcNP5vZgm/lBFrAxebI6JRmeQJ66B3o4aluoCnDGcDiWg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783048920;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=W1AVsX43qvUOKE59T/ObWlrtbrXrPJZCWiEaPeSDmIE=;
	b=NVtZtDBIzBoRfcN6mABBElbvZNFW6ICynvrYS0bhUe3gqdw2A2QBOurR97Ez8wZCQoBz
	 efwwpz8aptAutjzPy8gAD/bqxc8A6CoJKssGW4tieJyBSZZkNNuqezlYmNug7WUl8Z086
	 HFVdPNttwjjFRajshBi6bb1WhfMoD52AIbnwd6OvCfhDqHlp7TUMK7YXPuGfQ0eclDqhu
	 cttzR9JI7j4i8ggMUgPhTj29dS9wwadiQc7ZgQBHZXkjogtl1XNMPkcpbC1lBdN7tjA7l
	 WjE5D+SUDtFRKCEdgQTobLyQF7vQ7JYtETRROjPRoQ0+cHSdTASNa03vi9KcuyJVJ2g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H0aefUlE;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5DDE1F8011B
	for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2026 05:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DDE1F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=H0aefUlE
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cad225673bso725985ad.3
        for <alsa-devel@alsa-project.org>;
 Thu, 02 Jul 2026 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783048917; x=1783653717;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQK9xIpBvupQsHfdWBTAzhnaT8sAOZBQ0zZR3EU2+EQ=;
        b=H0aefUlERTBWeG5TUhTKYta0UTk+EqjVjoZARN4VDDDrznxC7cACI8WLNQf8CPKUiL
         CcV3sgkJRPyFs6wUZPB6yKoUN8eyyNbxkQjt3B8v4of6BbmZUxsZfvE2N4r0pzNvytRj
         eAV+3FwGzdzevbaL9c4GMs0hdLmxHhmXRaP1+UOSMUiN6TkIczDE/iOIuPI/FOWKmNvu
         g1UtjOL+eYsNfWyP9ejrDgCJEUK/v5mkxBIXdNpDimmBzyGmExUU/KyS8YPlf2R/HulD
         8X1XAyjVGo15FT8OCjDNetrUJVyOPcxTOgvvocTAwO32MubXeZ+du5t2dBUXoYdT5yQD
         T9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783048917; x=1783653717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQK9xIpBvupQsHfdWBTAzhnaT8sAOZBQ0zZR3EU2+EQ=;
        b=c8X3CSsv/QSBShlFeYzhRkhs+n+AI251V5OHQhtn/FdPiUu0ny3RAcndMvb3YpPZjF
         CMcPGlP7IGTQePVtaxHZEqN74vc/WPqlcdtyoZ3c6OqfEjPRCMoS2DbN2pKzvrGCOxGt
         W68GhM06MUeDSSNMvP/0VgEn/qvF21DZvkeQiuKGxuU0J7tcr4jJHwhTn8nJDOxXXRTz
         xT4inKFK7zCwS4286/mu+bmjHPm8Y4wex6GOCKCOs/y8Nu2WMUSg85jkS450+tKsu8Ef
         5V86TDk2Mp5AupSuFOoeqZGnodIFvupeg7TjZWyXiD3OiG54hwAu8aZxs3JheXZsL2oG
         gRiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV05eE3BNxcVrM1xeIQdBAQkwVbnReBsu8b2PbHnt4oTxz3cMX5GfwkHFeKVASBN/73bkRoKGIGrPl@alsa-project.org
X-Gm-Message-State: AOJu0Ywj4YJ9eYUvZNcAByTQHDQAz+eofqSsMINsLexVnWSdiN+mil7F
	12MJn/Rda3WGFRaS/CgkopBOO9ayBkT950TUT5Hk3OfYfmfGNPYjhZ4k
X-Gm-Gg: AfdE7cmnHq4/yawU3CqN5nLPB0BTRQn77gFnqrx7JxIRy02RVHWniCoz7qTlFw3Dayp
	QOxYmgHDSSJEUNsEzHapfhgQhhVUcFJ8+IqpVlX6kS/I2bQrRwM192H5BXHqOqTnnf9lmAM9taT
	VvdxUu4KOE8dVgQz7sEGlgqO8J00luo65Eb1L3dLiNL9iXR3gTgsdmZSoMSxeL1hPpp0QUTaYuZ
	DP1/IykKN/bX3+iXTMLNcQcOtFKffEZ2ifwCmF12/YqkLJDuZIuaiXvm5Sj+hlbEbvrUGXdD6A0
	f7tKWVqmutY4NYtqcjciaUSAk370+rEZSOiozERBcv5faBpZr1mQjqkVu/nBg4yq+X7qO957gjU
	FY2f9ILI+gPVlJm7Jt5Uy9WhZtNNUj74KO/TGpxvcIr2EyGO0sDvuRrD8Zcl10iqjNy3qfw8VDL
	vBcp9uwqId6iX7ZOV4o44Rd3irRmB/M27WoLvuPqHmAzz2BMkL0g==
X-Received: by 2002:a17:903:4587:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2cad91dd58amr5101685ad.10.1783048916866;
        Thu, 02 Jul 2026 20:21:56 -0700 (PDT)
Received: from [172.20.10.3] (114-137-82-69.emome-ip.hinet.net.
 [114.137.82.69])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7129996sm2255035ad.21.2026.07.02.20.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 20:21:56 -0700 (PDT)
Message-ID: <36760b24-8620-897b-e52b-5be52aef3fd8@gmail.com>
Date: Fri, 3 Jul 2026 11:19:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-2-YLCHANG2@nuvoton.com>
 <20260630-amusing-striped-urchin-d49c93@quoll>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20260630-amusing-striped-urchin-d49c93@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HIWDFFIG4YRVYDR6DK6N4OJWFZP5VMPG
X-Message-ID-Hash: HIWDFFIG4YRVYDR6DK6N4OJWFZP5VMPG
X-Mailman-Approved-At: Sun, 05 Jul 2026 09:59:47 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HIWDFFIG4YRVYDR6DK6N4OJWFZP5VMPG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 6/30/26 14:40, Krzysztof Kozlowski wrote:
> On Tue, Jun 30, 2026 at 10:15:09AM +0800, Neo Chang wrote:
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: mclk
>> +
>> +  firmware-name:
>> +    items:
>> +      - description: |
> Drop |
Got it. Will fix in v6.
>
>> +          Left DSP core firmware.
>> +          In PBTL mode, the Left firmware is ignored and only the Right is applied.
>> +      - description: Right DSP core firmware.
>> +
>> +  nuvoton,pbtl-enable:
>> +    type: boolean
>> +    description: NAU83G60 supports PBTL mode for mono output.
>> +
>> +  nuvoton,dac-cur-enable:
>> +    type: boolean
>> +    description: |
> Drop |
>
> There is no formartting to preserve and I did not ask to introduce it
> here. I commented in completely different place.
>
> With these two fixed:
Got it. Will fix in v6.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>
