Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2EC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:25:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AAC2075D
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RzNuTzlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AAC2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C093170F;
	Wed, 29 Jul 2020 18:24:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C093170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596039911;
	bh=bb4zuQGhtPo9xAh3UaRQ5Q1apxoMxdA4XPIwcRvHT/E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzNuTzlHiqsoxA27rGfRJQJrkGvjejwc6Diie82cCdveonP+Ho4gVJ4DGS7rIZkxZ
	 TzSLpOAGzi7b77QHA8/C9g8AmT19VeutfwpzhJTxFLn5jpSl0fAmaAyPZzuecQJGzg
	 b+CbRnUYhdj3cddLqjjuWmeCemOI/ESokkXIT6r4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16675F8012F;
	Wed, 29 Jul 2020 18:24:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D0B7F801A3; Wed, 29 Jul 2020 18:24:19 +0200 (CEST)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE0B0F80125
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 18:24:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE0B0F80125
Received: by mail-ed1-f68.google.com with SMTP id o10so8173645edh.6
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 09:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cS3+221AHZYDhz8vJwUJuKP1AL5RGbuh31j+wmF7oUU=;
 b=Xz1ITpV5+43tMJ5S1wehOsXHssP7GNrLfY31dvTik6teOTRS1jv1muh9gF4Y8+3amH
 UsTTInzrPADql3+hzvetaad9JF2doHmS9C9gk217cxuAS5DfoGvFX9YUZ/lOOssqru5Y
 1+1lHJrG2EUZ2GhzqEEM3VTAhiPxAFiQ/CZmxL9B9MWThkLC2QCI7/61J9YGBKpG9Oat
 b+4H6zAbnM+G9/s+iyd06mmokz4hkrbeY7EulU6D2qF2VHvHmEYz1AUrE4BUEwbfpLTW
 VR9RpHAPNyVJSbARaaTs9tOap8/iU6eHfL2puUzJdl3RBRZftbEj5cRqe+Gw10Xq2k6M
 aDzQ==
X-Gm-Message-State: AOAM5326LMMRTLVjqhtIKo4ZQw9blwL9nQbsrLBDc3OPnQI6LECN1M1c
 H/6TDJXUYLPS3ijY8lN02lk=
X-Google-Smtp-Source: ABdhPJzrXVWpA0e/54O+SdDq9PueVFgMc6upBS6jL4XfQLfXkn58bf/2j89VIVWgToUmT/t20TgnfQ==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr33304657edq.160.1596039847872; 
 Wed, 29 Jul 2020 09:24:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
 by smtp.googlemail.com with ESMTPSA id dh16sm2193450edb.3.2020.07.29.09.24.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:24:07 -0700 (PDT)
Date: Wed, 29 Jul 2020 18:24:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 1/3] ASoC: samsung: Document DT bindings for Midas
 sound subsystem
Message-ID: <20200729162405.GA5302@kozik-lap>
References: <CGME20200728131126eucas1p16365622c52f91104373a2cd3e0ebb619@eucas1p1.samsung.com>
 <20200728131111.14334-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728131111.14334-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: simon@lineageos.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, robh+dt@kernel.org, broonie@kernel.org,
 m.szyprowski@samsung.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Jul 28, 2020 at 03:11:09PM +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of DT biding for the Midas sound complex.
> Partially based on the *txt version by Simon Shields <simon@lineageos.org>.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v3:
>  - change the sound-dai property type in cpu, codec nodes from
>    phandle-array to phandle
> 
> Changes for v2:
>  - fix wrong *-gpios entries in the example,
>  - mark sound-dai properties as required.
> ---
>  .../bindings/sound/samsung,midas-audio.yaml        | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,midas-audio.yaml

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
