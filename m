Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D71C2BD09
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jul 2024 18:31:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01A67E72;
	Mon,  1 Jul 2024 20:31:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01A67E72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719858707;
	bh=0iOo5cayNGx4g6/tnzEHTcEtMgyyP/qKsGpTDFnROBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hvKPOM9Dk5VaSI0X56qECoYKeqdrLRPXZ45n2ykJEB/RDkqXy14sn8e33AL4JwzVI
	 0ebd7aBwmc6brWOaNBR1XXhtAXN2kGjJhRByQTzTH+vPLDRLAIYEaQ4wgCfOjW4nd2
	 s0JQKOVeZIL19OU3/sHoesQoziqLtB7cGMrXDg5s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7504EF805C0; Mon,  1 Jul 2024 20:31:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10C61F805CA;
	Mon,  1 Jul 2024 20:31:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C054F805BF; Mon,  1 Jul 2024 20:30:57 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 281C2F805AD
	for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2024 20:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 281C2F805AD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=azAVJMxd
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cd8897c73so3844070e87.2
        for <alsa-devel@alsa-project.org>;
 Mon, 01 Jul 2024 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719858654; x=1720463454;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1bORojp7LGodQMmR0GktDpziQrjk5mFTyAYpRSH12Y=;
        b=azAVJMxd29ripIFjxiOU5I1muZQ+QJcBxywP7iDW1d6u2IQYv17cuNPu6n1uvpyI0H
         5NFqqq1XRsRFmY/PDzEPZnK9quhaDva/1KfJ0mnyoKM+x8NtOMtcB0os3bVXJqbFFQpB
         86fgB62T8SXFp+9qVksG5bABsvzm1HXJJrM9VNc7bBRSCreVsKmtM0Ry7sa9EjR37sSb
         h2R1e+DWlxT0C1woSYQwseJSLSwWZzFnidH6RK6ojel7qcJTvTvsyLXlgLQ08yZcV8cz
         HojC8FHSS55VU3JrDR0UqGkWCBNjad7bfs5E0AL/SqoJ7jY+VIR3vZ8+ugA/VUj4zwRJ
         ctYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858654; x=1720463454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1bORojp7LGodQMmR0GktDpziQrjk5mFTyAYpRSH12Y=;
        b=SBZsnAlf/XGdwrLl47rdfRXPhSzHkyEKo2ZqJV676lmrD+zDi/6qMoZW44lWqU4fw5
         U2PmAkSFDRRdI2TfOq81p4UpqCCT9P0seuDCJsJ5zso5PcQMTofFiatyeIKJqimU/aJJ
         6AthRmrMD8RRXXh8g0z6wgZVrTxKKpsAFEeQ/1w541oj/QjKFQ51AtDtzhbkseXiU0dn
         z8YRMde2BkPU1+vbTkY1SDo0+sL27nLY71sgkgi4y1H2CUDo6ycWKhznP8aQWg5dxBjf
         2NEfGxnTZF+wBGOW7e4VfH2QEmRWg6DG9xEfOXd6E3S5j82gXX8FrjA2MwIUfdT0xD0q
         51mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSueZtUMkUNTq26K77nqZUcg27P6L/RfIuBWpu+S0JMWKhEfQRcVzb2egqJn5PW2R09+DA3ZNYVl423ciQ0rphUfrc8i9dgQxMjLk=
X-Gm-Message-State: AOJu0Ywqgd1MCmKb3JZPrNrYBlUmD4fU17Ujs92H4MTMdr4zMN7yQ9KC
	elh7CJznATJIvxjrizUxb2x/C/vy2Z8eSGRGNze58fGbgG1acYaxu6XuYBYETzw=
X-Google-Smtp-Source: 
 AGHT+IGio8w2qPHnHjpAdv9Xq1wSVEaXIaQHK0Jse0W5DVm/JwaGTZCVvQ9Jvyo2ZGxv4pHSbq62yQ==
X-Received: by 2002:a05:6512:b8e:b0:52c:8210:13bc with SMTP id
 2adb3069b0e04-52e8273e3acmr4380491e87.64.1719858652604;
        Mon, 01 Jul 2024 11:30:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab0b9f0sm1480819e87.12.2024.07.01.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:30:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:30:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: codecs: lpass-wsa-macro: Fix using NULL
 pointer in probe() dev_err
Message-ID: <slpv56feowlalqd2olti5bnxluovcvjs4k7koszhukfxvgycz3@4mm2n27e372l>
References: <20240628095831.207942-1-krzysztof.kozlowski@linaro.org>
 <20240628095831.207942-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628095831.207942-2-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: NIUOK6WXAKESUKODP3SPZPLI74YIQ54D
X-Message-ID-Hash: NIUOK6WXAKESUKODP3SPZPLI74YIQ54D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NIUOK6WXAKESUKODP3SPZPLI74YIQ54D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jun 28, 2024 at 11:58:31AM GMT, Krzysztof Kozlowski wrote:
> The 'wsa->dev' is assigned closer to the end of the probe() function, so
> the dev_err() must not use it - it is still NULL at this point.  Instead
> there is already a local 'dev' variable.
> 
> Fixes: 727de4fbc546 ("ASoC: codecs: lpass-wsa-macro: Correct support for newer v2.5 version")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
