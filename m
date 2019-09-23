Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7088DC3A5A6
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:09:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C05521670
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j/8m4FAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C05521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E09831612;
	Mon, 23 Sep 2019 11:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E09831612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569229755;
	bh=zxJWhMiTvq+gAXRK7r/M5+ThM12huhkL5HUFwUImFmo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/8m4FAp031nn12xns5BW46pwZK7hybZ19rBRU8lCDPksozgAXthbM2lh5OccplzF
	 OtKQN4I2DxLF9D0aZf0/V2AAJFLGhMI9/bA2gnKI9U29gtrrML/WIhqOQu32dRE0Da
	 nnTUb61k4+SVi67xp/KlIZN5KKku4JxlLCrGoq/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B7EFF80213;
	Mon, 23 Sep 2019 11:08:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE597F8044C; Mon, 23 Sep 2019 11:08:22 +0200 (CEST)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72E4DF80213
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 11:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72E4DF80213
Received: by mail-wr1-f65.google.com with SMTP id i18so12960432wru.11
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 02:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tmMoz215KHiHYt4Ll2Ro4BC6di5AJcGWo8A7DQ1dHmY=;
 b=qdmSa9xV+dCkZRRAju9xVjJI7ztKw6AniJDkhzfYw2cYALNe/OmH8MliOpqlPHuEeN
 QdZcM5fUti2L1lcXPFweTbfWd9W4lLv63WdQjsLaa510WRZke4Tuqt2zTP5FFPDFwpep
 5RpviEKo/0BGWLr4eIa+vWTd9A33rL07eOhLxaTaNkuP3S9xTqW9Mfu7iOZBf2pEFzeD
 NoqtluRo0ILZqMTCPmeqkqf0TnraTxpHYKwyJ2mdqut9Bso5I6I1ZzOgYJrgDEORxOl0
 CJS4/cHnEShOXM9HYAbD86auOOwjtXSic3rRTUAheeknIMUwQLKszXMAtecosjbUOc75
 YmGw==
X-Gm-Message-State: APjAAAURR8r99cxlq4vZxFhO1IU2XR6wxUMviV2n96ubfOtQknd86v60
 L+osp2zugbfnVxrNiS/LI3E=
X-Google-Smtp-Source: APXvYqxxz7xafqgEfOSFCn8V7BM7y8g8X0JT9J5mDxENqXlljKM+EhY7wNQyUH3m4B3AzLz2RugrKg==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr12649575wrs.158.1569229691633; 
 Mon, 23 Sep 2019 02:08:11 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id a13sm21942066wrf.73.2019.09.23.02.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 02:08:10 -0700 (PDT)
Date: Mon, 23 Sep 2019 11:08:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <20190923090807.GA4577@pi3>
References: <20190920130218.32690-1-s.nawrocki@samsung.com>
 <CGME20190920130315eucas1p2a31543214fedcdfe86196f176f554a35@eucas1p2.samsung.com>
 <20190920130218.32690-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920130218.32690-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, sbkim73@samsung.com, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v2 02/10] ASoC: samsung: arndale: Add
 missing OF node dereferencing
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

On Fri, Sep 20, 2019 at 03:02:11PM +0200, Sylwester Nawrocki wrote:
> Ensure there is no OF node references kept when the driver
> is removed/unbound.
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - rebased to beginning of the series
> ---
>  sound/soc/samsung/arndale_rt5631.c | 34 ++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
