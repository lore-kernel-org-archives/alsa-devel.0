Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4654CC05027
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Jan 2023 22:13:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A5A9DF6;
	Mon, 23 Jan 2023 23:12:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A5A9DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674512017;
	bh=WpDX0Q5+85mF5T4mhpeOf9XKkP8cTL4si/Jw6/KaRU0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=l3doAHv1967ExSbTsDbLuoqSy9gjBHE5oMw1/cNUgaJkj8i8NvaLeIK5H4TSgwb4G
	 ep4lUKyyp8zyQMjZXcEw1/k/JMURomTqWqedDXAmc4M3ozVlQu1zQ4NMjuH0C78yZu
	 OtVvp2JmiHeEcZDtcN6TK46vY87PE8wOL6FmqmO4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B82FDF804A9;
	Mon, 23 Jan 2023 23:12:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3570F804C2; Mon, 23 Jan 2023 23:12:45 +0100 (CET)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43F57F800FB
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2023 23:12:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43F57F800FB
Received: by mail-oo1-f48.google.com with SMTP id
 c145-20020a4a4f97000000b004f505540a20so2364851oob.1
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2023 14:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cMLmkmo9lGN+fi5ZC+ygOUrkVG9Zx/Ga/8bzeJa5ryE=;
 b=Sdf+dlk2umC0kLArXS9iZGMhbhfIeB0Tdz+kmbFpMe094rYlbkk8u4SkCoOBmMkcxi
 L+Z9XYT+eIDGEgEf/SX8+b34hQ934YrIQYU5bD+K4F+uDAqjlkZpWW/vSQT39h/FBsA5
 hZR6vx+ecBtQBvhEe9dRCaLFnYGs7OoWeq6BMexRs6X1l6SIguvcEp3nT6BbSXhz4Ld9
 jGsd/dQ+/UztnCKRJ1WzSz4Spu+1/QfyhLkiu3Oy8a+BRgeSTWuyoMUKS5O2OJCSDLcp
 0Qkw/0hqdhBTiP1ITklhuGUh65ZMT4Mt5UznERz/kiADwnoG1pUvWt0UJo3RxF4n6Dp+
 9wkA==
X-Gm-Message-State: AFqh2kpSOyxd7vYay+py8okyP6xZRisL4WnqJEWnhnurpZW9HjTfjT3Q
 5TNYLk92JC9yesLqjjIwoA==
X-Google-Smtp-Source: AMrXdXsj+dUOjJFBkC70kkkAxResHBLRpkv9hhX1dQNQHd6hyWvltfjJ+pcOubXVLewz71LmQgzdHQ==
X-Received: by 2002:a4a:de98:0:b0:4a3:f27d:f319 with SMTP id
 v24-20020a4ade98000000b004a3f27df319mr20184987oou.8.1674511959046; 
 Mon, 23 Jan 2023 14:12:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 k2-20020a056820016200b004fd878ef510sm103490ood.21.2023.01.23.14.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jan 2023 14:12:38 -0800 (PST)
Received: (nullmailer pid 2730757 invoked by uid 1000);
 Mon, 23 Jan 2023 22:12:38 -0000
Date: Mon, 23 Jan 2023 16:12:38 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: samsung-i2s: drop unneeded
 assigned-clock*
Message-ID: <167451195757.2730699.17818991615433078771.robh@kernel.org>
References: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
 <20230120153020.320270-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120153020.320270-2-krzysztof.kozlowski@linaro.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On Fri, 20 Jan 2023 16:30:20 +0100, Krzysztof Kozlowski wrote:
> assigned-clock-parents and assigned-clocks are coming from dtschema, so
> there is no need anymore to keep them in bindings.  Their presence were
> also causing false positives:
> 
>   exynos5422-odroidxu3.dtb: i2s@3830000: Unevaluated properties are not allowed ('assigned-clock-rates' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/samsung-i2s.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
