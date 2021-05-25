Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72741C2B9F8
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 07:26:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0196D61260
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 07:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0196D61260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DF1D15E2;
	Tue, 25 May 2021 09:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DF1D15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621927606;
	bh=+6CojBawYGz2MCWCu322TvMUcv5taL1mzrsyDoypFg8=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VhdmvqJBR6jVgdj3mQ3NiHBzlddCA+2+2E4NCcAHuYHu9vujQvTb6DrpyxqGOhaLP
	 ifXUbvHrCgxtE40SGe2gihIqnviqsyECu/uiy1p7b+JHHB23JYtBq9bWWWaInZrUfj
	 r0SfxRkzukJ0Id+TndHGdGiteZUJmqQlh50S3jZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0289F8019D;
	Tue, 25 May 2021 09:25:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18A23F801EB; Tue, 25 May 2021 09:25:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63F7DF8011B
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 09:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63F7DF8011B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="0MtyI7OR"
Received: by mail-wm1-x336.google.com with SMTP id h3so3379902wmq.3
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version;
 bh=ZEZhCSQ9uc7mF8AHjrZUH5gfKrJ3JXJlTrw+y889SUA=;
 b=0MtyI7ORZHyejQpBMbsmoHZs4a7igABp5xlbXJ9baaWTVC2DyPgURrJDuABUhyO1F0
 QeSG6jO1PIjsd3vAxfJahaXy76ghL9BrSWozCdgQK2RgiG5QwhAnJd6ffE+f6Fh/Ko2o
 3Fko/k8V+OIxpE/AWWpbLSDFCdJGqYZlDrLrQK1s6SuedlKz2MJXHbWRUclWsHyI0TsK
 u3v1ofn/4HF5ZwOR7I/eMwT6u5HLl+pnrBSvRcwPVdN6bdqDq7XDeSiifo1LlC1p92ig
 WmhSUo5liTi98NUerQXsn0Po4b6i9TYi/7w7YPMnwYkwq6gZrUmOn97vkc2m+pBgQO3Q
 JlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version;
 bh=ZEZhCSQ9uc7mF8AHjrZUH5gfKrJ3JXJlTrw+y889SUA=;
 b=qJRe+9tmwyhWA//3vXjyWdMZfFVFcI1Acdn6vJXffqxg5GxEAWGsb97yeVOMgUk6Vp
 u970832XuSLq+UyXISU5i/nqybBn7kDuy23+/ZFriLiEazMjTWAzQU4mu4BfuXh2gYdp
 aMVPUGRLsJXfkl4RhFZtKU0/YKvWTcWXDv4FZCZkGQBfqz6duYTNLmV22ugbsCXePn8J
 GjMifq9t7LWGKMaMyIg0c4P3u+vNuZqdcOnOe2SbN5RLzLDdrQH1YoJRBmsO/k/FpN6L
 EPnbGyNS4xHGWwunTlnkMsd3Rp16EbjrUulvYH8g+5lwmLeNiy+J8bK+DQMgH+NREXce
 4HvQ==
X-Gm-Message-State: AOAM532MgytWCvEnPNG33z9nFfz+bVtSc7qPK+ttt040AxQN5SDESJsx
 Fu3RXwiMWcAMaGpGYBU+M9CG7JOg5iBfCw==
X-Google-Smtp-Source: ABdhPJxhlteZuQ+HUmsDQzMPYu1gVw/NLhbHKMk2/ryWg5lxPizaWGte9GeVZfA7ZL9JogTA3irSYg==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr2468708wmh.123.1621927548149; 
 Tue, 25 May 2021 00:25:48 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
 by smtp.gmail.com with ESMTPSA id d141sm10158766wmd.21.2021.05.25.00.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 00:25:47 -0700 (PDT)
References: <20210524165136.400702-1-jbrunet@baylibre.com>
 <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
User-agent: mu4e 1.4.15; emacs 27.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Joe Perches <joe@perches.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
In-reply-to: <9f21272719a3983bda647147e8460615159875b1.camel@perches.com>
Message-ID: <1jh7irb7gk.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 25 May 2021 09:25:47 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


On Tue 25 May 2021 at 02:07, Joe Perches <joe@perches.com> wrote:

> On Mon, 2021-05-24 at 18:51 +0200, Jerome Brunet wrote:
>> Use dev_err_probe() helper function to handle probe deferral.
>> It removes the open coded test for -EPROBE_DEFER but more importantly, it
>> sets the deferral reason in debugfs which is great for debugging.
>
> trivia:
>
> It seems that the use of %ld, PTR_ERR(<foo>) isn't particularly
> useful now as dev_err_probe already uses %pe to emit descriptive
> error messages.

Indeed. I'll update. Thx for pointing this out.

>
>
>> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> []
>> @@ -352,17 +352,16 @@ int axg_fifo_probe(struct platform_device *pdev)
>>  
>> 
>>  	fifo->pclk = devm_clk_get(dev, NULL);
>>  	if (IS_ERR(fifo->pclk)) {
>> -		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
>> -			dev_err(dev, "failed to get pclk: %ld\n",
>> -				PTR_ERR(fifo->pclk));
>> +		dev_err_probe(dev, PTR_ERR(fifo->pclk),
>> +			      "failed to get pclk: %ld\n", PTR_ERR(fifo->pclk));
>
> here.
>
>>  		return PTR_ERR(fifo->pclk);
>>  	}
>>  
>> 
>>  	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
>>  	if (IS_ERR(fifo->arb)) {
>> -		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
>> -			dev_err(dev, "failed to get arb reset: %ld\n",
>> -				PTR_ERR(fifo->arb));
>> +		dev_err_probe(dev, PTR_ERR(fifo->arb),
>> +			      "failed to get arb reset: %ld\n",
>> +			      PTR_ERR(fifo->arb));
>
> etc...

