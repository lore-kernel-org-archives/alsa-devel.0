Return-Path: <SRS0=2KR+=X3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1DC352AA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:21:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767CD21848
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aVrr7T8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767CD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D745A1661;
	Wed,  2 Oct 2019 19:20:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D745A1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570036885;
	bh=Dbx3zHVob5Mxd0HNYbLCMg8BfpoG/0k/SwmfJdtM1HA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aVrr7T8vAnA6M68o32AkXGNdaEGcL+TSstahzo/C0qkDsyegSzaqLdidXRo5rUOCf
	 dQYqD9piG6NLg1t1pnNG+aOYek2xB/J5sGl7UIk/R2Iv9S4hxo2bQmNf/x0b9vXZoT
	 0fMykQRaRpKcXFhgdvj9C5btYmigv7Ti33T3F6f4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 721AAF8036E;
	Wed,  2 Oct 2019 19:20:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B46CDF80391; Wed,  2 Oct 2019 19:20:32 +0200 (CEST)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39598F8036E
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 19:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39598F8036E
Received: by mail-wr1-f66.google.com with SMTP id q17so20582374wrx.10
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2019 10:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HHIl7GcN4vEcWiPV/kc+k0bb9GY+GyE08iX8fWZ3jfQ=;
 b=rdbpKZpM6JIYjlUWpawHw2FnsEg5q4AJy8ZwhzFGyKcjq7p0L04of/GDao+wl7gv5A
 2lv9kBX3BRsDFiN4gB/AlTRjnEOK5jq6PRz7aqn9p54Tw5/fB7mScDBMM0Bj6frueX7+
 hFKwLH3U9IId2Igb9k3ybQIOIK6S9coZeqeYocrZBG2MCGtlQNEidTVLF3WHR8rPx7ho
 j0CScKGkF/OwTAG4/yfw4BiZw3ow+8xwjg8pNK4RaXmIhLAJkCPV67Tq0Hmr3DnBrLRc
 VjK++9/Yh4K/xNC4c9pxDT1Sx2HNmqx30TIaNC4F0tLvjAtbZOYl9iq5OI2fuRgrse8e
 rw9A==
X-Gm-Message-State: APjAAAWEbP7cB7pVG1q2HL5Zl0I2Fdi5tIlKo7PAud5SE6FFo9h5/+Ou
 SOFA34b/FrDAuqbobVqznLY=
X-Google-Smtp-Source: APXvYqxxarjurJVDg8sOa7I3VttsCWxG/9IRBIDA7rFqTl1ZhKVpbx9bSmVkUQyRWZSN7AUt19cTEg==
X-Received: by 2002:adf:f008:: with SMTP id j8mr3583865wro.75.1570036829185;
 Wed, 02 Oct 2019 10:20:29 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id c18sm13223wrv.10.2019.10.02.10.20.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Oct 2019 10:20:28 -0700 (PDT)
Date: Wed, 2 Oct 2019 19:20:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20191002172025.GB21463@kozik-lap>
References: <20190920130218.32690-2-s.nawrocki@samsung.com>
 <CGME20190920130711eucas1p29497b40981e4e0a24769ced4e06be208@eucas1p2.samsung.com>
 <20190920130702.529-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920130702.529-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, sbkim73@samsung.com, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v2 10/10] ARM: exynos_defconfig: Enable
 Arndale audio driver
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

On Fri, Sep 20, 2019 at 03:07:02PM +0200, Sylwester Nawrocki wrote:
> Enable audio driver for Exynos5250 based Arndale boards to improve
> testing coverage.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +

Thanks, applied.

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
