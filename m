Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C68DC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 14:30:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60D8318A7;
	Tue, 12 Apr 2022 16:29:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60D8318A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649773819;
	bh=ObI7H77R3QQSeIdK0trjbtlT5gaP7+PKxsA18UsBPb0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sy8yFOJgBQ8Z+PzL/EBkG9QcFTkgaK6g4GRfjeVyXWB0tDLZEujD4n/r5UT8FhVAJ
	 ZxZbHJnHr+I7RovrirwTZC6esHAUqhRVpmp28/DT0b8ePrKw8Oj//xDWENxt5FMigf
	 i1i32mk03xmSrXysCcIlllbjW2YWRzxWHwFQMN9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CB8BF80249;
	Tue, 12 Apr 2022 16:29:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CA7DF8032B; Tue, 12 Apr 2022 16:29:28 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF03AF80109
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 16:29:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF03AF80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MH0U2Ei6"
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-df02f7e2c9so20893197fac.10
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GxA+wuzS2VTnaCpw8/DQnNsOeYcblk4406tgOs1kPrI=;
 b=MH0U2Ei66jCCDx0swymTSyZNk3sqbf2rY3WLX5Pwrwu1nh4V8Y30+ZB3CqJ1LQTgYF
 RW6NfbBcMkKOLWwftzRLiHSJBGsZD7uVe1vSQ4XPpr3C+w9StxSqyq39xfujlxaCzZEA
 jh1nYCzV2j1fN0bitFi8h9P9jpzUWygVsUE/JfpK8emwb9gw7IGIrpA+ga80zMSiiJbk
 sQ4E87/XQxmcKR07uUxArDcPJ/l4LmYlza7SP9SO5H2V9EjHZpBqti6iDGJM1tNIsN5P
 QrJVCvwLMoVMNAFUcdQCeKSfHTQHoV+PtB0amwIE5Sy4AN4cRWRSiiMauKoIpfpZshw/
 4iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GxA+wuzS2VTnaCpw8/DQnNsOeYcblk4406tgOs1kPrI=;
 b=g6cuIDgb8Dj3EXZQToGIttnQREb4yBZuaO6CIRCm+bh4diAI4a5lG+z2D1r+64PX7G
 pE6Rl+RSTv7Q23gZXqXjqJ5LmHJ82i9rDkUIgepOmoCx7ZUfUao30jXdxapF2JWP4kBt
 XUe+PEbGNbqvl0Jz3mILU6DT6EDXX8smbOx9lQzAvyDYZrhR2QZxTACLCPdZ3XW3ljBH
 i0wO2Q5ob4G0EFRhXQfH/IEfKmVtC5lSGeVuYlSQ27YeQvmHNJhUr32t3EBeuZPLd5sf
 hZZ9ZTcLxiMqUfDNjOCm9UjKAw/1NJ/nPXytBCoMz4rF9EiSwSEajqrhBLTDjtV/kF/M
 5bHw==
X-Gm-Message-State: AOAM5338TYibW2vevgrgl30QRSiLj0s5UoOGhCLucDJcaNXzZM0dvGSE
 t4hmzHEnBUOxR9vGoDJrRAOnZg==
X-Google-Smtp-Source: ABdhPJxZW+yVNF/lJYAiuoC2KDAAc81y2wKm3Y8r2ObfycQAn7jcAdHMNb2ptE++bS1LUV+uIg2qCw==
X-Received: by 2002:a05:6870:b40a:b0:d7:5c87:64ab with SMTP id
 x10-20020a056870b40a00b000d75c8764abmr2204624oap.168.1649773758139; 
 Tue, 12 Apr 2022 07:29:18 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
 by smtp.gmail.com with ESMTPSA id
 r82-20020aca5d55000000b002ecaaa13cafsm12579555oib.8.2022.04.12.07.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 07:29:17 -0700 (PDT)
Date: Tue, 12 Apr 2022 09:29:15 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] slimbus: qcom: fix error check return value of
 platform_get_irq()
Message-ID: <YlWMu9D/6nVl5tqV@builder.lan>
References: <20220412090259.2533316-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412090259.2533316-1-lv.ruyi@zte.com.cn>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>,
 linux-kernel@vger.kernel.org, agross@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 sdharia@codeaurora.org
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

On Tue 12 Apr 04:02 CDT 2022, cgel.zte@gmail.com wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> platform_get_irq() return negative value on failure, so null check of
> ctrl->irq is incorrect. Fix it by comparing whether it is less than zero.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/slimbus/qcom-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index f04b961b96cd..b2f01e155d77 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,7 +510,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
>  	}
>  
>  	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (!ctrl->irq) {
> +	if (ctrl->irq < 0) {
>  		dev_err(&pdev->dev, "no slimbus IRQ\n");
>  		return -ENODEV;
>  	}
> -- 
> 2.25.1
> 
