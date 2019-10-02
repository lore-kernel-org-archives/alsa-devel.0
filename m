Return-Path: <SRS0=2KR+=X3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8DC352AA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:50:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B7E21848
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JqxGzGk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B7E21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6EB11664;
	Wed,  2 Oct 2019 17:49:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6EB11664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570031413;
	bh=mzO6E6+hCZUVtfQHD3Wat4LqCdnWbotMDz0kioD4wTk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JqxGzGk6H8biQakgrsKzZmbm7Dk9c7Cx+o5kik0nGv57Geavcx4g8xhbwye8PpC2h
	 gE6rzehrEm+stKwUw3NaC7pMVn4nBmhEAHFrNU143O/JVhzH0c0n2dHQUunucJL0QJ
	 Rqd8arm+DFrYfrdfz+AKCLYyqVucQ3G4iN/WKju8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60B9BF80377;
	Wed,  2 Oct 2019 17:49:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 115BBF80391; Wed,  2 Oct 2019 17:49:21 +0200 (CEST)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 853EFF800DE
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 17:49:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 853EFF800DE
Received: by mail-wm1-f67.google.com with SMTP id b24so7490747wmj.5
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2019 08:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hgUS28cg0Ci8+dU8EWiIp1hr9/xKokLLrdm7CPLWAvo=;
 b=FHyWW4puQb+KXzj1KT9eZv8T1/13DRUmDuJuYYxpw9UAgi6BCQpNxeB8IKnrIQzqbS
 8QEieoiUDd9WmmCst8HxE/09ZOX2jE029QNQ/ndIe0cg+tTl1QWfdvLsnpoMSL9UUhQc
 gd3l3Gz10Kg4UwJBW9FfP8ND1KrZDwlu9IfXjvEoteJFkzlKxvNXTuI9howyIdMtbCK4
 dKZgjFVRlkuXpZNgoJv2fLrfy5+3v/MBnOV0CyIly7nWf5//mw8lMk3VcPE/OyAvSYIw
 dE34DLRu5YyCP2qepWlSwg7kobbIartqBwdWZtMUTd492tc+SdwkEbim4YvAhwYFt0ve
 nfQg==
X-Gm-Message-State: APjAAAV4QCuKmt6m8QktZyjT0aGzqIy9nB5VGzsUWQq4l0b6PTyUpKJ8
 QSJU9zStkVym2HrJ3YCyK84=
X-Google-Smtp-Source: APXvYqyTeEy+1KjEAYvX0VNyGdGx9sODUOSxgNLAZ2aoIxasQFGDO/mzpLVaIyqmpgn0Y5MQ2y7OYQ==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr3554413wmj.81.1570031357494; 
 Wed, 02 Oct 2019 08:49:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id p7sm7527991wma.34.2019.10.02.08.49.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Oct 2019 08:49:16 -0700 (PDT)
Date: Wed, 2 Oct 2019 17:49:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20191002154914.GC4072@kozik-lap>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920121525eucas1p27562c205c41200221540b720c9084fb4@eucas1p2.samsung.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ARM: dts: exynos: split phandle in
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

On Fri, Sep 20, 2019 at 02:14:30PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi |  6 +++---
>  arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------

Thanks, applied.

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
