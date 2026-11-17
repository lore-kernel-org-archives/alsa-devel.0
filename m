Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF60606A31F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=F0EJZ1DX;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sin5ZbNK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07A5560199;
	Mon, 23 Nov 2026 13:04:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07A5560199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435457;
	bh=UV7hJDCJNf9r7eofHbxJynsn0HA1G0sBnuhrFfpEf/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=F0EJZ1DXPhZ5l6OvR1ZIvGPJKOK60RPnWnxbLe431DamkHWffZFOE70q7piWkKsKZ
	 r4pI8km0lKbgpz6e4gENnXF2MaaWVVslknCRJSsVO/3z9tPP69pZsGRb0ewSFQOs4B
	 UARzq0eq8QmUc1AmyRqmrGIW1UwuyiipXIyyMKS8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E9BBF806AA; Mon, 23 Nov 2026 13:02:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 973E1F806A8;
	Mon, 23 Nov 2026 13:02:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18D9BF805A8; Tue, 17 Nov 2026 10:56:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794909408;
	b=XBR7HazwSn02p7/9hjtLhqE+8N5AZQscYPj3ijott/BrJHdaXeOu+O5+fHSVJdXaRZ3D
	 QfmXb4lmVUBsTjv+0VNrJ4t95bHC3zL1mLI81MRoGGNnPkxPorVQ/HHNYis6BabykeGzh
	 8Vp5G47PHS26iKW4mlD06UAZvZrSaYWshJiVMXIkNbJ00bFY9RDosp5HtkGQbacfBpDqH
	 rmBxQN/V4kWDimHfeN+20lqOI8Sj10Fqa1ZSZj3F0632ZCCm3AUXaehjkPnEHlH8ypMqK
	 P6xLhMtLbnrsfaUiswC9ASrnkU0I10T/e/82kD54FAI58CIeUCAasvLZJRZHdOzClUA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794909408;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=UV7hJDCJNf9r7eofHbxJynsn0HA1G0sBnuhrFfpEf/k=;
	b=IN2LRXiMvqznYxVeJ9LXvCtgjMgHapyFaKIUxlo9HgxqXdPZycX+UGUruo3E4TWUSj4L
	 DHLQEB5cY7aaM7Lpx6EEkrKrXjnJvf1Nn6K+M4X43x3S9K6MlQYDV7o6+QCyz3IHtnwam
	 C7E/DbRV/yZlG1Lhb2QaxDfP22ejs1hVCCPgMGyQkSxt0aDxYZJm9FofkAl3ecHz4eESX
	 tgtn6gmkYFzh3nwSE58+PmV5SorhZkF/6jF2w4OW1jSX73W6xdI6NSvarKciX/bWBUanz
	 axZ+9/6SIwS3qHsdzFLeG3v34J4JefES1hH3pFseZFMCeAHI2dvorI4CG8I74TFfBmw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sin5ZbNK;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6577CF80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 10:56:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6577CF80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=sin5ZbNK
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso26643125ad.3
        for <alsa-devel@alsa-project.org>;
 Tue, 17 Nov 2026 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794909404; x=1795514204;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzJ7zdzUB3cdGIuk2i9Y+NNhABXVFT8DILTBgFlRwyA=;
        b=sin5ZbNKmBgeHHso4q7i/h1nylec1YGBCmvr8+zJkrgtWbAc43s+rFwTDCDgKrK6Pn
         dT9BWYJg+y28wOYfWfKmXgbAcLRA3J3Kma5tCrQrsks/0vi7Df4iH/z/K8AYmB6ZKcjb
         jyO7J50nqjemhj1mzZzF/u+kusb0jKn5ewBBb7ACCUEcJgAOMZDwuZd14lLx2RoPXrcC
         gAuTLWzFLQmmx7mncqebuHa/3VJrMPkkNvjwBh/hS3VumRsCIoIZEbG98CPiSQE407jI
         QX8VtFBLS2Rr4h5HQSnxjiIWY9Y03zFppWE9qB5W4lgCXPPoOb4rtLgNjWbpRkvnUMqF
         3+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794909404; x=1795514204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzJ7zdzUB3cdGIuk2i9Y+NNhABXVFT8DILTBgFlRwyA=;
        b=HXTNHZWlHM3cOcRuR8tmqa4rfC2ZlULcjTFDY/hUn9Fh9cqmJnAY51RTPXthB/LvKS
         Pcws+52IK2xJHslFwTKJCkDjdWU0qpEI863+CMPI/oiqA1LGfbL3QkCMEP6sR3ByF4+F
         32zjY3MCIokmWxTCEsWJu7Exnoi8xr2mLDCUMY6impoiyY/p55vSUJr113eNMPApS1WD
         f16BcLTVtR5mV/vkrIKfeE2IP1PVvSeAjjltAf/io9dlzf0rUuczt8xl7dd5Bq1h65vR
         DLZNto20m/Mtdoyt3X8P1duRMluv8lzWINOLh2MO8NZColgfvxzxIq0iDJWvfgGntZ1u
         U5jQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGLXD0tfeqiDhBpqIDJxc9yKG2ifNb9vHZqiY7PVPIFtub69FPl7Xc0TRTfng4PrDgWYoxcDZMgOXax@alsa-project.org
X-Gm-Message-State: APuU4Z+8HYC0fY+5zK0QoHDLd0dAfyfpIAbvg21UZ7gT3w0QtPOpZZMH
	HEtd6dwAntEnd19HmFGhoMVLSR+aXP0dQQUlV+Gnvm1ycvFWSzHWWP64
X-Gm-Gg: AZFdTZeXHGEiwbndQokRUM+ixXYnGyqj9vwTax9I7MB6V4QsJ5zgSYRfeZic3uuraG1
	9Bhfk1vyiIasFDek9QudsBQ4ZoGzdzzL3cfhsu2W844xpqfjWA8W86j2P6oGkY6Efe69A47P+Oy
	1j/ozpNcvRF/OOZPoWykeoKBJaPV4t1EBWoIkpxqvldJFQ4u7210ubW4Fkiz4vr44KiMuzTB+nz
	F+BfpfX9k46De/ssx8A6yxAGy/zi1Y1ivgDg38ANA+pcguR31P/P3bvGFxvkNSVtChGZWKD9hZM
	J/SphuYKkZO2tTIGlg/B2OqO8sl9g5ubRtlmjBOvJY6ZmrKFmhtDaHAJ/XLd65HLcfaQ1jZXjon
	a817fZaq5dXsmroofWv/zB2LtmAlDtMntrIFcdMyKWziyyF+SmV+nV74ezkkcFUU0GJq+Yh9jMs
	1WO1EOjh2h+PNo48iZ1LYIJHys8FcyHO+A9RlWOycDxbB22TGdC69ZRAA1GUFUZxExAijF8MI1d
	tDykmmbXfdgyJkoDJs/k2t16qzrnp7IeJwL4DGfQEOYI7AxNoysKarZH+bpfWn6G/x/TAoA0g6A
	clo3zHpSWa5oz00BZtm3HJs7IKvHVzDyzVAjFZogsTpRv1DZHI+0oilFwBCC
X-Received: by 2002:a17:90b:17c7:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3b1b0ba4fd8mr14060000a91.55.1794909404192;
        Tue, 17 Nov 2026 01:56:44 -0800 (PST)
Received: from [172.20.10.2] (42-79-72-63.emome-ip.hinet.net. [42.79.72.63])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b39d73c9sm11164505a91.2.2026.11.17.01.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 01:56:43 -0800 (PST)
Message-ID: <5c4ec348-e0cf-4f4e-958a-f0c86296bf83@gmail.com>
Date: Tue, 17 Nov 2026 17:54:23 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 lkp@intel.com
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-3-YLCHANG2@nuvoton.com>
 <20261109-myna-of-noble-downpour-e09d3e@quoll>
 <6d7f4ecd-bac0-44d6-a704-57cdd2877729@gmail.com>
 <9078a957-c183-42cb-84a8-0f15661fd23d@kernel.org>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <9078a957-c183-42cb-84a8-0f15661fd23d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GHRWOWQBK5C6CIU656ETKXI6BR5LRCKG
X-Message-ID-Hash: GHRWOWQBK5C6CIU656ETKXI6BR5LRCKG
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:14 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GHRWOWQBK5C6CIU656ETKXI6BR5LRCKG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


On 11/17/26 17:28, Krzysztof Kozlowski wrote:
> On 17/11/2026 04:38, YLCHANG2 wrote:
>>>> +static void nau8310_i2c_remove(struct i2c_client *client)
>>>> +{
>>>> +	struct nau8310 *nau8310 = i2c_get_clientdata(client);
>>>> +
>>>> +	cancel_work_sync(&nau8310->load_fw_work);
>>> This looks safe, but still error-prone and discouraged. Use same order
>>> of cleanup as order of init/allocation in probe.
>>>
>>> See also include/linux/devm-helpers.h
>> Got it. I will use devm_work_autocancel() in probe instead of manual
>> cancellation in remove().
> To clarify: use reversed order of the cleanup, obviously, to match the
> probe in a reversed way.
>
> Best regards,
> Krzysztof
Hi Krzysztof,

Thanks for the reminder. I will adjust the initialization order in probe()
so that devm_work_autocancel() is registered after the regmap 
initialization.
This ensures the cleanup follows in the proper reverse order.

Best regards,
Neo
