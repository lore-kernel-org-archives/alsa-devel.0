Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A66C433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:57:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E3064DC4
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E3064DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E487172A;
	Thu,  4 Feb 2021 14:56:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E487172A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612447031;
	bh=aeRsBmpH63Dkwmocz1L4dvvBiKkO9BQ+x1OOyf1+ZBo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5p87WvgufTLdWq0bkJpS0cFd6OF/HgO25ThomHI70ivdVA7/8oSP+d4dI42k/SUY
	 0+6XKobjxWGnPWPjp5mgYQ9dbfLIp3LBRNdDh4ao4KaoGyJ+2wVhnAjnGjNLfOOHHQ
	 RW1QP8s23vnITjqyHzgSBqfXr47Pbn/y+swDsFXg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D4BFF8025B;
	Thu,  4 Feb 2021 14:56:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68129F8025C; Thu,  4 Feb 2021 14:55:59 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E5AAF8023C
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 14:55:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E5AAF8023C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="hfB2odMR"
Received: by mail-wm1-x334.google.com with SMTP id 190so3207259wmz.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2021 05:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4lmQaGfHzcMwGXIZmc8Kdp166D/+3+SPGhElADZc+zU=;
 b=hfB2odMRJ/nQQOZXAWUWi4CnlyDrbOsYjUyCux2E4iQWi6/saISmFsSly4xM56718L
 8jlfJxPTZBXcqLkSDYSwM8U+FD94NayvxXgET1Ly9JSmdBTac4VbQNhsPn/Q/xn+luLG
 vfD8oQRrmBBNArlVsMvSpW30Ov1g9s96jQcPUf5PQcRnjuFzsz+4rUdp5PbguE3pmch3
 8p+eZO65gUrJdJJnthhRKqTUgpe0wB1zDXR78bRC+T4s9FLnt+dPgOzbKOAAI3bGuf9j
 LO9zLdcW7/VeYooRjbmdnVJQNXy1SXQVrL/fF6ppDNuxPJwr/bFmYvodaVHZZoP60+C8
 NcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4lmQaGfHzcMwGXIZmc8Kdp166D/+3+SPGhElADZc+zU=;
 b=qE9KJDgcirkEc0NpImjxVbLb7tXpddD7uO75GnlByh/4DsRQsAisvBoG9dbqqEwVWi
 8otP1SNmD0H2SHAu20X/FN2BK/JcdGKoLpfbha1zDrsGGTQiAj1Vr+2YftkM1vYsPGca
 Pq/vDUo5s7+23afzdt98ORICo2fPeFI/X/W6mNVkrGrraxoXUk2DXD66SveHA+HBVBkW
 px4J6nd2PPLDuTHdRSWsWgBLwVBi+r4ZsA/r3mdP6Bg1jTW21G0MuWpVealCOuUX/bNf
 FRypPV/tTCWvwKVXhcaa78DxC9GOnEsnMGLpnSYOxboryKWsU6GFbUfEZhb1tAzcTbZv
 /KBg==
X-Gm-Message-State: AOAM531iNxL+YOv/iVovTkT6wsw9ep5HH19dkIqZEt+y3O+TDwLeGfgw
 hYhGK3RU3hyAqFu2DwDrB3ji0A==
X-Google-Smtp-Source: ABdhPJz5DJ0+mbJg+bLCflgpSdIpVUfIHXnDHuI1F85rL98t01knyk7lbiguRXYZ2wBmk02Jd5s+DA==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr7652875wmc.39.1612446952095;
 Thu, 04 Feb 2021 05:55:52 -0800 (PST)
Received: from dell ([91.110.221.188])
 by smtp.gmail.com with ESMTPSA id y14sm8245541wro.58.2021.02.04.05.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 05:55:51 -0800 (PST)
Date: Thu, 4 Feb 2021 13:55:49 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
Message-ID: <20210204135549.GK2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-4-hdegoede@redhat.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Christian Hartmann <cornogle@googlemail.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Wed, 20 Jan 2021, Hans de Goede wrote:

> The Intel Bay Trail (x86/ACPI) based Lenovo Yoga Tablet 2 series use
> a WM5102 codec connected over SPI.
> 
> Add support for ACPI enumeration to arizona-spi so that arizona-spi can
> bind to the codec on these tablets.
> 
> This is loosely based on an earlier attempt (for Android-x86) at this by
> Christian Hartmann, combined with insights in things like the speaker GPIO
> from the android-x86 android port for the Lenovo Yoga Tablet 2 1051F/L [1].
> 
> [1] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
> 
> Cc: Christian Hartmann <cornogle@googlemail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> - Add a comment to the irq-flags override explaining that theoretically
>   DSDTs using IRQF_TRIGGER_FALLING could be correct on boards where the
>   IRQ controller does not support active low level interrupts
> 
> Changes in v3:
> - Fix compilation error when CONFIG_ACPI is not set
> 
> Changes in v2:
> - Minor coding style tweaks
> - Use memcpy instead of for loop to copy gpiod_lookup-s
> - Log a warning when the ACPI "CLKE" call fails
> - Drop addition of acpi_device_get_match_data() call, as the code was
>   moved over to use the generic device_get_match_data() helper in a
>   (new in v2) preparation patch
> ---
>  drivers/mfd/arizona-spi.c | 127 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
