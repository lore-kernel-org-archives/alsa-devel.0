Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DBC4332F
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Nov 2023 16:27:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64BD2ED7;
	Fri,  3 Nov 2023 17:27:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64BD2ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699028872;
	bh=F7p790G6tsjaA0g2cv/3tmRS63mAasG0hm45lFjpIYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qN2aLLldkL+oxW307aVI7vXp1fouJwQLTfFmJqQLsj3izoIS2efhhYq3i4p5boW12
	 TlqOSQ3QZcZEDSyZ6kXnH6o5VxttTVUVT9IKCSJnCk1Q4faF42x5j5Pa1jgEOazg48
	 kmr7Los/Y3u/7g4gq8VgBJPzD9EBrc8i7VogVKFI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3AA38F80579; Fri,  3 Nov 2023 17:26:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80687F80571;
	Fri,  3 Nov 2023 17:26:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BF53F80152; Wed,  1 Nov 2023 08:30:17 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D195FF80152
	for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2023 08:30:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D195FF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lo4R69Yu
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d224dca585so559512466b.1
        for <alsa-devel@alsa-project.org>;
 Wed, 01 Nov 2023 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698823806; x=1699428606;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CW/G19QSts/AS5IHtohcgFR0rmH2Gai+NgYGEXSnqko=;
        b=lo4R69YulW7LcK1W/cPPiX/OMs5YEAgcNZb3YbH1QMLgKhxD+NpRttgagOXqqNdWNG
         7uDX2116KxrthF0FG+2Io57Wg8dM/YCBx/G/sxK9V1rjErGI7YTKkM9VkyP6knef05Qg
         KLCQe5QUI/h73cHkqP7BV8FHxLaThtZFnYp53/Y1jB0R5tndRIjKYS28WGH4HTkNdWbg
         1Az68uSSUf62PSI1JLH8Ki1sTS/e5ct3jCtbOSFiCRcft4tJbNIgL/FcV+5v/h475O4O
         ioJDIuRRia3rIAmZUzQuUmeKKSW7kfHZ1z5NelLh5dTypmj7KZfDHCn/mPkzY+/lpSKb
         5zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698823806; x=1699428606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW/G19QSts/AS5IHtohcgFR0rmH2Gai+NgYGEXSnqko=;
        b=rqoCamzT/qFPbEdBSG3sOiBzKuwoO5T6qRhGrALrocRweWo2NkAuXoU/zeVXilKbm3
         ROF68a+xCksMHvGu3saa4XLeyE6xW0eTyfuw9RHDJ508KydNsYQEyQVChOdMqYFTkKfM
         HktgQ/tdRclcBvojZ951/BY1NStAlLAjxeoqX/ZRnnOiMsTFw4pWpTeynNeRiqYoGEUz
         NwPJhKz9rU+UHZeYGwy2MJhzrbM76a60mvba0oKg+LYCyUy1YHq48nfZzziZPex7YgK/
         xo/FdvooLBJc3yFU+YfU5nU3I0V0OkJRbtP6dFpn03NRX6EUV44s02ckyU4Ud3TPGajj
         5i5A==
X-Gm-Message-State: AOJu0YwLDZqqW/THHv3JaZedjb1lqCXEWtNm1lrBQm6oN1ZDN5PfE5TI
	QCJCmvDiLHxVKwrZ1jEtiiQvYg==
X-Google-Smtp-Source: 
 AGHT+IHn5OBLKdIBm9gYlbbPmKG0d7lUTKDYbGWt1aIcMqZvCFT1JsaADE8XNZhwlrSvfLYDhRJBlA==
X-Received: by 2002:a17:907:7f9e:b0:99c:6692:7f76 with SMTP id
 qk30-20020a1709077f9e00b0099c66927f76mr1413901ejc.16.1698823805746;
        Wed, 01 Nov 2023 00:30:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id
 v9-20020a17090606c900b0098f33157e7dsm2044256ejb.82.2023.11.01.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:30:05 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:30:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
	mastan.katragadda@amd.com, juan.martinez@amd.com,
	amadeuszx.slawinski@linux.intel.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC: amd: acp: fix for i2s mode register field
 update
Message-ID: <8b61e318-7734-4bcf-ae17-59128058e5b7@kadam.mountain>
References: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
 <20231031135949.1064581-3-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135949.1064581-3-Syed.SabaKareem@amd.com>
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: L7D3ATGVRQPZUCWY2OAWS66WRSMRUDQH
X-Message-ID-Hash: L7D3ATGVRQPZUCWY2OAWS66WRSMRUDQH
X-Mailman-Approved-At: Fri, 03 Nov 2023 16:26:07 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L7D3ATGVRQPZUCWY2OAWS66WRSMRUDQH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Oct 31, 2023 at 07:29:34PM +0530, Syed Saba Kareem wrote:
> I2S mode register field will be set to 1 when tdm mode is enabled.
> Update the I2S mode field based on tdm_mode flag check.
> 
> This will fix below smatch checker warning.
> 
> sound/soc/amd/acp/acp-i2s.c:59 acp_set_i2s_clk()
> 	warn: odd binop '0x0 & 0x2'
> 
> Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock
> 	generation code")

I saw this yesterday but didn't comment because I didn't want you to
have to redo the patch.  Mark, of course, also saw it and didn't ask you
to redo it.  And now it's applied.

But for the future, these Fixes tags should be on one line and in the
tags section of the commit message.  (It's in chronological order).

Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock generation code")
Reported-By: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Mark Brown

regards,
dan carpenter

