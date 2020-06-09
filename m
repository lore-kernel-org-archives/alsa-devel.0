Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E5AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59E32074B
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="icOcYSd6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvo97F31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59E32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FBD91694;
	Tue,  9 Jun 2020 11:53:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FBD91694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591696432;
	bh=DXFQ1WVkU68Ooe8Nu/1P8LjPlx+iVm03sndCHeSR77o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=icOcYSd68MTGbHTObMClNoW19iY1ZvgMFyiLBPFzE3TDRBVO2wwbFtBfBa0bWquy+
	 s3aSBUZPl5yBphYw6Ha1gBueCnGSaURzKdbzWfx1Cjdzrqgm+5SR4MDGydnxmQSnPy
	 zNzX4ewTbj6ADZZID6K8NEaO4Nk0aGtPGsVMB3WQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97446F80278;
	Tue,  9 Jun 2020 11:53:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0245CF8028C; Tue,  9 Jun 2020 11:52:59 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3684BF80088
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 11:52:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3684BF80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Cvo97F31"
Received: by mail-wm1-x341.google.com with SMTP id r9so2198129wmh.2
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2020 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gYYo/WlElneMeWBB8UHZIKhrIY/hMj30GM+8GeLsDwY=;
 b=Cvo97F31BblpJKGnrH8wOAnOYwgXCbZcqTLbN7s+1z3ImAIxF2dcrT65rOumoqx4p+
 6KMbuQbzAHwNc4IUtCdWLGNIbOJAphFeYAm+XDoUQtK+GIA3iNYZV2cBMoRAWJXc9ZaK
 MFkBmAoPKaPShKwNzB+joHpNujEeCRh1FGJAVdpUgwlfzTrv7eoV5gVkxMbBTFv6MRcD
 1eBMAI1WEwGAfnOczR9b+rwxjLecZgroxhEd/RxKBS/yD958wJ1WZBonJ0cwNT2WQ2oH
 4t2vZMKd/60Uj2c82NyXlvZNmkbOwKbtd+Wmsk6KynZzG6ljZFWQR1eYJ1oAYZomh41I
 /rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gYYo/WlElneMeWBB8UHZIKhrIY/hMj30GM+8GeLsDwY=;
 b=pqVU0BXYXDV+RFWeetUl+/BCXc01BeBviY/K5ZMakiWUh60l3eFQ82JCqIFUmenhVL
 XdKaYsg+Em7kAmuy0ZcqId/ZOCHslScO4B/HLindE/Y88SQ+lykPywrqZYo62rbVdIfk
 w0zk39CqtcKbBYhWqnYiVq70iBQHjDBaDiiuC7ZzhA8/dyOfxYev9aU+gMNJMO1o1Hxt
 3DoRC9ZhYzNrg9yWz9ZZKUQD2orfaXj982s6PqHo5YLbKR3fBG0bgyNvr2c9I6u0gccf
 xOKBEiDvZJKpsW//YcXX7eM5W1qDHYedx0TMLqiiMsD2anb1scWWRdMJ9GS1zqjPDbZX
 PsLQ==
X-Gm-Message-State: AOAM531uyvSunPK5W9xr/UQUQJPWqyZSJIVpd2UBesVB5tC6PR+Jo2PE
 a0cxU4UwST0NqjAf/eEwHhDoWw==
X-Google-Smtp-Source: ABdhPJyy9cb6qWZPWEOh5nUzAGMVdRs60ufD+FnSfzck2902IUU+s1FQjoSxQLRK29F2An8hWu/8qw==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr3252885wmg.21.1591696369288; 
 Tue, 09 Jun 2020 02:52:49 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id h27sm3206966wrb.18.2020.06.09.02.52.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 02:52:48 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
To: Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f3eabdb9-da43-9502-352a-1696babc114d@linaro.org>
Date: Tue, 9 Jun 2020 10:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-5-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Gross <agross@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
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



On 08/06/2020 21:43, Jonathan Marek wrote:
> The driver may be used without slimbus, so don't depend on slimbus.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/soundwire/Kconfig | 1 -
>   drivers/soundwire/qcom.c  | 5 +++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index fa2b4ab92ed9..d121cf739090 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
>   
>   config SOUNDWIRE_QCOM
>   	tristate "Qualcomm SoundWire Master driver"
> -	depends on SLIMBUS
>   	depends on SND_SOC

Why not move this to imply SLIMBUS this will give more flexibility!


>   	help
>   	  SoundWire Qualcomm Master driver.
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 14334442615f..ac81c64768ea 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	if (!ctrl)
>   		return -ENOMEM;
>   
> +#ifdef CONFIG_SLIMBUS
>   	if (dev->parent->bus == &slimbus_bus) {
> +#else
> +	if (false) {
> +#endif

May be you can do bit more cleanup here, which could endup like:


ctrl->regmap = dev_get_regmap(dev->parent, NULL);
if (!ctrl->regmap) {
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (res) {
		ctrl->mmio = devm_ioremap_resource(dev, res);
		if (IS_ERR(ctrl->mmio)) {
			dev_err(dev, "No valid mem resource found\n");
			return PTR_ERR(ctrl->mmio);
		}

		ctrl->reg_read = qcom_swrm_cpu_reg_read;
		ctrl->reg_write = qcom_swrm_cpu_reg_write;
	} else {
		dev_err(dev, "No valid slim resource found\n");
		return -EINVAL;
	}
} else {
	ctrl->reg_read = qcom_swrm_ahb_reg_read;
	ctrl->reg_write = qcom_swrm_ahb_reg_write;
}



thanks,
srini
>   		ctrl->reg_read = qcom_swrm_ahb_reg_read;
>   		ctrl->reg_write = qcom_swrm_ahb_reg_write;
>   		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>   		if (!ctrl->regmap)
>   			return -EINVAL;
>   	} else {
> +
>   		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
>   		ctrl->reg_read = qcom_swrm_cpu_reg_read;
> 
