Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C6BC2BBCA
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:43:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDEB522AE;
	Fri, 28 Jun 2024 10:42:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDEB522AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719564181;
	bh=r9/2elFYnoxM2mwS8pLdiixRoCcTB/Nu6twSfevvkBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MvTFDiq06/0kTlZGMs/yCEJS0u4wgcJoM7HMgkIVzK4N24z0sbbEW9ZAvRECQtbJo
	 mf4fo8wn89GhPRa4mJyyNHlqLuklkjWqNR9IhWN2RJ4I8qU9BHTPH6mEO4cVALE9rA
	 6NgKSbx8COzti47/Kod3+PDU4JifNSRHrA2ROhZ4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2906F805E8; Fri, 28 Jun 2024 10:42:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39FD5F805D4;
	Fri, 28 Jun 2024 10:42:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2E94F80495; Fri, 28 Jun 2024 10:39:23 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6D58AF8016E
	for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2024 10:35:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D58AF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lZW5nmxD
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso3128601fa.2
        for <alsa-devel@alsa-project.org>;
 Fri, 28 Jun 2024 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719563725; x=1720168525;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNolEEmkU6Ry+wXWBxbsl928QObWZnXzUE7LPASxVTE=;
        b=lZW5nmxDUd6rgAt0+/u/9WcmbpZcOVcc/rjB8MRVeS171UiwgLTVOb4RqNJvZdoR4m
         hdqfL5cNkR7Zo2N17Ju1eenw3TjRCm903/7q2yYp63KFk5lzwSh1HzIj1/Vcx8q4EWJH
         yctKbdZG4JfiSq01ZEiuLhlro5BiXXszOB39+NL8cK9hU/3fNYfmR3VD8HUgXdJHlsTK
         4KK2lEZeW7hHysq++L1sxV6vYOt0CcR90oINj/zkWrti8ojcBq2wRR/OhT99xhvkw8Xm
         tMAQ1iJKRXuzF5+V494NO3L1ISt0vEnBCQAK7G7IJdqxNydZw/KiZy6ToSRZ5saP3oMz
         QNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719563725; x=1720168525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNolEEmkU6Ry+wXWBxbsl928QObWZnXzUE7LPASxVTE=;
        b=vKlcWzmJzeGMu2K0ZEKyMcbtR6f60+tVjuMQ/2Mc+PwIdtGcRIEAPlxG0aeNHyuytH
         8UxuYZBpJrCzQzXPH307ai0aC9YpErDJsk8qLGnLjQw06aGuCvXB9SdaL8I+vVUM7iYk
         KY1PMqVJc3f7kNQFpWmTXmEfl9xsevcBaUUdA4PbO2harouJ5M+DhkwWk/mbyUzAkBwV
         W7JOlGR6Ti09BK8GsGPk7DW++a4EjT0hntZtXhbl2B411qmWoPW7HbL9SMGF34tklL7J
         anAvpCGDrx/FGuh1kWvIO2IWiWVf5kfcJciaCw4FNi9McM535HipE3rRCFv49ENBwMMJ
         E01A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqWb/KWxXe12xqQehrimzAm3LhXZ4s1jb9NxcT54sDZfxSk2Ieh/3jMT8SKNr3UuyL2XTGUvF145Ixlj8tOxyFR2D9Sh7UIrDfPso=
X-Gm-Message-State: AOJu0Yy+F18mfX/zQtw4Wd9sZOZu3QqQsjqFu66DVxDxsjV0/lB74WUR
	0HSRW7375cAGlqDbyPosF9EzQqUQijisYRpeYKZhuwRDyocx8ZbQu+HtDaSMueA=
X-Google-Smtp-Source: 
 AGHT+IH0dVLpq1WiFFtaJNklk51Rq5LfwF3kNGv46euWX6ESZ9aSdNKd7M7qDLdGFtoOEGCvB3sxKA==
X-Received: by 2002:a2e:88c9:0:b0:2ec:556f:3474 with SMTP id
 38308e7fff4ca-2ec5b2e94bbmr102009301fa.52.1719563725213;
        Fri, 28 Jun 2024 01:35:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee51622ae6sm2179691fa.51.2024.06.28.01.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 01:35:24 -0700 (PDT)
Date: Fri, 28 Jun 2024 11:35:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: dapm: Use unsigned for number of widgets in
 snd_soc_dapm_new_controls()
Message-ID: <r2mogdrjnwf7bg7ytfnxrz2hmwbsuur2pzy2b3fpzz3apyxvts@bppukrkvrxhw>
References: 
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-0-ede31891d238@linaro.org>
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-3-ede31891d238@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <20240627-b4-qcom-audio-lpass-codec-cleanups-v1-3-ede31891d238@linaro.org>
Message-ID-Hash: YP3GTNXGMHSLOTWJ7SKGVILJIYLFHRHT
X-Message-ID-Hash: YP3GTNXGMHSLOTWJ7SKGVILJIYLFHRHT
X-MailFrom: dmitry.baryshkov@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YP3GTNXGMHSLOTWJ7SKGVILJIYLFHRHT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jun 27, 2024 at 05:23:45PM GMT, Krzysztof Kozlowski wrote:
> Number of widgets in array passed to snd_soc_dapm_new_controls() cannot
> be negative, so make it explicit by using 'unsigned int', just like
> snd_soc_add_component_controls() is doing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/sound/soc-dapm.h | 2 +-
>  sound/soc/soc-dapm.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
