Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D47EE49A6
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 11:14:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4250A4B;
	Mon, 21 Aug 2023 13:13:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4250A4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692616458;
	bh=Kx62LHHtbWjND+R0QizzuLvnsDusBoDCapCTBYP0IrE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NcH+2rdEo2FNBa6M4Axsx6tJOqu5MSnI49sq3xoJNZLjo7DGx25EiQ8sHuYF7yera
	 LdcxfGi7R1Ka3RUchsZTZfyYKdDdq02XDqKuQwyLIXFrXAExM7YcU2M1xJDY2NPQPS
	 acCOW3qy/BlqbIBV5njTV2srbDR/Wd2u8j2/vdoQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1B4AF805D6; Mon, 21 Aug 2023 13:11:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15475F805D8;
	Mon, 21 Aug 2023 13:11:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D2A2F8016D; Thu, 17 Aug 2023 12:37:55 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BE0B0F80074
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 12:37:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE0B0F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=WtvU9jkb
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe3194d21dso13873705e9.1
        for <alsa-devel@alsa-project.org>;
 Thu, 17 Aug 2023 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692268666; x=1692873466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOv4AjjAmeKOZhxK2nbSn5/iga2jT5N9Acbkybbjk/g=;
        b=WtvU9jkbXXXaFnyWGUwVjoGntfuKGyfxJrX/GU7zhx7aGVyDxB6kaB2Mvtq9GNPAiP
         UU6mC+QTcCXJxqlonV9TlI50n/lUibAQ4KTcQjuATxGLEli5N6Apwnb2j46FdgmTbxqU
         S11BWJNFWBLUZr6fmiyH7+tHnU2VxrLA05o+PyEQgXsM8PsoxaKJvhIjiILPV5AFfTu+
         pobKQOc/pWs3MbBR31QyGwMpgSwdLA0B6S40UBtOLajBqJRgMsgFvf0K/zeh8uxQojLd
         dNTnd8fc3jWVT8Nfkn6vgU+ZBaelVIETMJxfktMMjVRaWGhlwGNaF3301gaMIw2E7hGe
         fEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268666; x=1692873466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOv4AjjAmeKOZhxK2nbSn5/iga2jT5N9Acbkybbjk/g=;
        b=hxljzhQ3PibsfwVMMJQVB0MgWLlKTQlADWiwI31yjbOb8qXqa/fgkBlsKm0J+ooLMj
         w2vhdlblq1yls97/GGfDxt7y+iLkVj1zgmM1lf0vfor4h2k+IG6KY4NGqv8K0knUuJyc
         hojxjH7N3L2ZDR1fLIdZ24ijjPrRN8dYl7qh+WNiSyWxeTEQhvKQ18jebH6rSRNargbI
         lZ6TVkgkjsIzGW3x2n+kZdDhNdtNklS/ipKbxk1IwnSm2hqgE/LOjp8rHgCGp+LmsBva
         LCKXD7Yt7Gc8a69guUUIA421Vh2FXzpPQ/tYbAilREpoviDvaFcn0WZ1smG25tHDMu6r
         Oqog==
X-Gm-Message-State: AOJu0YxJVUWD5FX7mbL84cWfEjoGEsXhkoo5ZF9X6JjhFBTQWwQjNmMA
	Yb0Gw6ATMRpYhUi96vFzthQ=
X-Google-Smtp-Source: 
 AGHT+IH1+JxKwbYWYEpWNtQshOy7vmwyAvQ07N8VSwm2I3kDT4ulMaB638BmWJ1G/c7vPvYJxzUYeQ==
X-Received: by 2002:a05:600c:1e09:b0:3fe:4d2d:f79b with SMTP id
 ay9-20020a05600c1e0900b003fe4d2df79bmr3771875wmb.4.1692268666307;
        Thu, 17 Aug 2023 03:37:46 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id
 n14-20020a05600c3b8e00b003fe1cb874afsm2640361wms.18.2023.08.17.03.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:37:45 -0700 (PDT)
Message-ID: <0d412d0a-c84d-1f13-60c7-5551287638eb@gmail.com>
Date: Thu, 17 Aug 2023 14:37:44 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next v2] ALSA: Make SND_PCMTEST depend on DEBUG_FS
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, alsa-devel@alsa-project.org,
 schnelle@linux.ibm.com, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20230817093740.1732738-1-ruanjinjie@huawei.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230817093740.1732738-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: ivan.orlov0322@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: WT7BHQYU6UNXWFSCQGXBCG2SX7ERCEX2
X-Message-ID-Hash: WT7BHQYU6UNXWFSCQGXBCG2SX7ERCEX2
X-Mailman-Approved-At: Mon, 21 Aug 2023 11:11:03 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WT7BHQYU6UNXWFSCQGXBCG2SX7ERCEX2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/17/23 13:37, Ruan Jinjie wrote:
> Since pcmtest is a test module that manipulates or gets
> notification via debugfs, without DEBUG_FS it can not work fine.
> So make SND_PCMTEST depend on DEBUG_FS.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - make it depend on DEBUG_FS instead of dropping error check.
> ---
>   sound/drivers/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
> index 41c171468c1e..6debd8e95cb7 100644
> --- a/sound/drivers/Kconfig
> +++ b/sound/drivers/Kconfig
> @@ -111,6 +111,7 @@ config SND_ALOOP
>   
>   config SND_PCMTEST
>   	tristate "Virtual PCM test driver"
> +	depends on DEBUG_FS
>   	select SND_PCM
>   	help
>   	  Say 'Y' or 'M' to include support for the Virtual PCM test driver.

Looks good to me, thanks!

Acked-by: Ivan Orlov <ivan.orlov0322@gmail.com>
