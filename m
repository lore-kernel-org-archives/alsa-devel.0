Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7EC43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:23:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D609601EB;
	Fri,  3 Jul 2026 19:23:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D609601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783099427;
	bh=0up3X3VC2fr+gRB8uZHELvWzcZQGMYSNttjEbLvtUGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pgCEF+NtK9gOGdmpMt7IGzsF/cb/dj097cMsDS0as3UbzwFVzUyWZ5AZWAEGBfcq0
	 ISFYaQ6jqdaCHn2PX1q20Dt7ccioaNPUExAzuAbAc05voSNpigrdaS+pVuWaxb2lzp
	 4+TfrJw2DWS+1AEVf7sdUWbqdD0lR8YZnc8MohuA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C906CF8011B; Fri,  3 Jul 2026 19:23:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75D35F805FF;
	Fri,  3 Jul 2026 19:23:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE525F80579; Fri,  3 Jul 2026 19:23:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783099398;
	b=eVzgQRCxAGHYmjeRIBogaZ4gsqS1gRBWh21k9eAZbf3Za41eBZGOFG7empbzTBY6RCe6
	 UtZAYXEVPkKFgNDKJTLbXNEjVggejOJs80TiGgiiR6k6rKvH/8j/COcHNfgPulwk28vB1
	 yRs1/MEnmVRlqoiOLN+DJeVLlSx13ObwKJ3lhlqokmFj+9DNDlL0LDPr0GwNYhMXt48wi
	 hlOLZxz6tHSvQhsdONgQxnFapjqbD5hD96YLSLexn3VoW7omnLTo9fpb9e+TIOOouYYk3
	 zo2RBILU8Bt2+BJVDImvf9eXXwPwcvSI90Uw0SvGwUmVHkzqffULDLcGce7B8E6h5ng==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783099398;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=0up3X3VC2fr+gRB8uZHELvWzcZQGMYSNttjEbLvtUGc=;
	b=F7xgKl24Skd/YFS4Q6fj/dV/P4LoQ7I4pRiJrEwBsBXxMav8oDhVBrWm+hDg5y2YgdXA
	 euYWGXUSCqI+fi86ii0/Tm86TDO59ZNol7pw1R9/knPdwoeQRF0zMpJtWhFZ0GH+IxMLJ
	 f61KSCo7C1sok8fUTBcTZZxZXh5A/RskE9iVsZ+cwZVY+Sp+0U2N9bVqSSpVf5r61YSSH
	 ORhxo5ort1pguYq/qLF/h86/80M1eWfwjpmhzWbIoUlfW5f7gNcNvNac5+C79GZrCno5d
	 Q6jja7P7V1J8l2noGD1A3ovIxXSmAdJaVp8HhuCL13T24sYXoQMnvkiwCb9dSXHn+QA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N8lL0K+1;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD50CF8056F
	for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2026 19:23:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD50CF8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=N8lL0K+1
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c125fbfbae0so74807066b.1
        for <alsa-devel@alsa-project.org>;
 Fri, 03 Jul 2026 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099397; x=1783704197;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mBESswN6Y8XsXKSuHEiEMpM0MOv1RPEae5qTrECTOF8=;
        b=N8lL0K+1UMDISGRFkKzzGXuXQSk2mEAZhQT8WSypSqnDb+km6BtjIuyLI894IqUuvb
         nEZNBGBNjd2ADswdIcUz9IgwevQwrLGzUq4vPP6PSLolnVpojBU1gF4OGKpDU1SyQYhG
         q86ARw1lbJ+FT2PY4wIqgBrfEwec34gBTmKTAou9UGdioDbPSa12mJg+tv7gfqz2SHcd
         WZ9fVVx+7JsAEdJe4abqwFBrY3fVpax0OYnXW8IgBbAoYePU1AKbyKDzQ90Iz7uTIyVO
         2UoiX1XaM9Djfv+3jE13UCPv8AK6XV0fOWJiV00FTG7T2Is9xgJA41vmfN6l6UdVmqzQ
         iCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099397; x=1783704197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBESswN6Y8XsXKSuHEiEMpM0MOv1RPEae5qTrECTOF8=;
        b=nOoixdGAPx25yJD0xmy/HHfviov9w7hiKhJfBG6dlykyPPZodIdHba5zPAtW8KgqX2
         /CaSWyzE17xoLOCisZXs1y6lhe8QXdYAecDygkTdUP+RMF2aOnhfs3PaTZT/fx9bAbsb
         0zJLxXFBWmnQj/mxsfC2MoxZG+AQAwk99SLXk9MSDJvwgM/0Xj8yCVZ59Gxg1jjJJs7L
         kFedqqrQ3qji+nhEt/+ABSo+eFoJ12IzifK62EF7YrAzNuoJwux6s3zT19mhdQ5j4Aiq
         RxJZwHUApbId3b1swKsp5KP3C9oiITEQ5y+a6dnI5TNhOoDbRefhj3drFAJm+cSmQ6ej
         aQ5A==
X-Gm-Message-State: AOJu0YzNMdAtolg8xYN+nJ4+bYFAuC9+9PiWEhFeoOjzqDUsT2XKXYmi
	iRzokh0BuZlLaQMaQqS87pEedyHRpu/b3AtWpBQ4Dk+8dr8VRjSpOAiB
X-Gm-Gg: AfdE7cm0h4DfPDZWoNoL/py5sKADzKr1Crcigb4q3jqH1Xm7JLsLLV0a/ABubUr4bGH
	Hf7xeaRKZFyb0J6t2eM1joeh+9VlLW5bnLXbf6ku3ngguO1Q7kTXW00cBSVKD2XHXEBGfUF9aWl
	/a0+HAU3CgbDqNpxx1dhoJL6OmcCaVBEsbyKDOnTnw7/GlEop+l4sQ1ChN+f11KbPG0PHBqvybh
	1xeHjqcAjoO4tdLTiUknM1oqmz2TPytcpZoNI534AowiBLN1nclZ/msHbPEoqYkK9IwoAr64xmq
	PRFHXan4s14trntLRB44dPbchVwBoVRGU3++FPptWiJfb7d06E4MAK2DWvSmR/sbCTaVPukA8Q+
	lAyUJxNKTdajz0gAfq3JOI1j3+ApTFxORPffDkAvevOGvrvaNt/365SH+VXEja9tKNXMn7F2GfU
	aIoySs6sivlJI375C9ZuAFeiwMjR5CV1N3fY+rFb4ClFIouroNs4J/O0wWWd2nTFxIRi2MELnhc
	2TWR+4cviF03ESROCw=
X-Received: by 2002:a17:906:c8d6:b0:c12:78fd:250 with SMTP id
 a640c23a62f3a-c12e43e1ed5mr18000066b.59.1783099396668;
        Fri, 03 Jul 2026 10:23:16 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b628d632sm308123766b.31.2026.07.03.10.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 10:23:15 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <cb450caa-58d6-465b-a694-bbca3949e3be@gmail.com>
Date: Fri, 3 Jul 2026 18:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] ASoC: SOF: amd: add base platform support for
 ACP7.B/7.F
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-3-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260701095759.1012929-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: OHMBCJOQD4BVMDL57BJOIFVJO3V6LZ76
X-Message-ID-Hash: OHMBCJOQD4BVMDL57BJOIFVJO3V6LZ76
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OHMBCJOQD4BVMDL57BJOIFVJO3V6LZ76/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Vijendar,

On 7/1/26 10:55, Vijendar Mukunda wrote:
> +++ b/sound/soc/sof/amd/Kconfig
> @@ -103,5 +103,15 @@ config SND_SOC_SOF_AMD_ACP70
>  	  Select this option for SOF support on
>  	  AMD ACP7.0/ACP7.1 version based platforms.
>  	  Say Y if you want to enable SOF on ACP7.0/ACP7.1 based platforms.
> +config SND_SOC_SOF_AMD_ACP7X
> +	tristate "SOF support for ACP7.B/7.F platforms"

All of the other config options in this kconfig have a line of
whitespace between them, could you modify SND_SOC_SOF_AMD_ACP7X to
match this style?

- Julian Braha
