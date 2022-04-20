Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EA7C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 13:51:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43F9982E;
	Fri, 22 Apr 2022 15:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43F9982E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650635465;
	bh=yB6+MMVExRHKJM5njMqnJ8F3rjm47XZT2Ijs66vzxAo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rckKtx+XSKwA8rWkdBRlMRmouMYRw61Y1lg1X1UKF1QkuWHWAPckwlVB6NseOz6iw
	 B6K8YJh/QJDGU3uml14pNkE6+YPh1jTKwAHlNAef6M/pazuWnqhYVOg50Frgr1Lx0d
	 n2l6l1B8QrwXHK4mbmczoml5sXEpg4iu9i1dIPI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7DF4F804FB;
	Fri, 22 Apr 2022 15:32:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D997F8010B; Wed, 20 Apr 2022 11:24:20 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B27E9F8010B
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 11:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B27E9F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VCx/HeNd"
Received: by mail-lf1-x12a.google.com with SMTP id t25so1741727lfg.7
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u55Ek4ovTu93jGC6owGr6QZtrHl98TBOqnvlwoTCUt0=;
 b=VCx/HeNdAIrVvK22LWtPVkq9Bv1IKELkDsHc9ZDCJpEzPZXiUk1L12Dy+mMZouB4Kb
 Sm5gqeWiHiAo7O1rqL4fR/FRWrLwV1sxcNCEE/ser/ng6KnPEXuXeI6mJT4hEuhbpkyR
 CnEwq7dF8XjnevURjfPXlQSPsthUbrMgXmTx0ftPiqNOdHSrKFkOiwbXMIgL4L8pif1x
 S2OC7crPo4slcyULVJrhskiIc37n3wR0KWOXQ2sj5i0hsb8hGWYGa7c9kFuF9uQx1Lrd
 PnwrnrwZvh2dBVEvqkQHhB/xuL6v+vJ4eVgGVRgIh8ublrifvFa02qV7bdCp+CMifVZv
 cETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u55Ek4ovTu93jGC6owGr6QZtrHl98TBOqnvlwoTCUt0=;
 b=raeNokcZu9YxpcwItn90Kvm+Wxdx1usMXeNmW/7WVaqJkvkDouvUDO6+txhEPqws0+
 zbeC/KkH2OQbJygbEKYg6vZFFXXebFzgDVp8vysUE0762SzOV3P/0Q0iC62ok9GvGYQp
 BvSdPM0sO8X6rysfd4MggqdnQH2dVoZIBGZGC3JDyyBcieoF7RnKTopuSlgkLc/5k9v+
 poGhXoXC3rhY+butn3JAk3NFT67Nd/B5MYm94FgVE+k4DQJyWfQOilYnxcrydL1YhPcQ
 jTSyJVRqsfjkuSblqy7AXVPqa52/QmgSnGEJndCqJGX2/2pgbBLFsiVV/gb8Nb2u6DF2
 qTWw==
X-Gm-Message-State: AOAM531Ek0qRzHYv5rfQMAFJeR/06eUSQP5wHx7cC/YOeGz8nVdody3Q
 Qm8TLdp0DywOdiPEuR2NVJkS4jO8YRl5Tg==
X-Google-Smtp-Source: ABdhPJwBIjGhPQR/MG3suNBpw+sG1uqlbM+4wIOJy5ZknDOvMCYopGuZbVrLmdXv8OTjIhB4lEs0Kw==
X-Received: by 2002:a05:6512:168d:b0:471:6cb9:c20f with SMTP id
 bu13-20020a056512168d00b004716cb9c20fmr11611107lfb.229.1650446651069; 
 Wed, 20 Apr 2022 02:24:11 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.74.70])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a19384b000000b0046bbd144dfesm1760268lfj.125.2022.04.20.02.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Apr 2022 02:24:10 -0700 (PDT)
Subject: Re: [PATCH 01/41] video: fbdev: omapfb: lcd_ams_delta: fix unused
 variable warning
To: Arnd Bergmann <arnd@kernel.org>, linux-omap@vger.kernel.org,
 tony@atomide.com, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-2-arnd@kernel.org>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ddaf112d-f997-84b7-2c57-bab3d0cca382@gmail.com>
Date: Wed, 20 Apr 2022 12:24:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220419133723.1394715-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 22 Apr 2022 15:31:42 +0200
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>,
 Kevin Hilman <khilman@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 Felipe Balbi <balbi@kernel.org>, Paul Walmsley <paul@pwsan.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 alsa-devel@alsa-project.org
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

Hello!

On 4/19/22 4:36 PM, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent cleanup patch removed the only reference to a local variable
> in some configurations.
> 
> Move the variable into the one block it is still used in, inside
> of an #ifdef, to avoid this warning.
> 
> Fixes: 9d773f103b89 ("video: fbdev: omapfb: lcd_ams_delta: Make use of the helper function dev_err_probe()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
> index bbf871f9d862..01944ce46aa1 100644
> --- a/drivers/video/fbdev/omap/lcd_ams_delta.c
> +++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
[...]
> @@ -145,7 +144,7 @@ static int ams_delta_panel_probe(struct platform_device *pdev)
>  						&ams_delta_lcd_ops);
>  
>  	if (IS_ERR(lcd_device)) {
> -		ret = PTR_ERR(lcd_device);
> +		int ret = PTR_ERR(lcd_device);

   How about inserting an empty line after declaration?

>  		dev_err(&pdev->dev, "failed to register device\n");
>  		return ret;
>  	}

MBR, Sergey
