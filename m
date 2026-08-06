Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1DAC56207
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:40:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C9F56025C;
	Thu,  6 Aug 2026 16:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C9F56025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786027231;
	bh=nmzijyFbb0U1VQ8qXzk5PkUoP5TirGh/vCj/nSrmjng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FSUwQeDp4zr6qaSygnSaxJWZ0Rsx3GvTtUO8SQcH7rYmEjuchTTBFXk6BtdBuTk17
	 TIBGrXSwPe27xE3ZXexZ3JMS4KYgzFrmE+/zLn5qzqVY229bTCtWhjNXFy43S2vC9g
	 UyreLU6yhdp9EW/OqAzAOY6DU+iV7evo/TBlB7V4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 850FDF8063B; Thu,  6 Aug 2026 16:39:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 068D4F8064F;
	Thu,  6 Aug 2026 16:39:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C85BF8055A; Thu,  6 Aug 2026 05:30:09 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785987008;
	b=GQvVqmSDbG17cWgwSzqciNVqyizgyKAyE+5yFVr1YaZ8LMQHE2vq+kAhZcIOQIE7tkax
	 NjLHInsJMehg4+b9Dn4ExSsgfY/Rc16MAcfeexDxezGTGZvLIEYEfWiv8p69vNb2gvltC
	 WggcGkPuNikcfkH2Sx0LTUKA30PHfNS/JI7yUzm+7ZqyCp7QImhYOzzfPPHvK3FPGzqaO
	 MLOxya66lYhUSlP1+CxwEE/oDd/bNreDqhk+ZQCXzH6JLQ37FWoKagdaN5qqLhPnXVZxT
	 hDqvhmRTNGLVcf+OPJty+1Moe3uVD9jD78C9+peBHNugZEFDpOb4d8vMmyfs0LLGZFQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785987008;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=nmzijyFbb0U1VQ8qXzk5PkUoP5TirGh/vCj/nSrmjng=;
	b=iEA07bQBf2BWGKRlsdwmH8fj6guhcmTN0wB2BgbLTxs+k03mWEzO0b0m1SpdmhuzupfL
	 j9XXflRcWGEZcuF2BOiK9QXIwov/JrTY1hx+sMGiwEEynusXAAu+DggSntgPQ0I/HKSeD
	 mx557kBM3A6kDhXLA0oY6xmeB2IIDWRDl9gn0ZLNrGRUVUjHHbWoorA8cy+2xue/2pDMA
	 927kXCvsUgg3gJuKS5MlXSmlpAQuVZZjgj+ff9UfhjEBrP9T2L8X5Un3orJh3arvFPJFs
	 1fOiHNEEOaXaT6Yxh/EHgkSnh8i+rgNuOQsVdFscvNw70hYqkUJa78Y0JfEX6kW6GHw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QluXlWJf;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26E78F800BA
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 05:30:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26E78F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QluXlWJf
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1898234a91.0
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 20:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785987004; x=1786591804;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YAXCryH4oh6nQIKuZN3/aiZHSgXb6KFeGAGvPh2FRm4=;
        b=QluXlWJfj3Jucovq1TxBRLnWdtFqAaJPYXPKWuQBm/OmSRe2ySjXqfjsiIaDwK9J2E
         4k4j/PxR1P6oKPfCcWKPXpb6Armkx5injVpJCEiPU58E7cXPC7ImFUhHaGitBJrOs0Pi
         I+LMgy24xwzQOImyXSgduC4tH8th0rHVB2xRIzM5ItgsWqxufiXOTsS8a4Dtk/BYt+bW
         xXFnrroPkAYmwCV6dr3ER7rNoB9z4P6GGvM49sK4kHxH4RigR88UOnurqoDpJzpq0tGN
         myoz9mtZnRj/NpN3CORBwzOjnxfUxIADAizFcg8uW6mJqE1wIsVJBA0pKerLcJP01yU2
         5b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785987004; x=1786591804;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAXCryH4oh6nQIKuZN3/aiZHSgXb6KFeGAGvPh2FRm4=;
        b=nNOsr2uPAKisiKxg9213B/CrUbY34bXtfVu/ZKGyjZ3VslhHU3PfIuHe/pCJsyBGXC
         ZDlRfk6ZAp277PripPBprMsY/nptKYGdlY5etEtFNWEbURsyAIvRNP2mrZkwrtja8KQx
         aUMu4Xpaac3gklxQro+7HBg0PmKPTbUqazxsGF5nG6ZyxqKwCYD/XlnY3bWcKoD6xx5o
         z/0TkISjRIB2roo3J7EaUOqGSwj0HKCT8yQAtlZeXClv5FTwzLfKaiMcPofQbOnMFNCr
         N/WnuUm0krZtV1hd3mLgQuWWOFDTnHbGhIii9HFSXKSG4rKq9Qv43k/v2uIE1h4g/sRE
         SnCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvhPHHH7Og6rtUKx9Gl96enU5My15iDWwbbKiqa4ypq84r8xQPOwlfcl4oqe07ucoc9lgqxBkzP5JD@alsa-project.org
X-Gm-Message-State: AOJu0Yzeepn6Xnjk8LoTNFFYFoAlrQBgcx2bfBQTvuPpbiePcRutQrP4
	z9PVB6sfVDVY8egaKgvYoxINy4awVvGfAAaeBefzbWaX3nTNN1BsUMSN
X-Gm-Gg: AR+sD12InRDvNdZ2Zh28OsYqbnYX5yupk+3wGFSidcWDU9lAnHNmTkTQeMsqPJckgxH
	rbpT3abcn+5tvhXLy0nwgn6eojENwzaGWE1R5RfS1gdKAdr6RLrK9kODoQp6d9s5pavd96EO4Wl
	Ds+s3i167As8AzexjZMk1eYWHMU0TjTqe3lC7kGZUsi0GS9goAPZfhQFhGIYZLPeD36OUPX8poL
	FToMc/jXK0L6kEPiu1jh0vdXqFyE9IwLUrg7WDDbqmzYC0LMUZbCWAu+Kd7dO0WkhyO86wFCnkk
	rBljHlWWIYC/hrVi9M6a+VY3tblEqG32dVxVc6LkKJO1s5JYrYFa2ugM9BlejVS/w46BhXogAF3
	P+jeEUboVNt9tne/86+1Oz41TWplgN0iRFiaTtv959MmIhvMlrCLrvQlT67j70rCbDFotXiB9R7
	RQGR82M3D7HSWPacimP9SLSdppaVNbm6ORLBu9dK5OgtvE1YtekiLJBsJAiyIiY62HxWXDQ05Aw
	/5v5FmEO56xgt56Ed33sHY3cjmNfmwYF+UmyqY=
X-Received: by 2002:a17:90b:3f43:b0:38f:57f3:4dc6 with SMTP id
 98e67ed59e1d1-3903c6798bdmr13404230a91.21.1785987004218;
        Wed, 05 Aug 2026 20:30:04 -0700 (PDT)
Received: from [172.20.10.2] (114-137-35-218.emome-ip.hinet.net.
 [114.137.35.218])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3903d2f9a9fsm2451155a91.1.2026.08.05.20.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 20:30:03 -0700 (PDT)
Message-ID: <4bde20c7-2496-8122-7e0c-4fd986a59232@gmail.com>
Date: Thu, 6 Aug 2026 11:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Mark Brown <broonie@kernel.org>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
 <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
 <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MARLOEU3SSMZD3H4CGUXZX3NFTIYQ45N
X-Message-ID-Hash: MARLOEU3SSMZD3H4CGUXZX3NFTIYQ45N
X-Mailman-Approved-At: Thu, 06 Aug 2026 14:39:27 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MARLOEU3SSMZD3H4CGUXZX3NFTIYQ45N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 8/5/26 18:30, Mark Brown wrote:
> On Wed, Aug 05, 2026 at 05:03:01PM +0800, YLCHANG2 wrote:
>> On 8/4/26 23:58, Mark Brown wrote:
>>> On Tue, Aug 04, 2026 at 11:29:51AM +0800, Neo Chang wrote:
>>>> +	switch (clk_id) {
>>>> +	case NAU8360_CLK_ID_INT:
>>> Usually we don't have a lot of fine grained control of the internal
>>> clock dividers of the device, things are a lot easier when the device
>>> just figures out what it needs based on it's input clocks.
>> To make sure I understand: Should we remove the internal clock IDs from
>> set_sysclk and handle clock configurations automatically inside the codec
>> driver?
> That's ideal.
>
>> Does this mean we should avoid configuring them via the machine driver
>> entirely? If so, what is the preferred way to handle clock fallback when
>> playback stops or MCLK is absent
>> (e.g., via PCM shutdown hooks or DAPM events)?
> What do you mean by clock fallbacks here?  Presumably there's some clock
> still running, if that's the only one running it's reasonable for the
> device to switch over to it.
Hi Mark,

After further internal discussion with the team, we prefer to keep 
NAU8360_CLK_ID_INT in set_sysclk purely
for clock source switching to maintain consistency with other Nuvoton 
drivers (e.g., nau8824, nau8825).
In the v8 patch, I will remove all fine-grained clock divider 
configurations from nau8360_dsp_hw_clk and nau8360_dig_sys_clk,
leaving them to only handle source switching.
Is this approach acceptable?

