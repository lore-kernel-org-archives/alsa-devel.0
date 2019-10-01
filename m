Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058BECE587
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34A221906
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pmyTvwWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34A221906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C4F81654;
	Tue,  1 Oct 2019 21:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C4F81654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569957320;
	bh=BfXO8OTZ7wWnrc1DUKHTZ6BDHbR/2z9ap5mAs4G0EGE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmyTvwWxXKrd+1neS8zdVRC1wiXs5n2p5f71WkkfvsZi/n8NQn3amqCPvhe0yCPun
	 g6tC0dc6dIMu13vsW88BXGCCaresnq/qKPX9u6294JBXu8gYbO3iV20DveuXx1PT1b
	 IoKzYILJFF9WbyUj8/wrb1PhRMCqOZU310BsDuPM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F60DF804FF;
	Tue,  1 Oct 2019 21:14:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 380BEF80506; Tue,  1 Oct 2019 21:14:28 +0200 (CEST)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4B01F800DE
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 21:14:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4B01F800DE
Received: by mail-wr1-f65.google.com with SMTP id r5so16809445wrm.12
 for <alsa-devel@alsa-project.org>; Tue, 01 Oct 2019 12:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CQLUqS12o3E7JRqYPNwzncPftf2wy1G+8WY+i5RSSMc=;
 b=QSjkOcJxPei6cb5iZIKkZHKy+7m50ZbPtb6VF2wpPhLjStTJSCyV3CqDO0et6LD+kr
 7QFn8jeYd+hApr86VLEr0H7cCllGH6vGxOtzxwiUGY1ohTcynpivFL3seRylGlumWvds
 LrtYPBIqx9l71Y7eR0q6TLHwQpIUU459kEPs4pTm9ePvJzoXFQims1R/PJFXmaypUTss
 6dKixXTfSacW0xynOdCLXc1/LBIfH9KCrbyrBGr/UeF8rgHBeMIHXtu6KcRf6OdJ6paT
 pZ5gt+D8Zr1aoQvm8Vq5awyH2YJ1eqItcrK2QeJKluR6LUj/2cIjSQkvTYGmUL3gaBia
 2Xhg==
X-Gm-Message-State: APjAAAUqPspKA3ezrHY2SXxqBWUUF8tDoBQz3g5qZNca4OO9yntXlcaR
 Hk4/gxeVyri3dyyQKmH4RH4=
X-Google-Smtp-Source: APXvYqzVFOVq4N8sE1r+S49chs28jalopnOHn56iSfJSaDhrCdoQlTiDaEqmIDWKO7ksT+tG/sm/qg==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr2368549wrx.171.1569957264390; 
 Tue, 01 Oct 2019 12:14:24 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id v6sm8289511wma.24.2019.10.01.12.14.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Oct 2019 12:14:23 -0700 (PDT)
Date: Tue, 1 Oct 2019 21:14:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20191001191421.GA30663@kozik-lap>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
 <CGME20190920121526eucas1p2e2165c088519094752066db49aa8ae51@eucas1p2.samsung.com>
 <20190920121431.31678-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH 2/2] arm64: dts: exynos: split phandle in
	dmas property
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Sep 20, 2019 at 02:14:31PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.

Thanks, applied. Please split the commit msg according to Coding Style
(submitting patches, chapter 2 and 14).

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
