Return-Path: <SRS0=iYEd=XX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA4C4360C
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Sep 2019 17:50:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF4E20863
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Sep 2019 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TkV8Rm+j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcRg+tDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 320AE15E4;
	Sat, 28 Sep 2019 19:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 320AE15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569693025;
	bh=DRn+B+B7F4MadpGcBmAXmXJXz705yJvoUKG5ybtLGEA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkV8Rm+jv+N9zX3xPXGdz8UbGl1LlsAhaBAeSsZ4wJCYIsyC+RDzmrl4NdQtZbuUO
	 DZv7DGVbhZ1JiExJOoTB55kwFGxnaztwO4YznbdhW9FOGZEpK52/vtAxQzUZ3ftjIc
	 JISsYDSplvCFpJigbamt+2K+irsz2d+avAibUUBA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8C68F80306;
	Sat, 28 Sep 2019 19:49:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D86BDF803F4; Sat, 28 Sep 2019 19:49:32 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9EFCF800E2
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2019 19:49:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9EFCF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kcRg+tDA"
Received: by mail-pf1-x443.google.com with SMTP id x127so3274366pfb.7
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Tz34nLx8zc3x7P3I+XVz0wfasxKpU8Q18lKTFK1FdGI=;
 b=kcRg+tDAcnLHQiHao30I0Di4gyP/Fp/1XXwvVQsckNtUh20SDvDDm5n0YT+z/TIWmB
 CCBV/Y4pndXJQcH1O9iuCa5x7UAH3udfNRZXwkcB1NTL4HZwtHVEMrxHe6CM8lPFkchW
 8PqNZTFG+whLlShnF/kAHGIaR1p9acIp11kNz9bSJnPHs7Kui+YVVnCEcFMMM3u9eYfS
 qE/QhXD52b6oNcjSAECkRO9jTzyGG0YRRVNBn6reyK0oiurBV8tqU4JNkEqaZF8Xgz3D
 R+6InNeuJP1Jj/3zkdpvInoZLAoK3E8+AdZIVf1BspWUtU4CGa9RyCooULn76SmZAfym
 TmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Tz34nLx8zc3x7P3I+XVz0wfasxKpU8Q18lKTFK1FdGI=;
 b=bC13CyAwcP5Z4wxc/bR/N2g93USNdxzv4bUiaxRQFMLExKcjR18NL8dn3T1EBBh6Xx
 anvlpPlHUaXkQyip1h8dK4Q3+/g5NpNHcs91XZxZj/x3YBM1p/MTh9Whyq7IR5UTZgG5
 FMhj/ZMHVM7yF4vGnXZRbK6OXKYTNxfmWhi0VBF1Akikp4I1jck4q6yVlv/cK6gtQ4Kw
 y8j0dfYi0jcxdcrVeEpzPYurvPJbrJ8PmlbUMvWT5gSzXvx6uu1dOphNTqpJA/AdfUaV
 WfsNq2cxpbGL8bjj7aWkksoBqVTe3KwpwA7UjMc9z6U6Q0P6857oblq371wMJI9HVcS0
 oeMQ==
X-Gm-Message-State: APjAAAUmej07wzpvGNunvYylDqSTPa2xdYrZGNAZDutFCx8zcTUrNchW
 XtOSHQeLewnYFhvfWhXvntU=
X-Google-Smtp-Source: APXvYqztDH+CuPrUtFhwIzHFomHf/jYRogGVw3LtuVXbsf/C1OjujrMLAvVxM7rEL/hdmsZyPG9tCg==
X-Received: by 2002:aa7:9358:: with SMTP id 24mr11593054pfn.241.1569692966129; 
 Sat, 28 Sep 2019 10:49:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d69sm6664026pfd.175.2019.09.28.10.49.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 28 Sep 2019 10:49:24 -0700 (PDT)
Date: Sat, 28 Sep 2019 10:49:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Message-ID: <20190928174923.GA25512@roeck-us.net>
References: <1569580317-21181-1-git-send-email-jiaxin.yu@mediatek.com>
 <1569580317-21181-3-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1569580317-21181-3-git-send-email-jiaxin.yu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, yong.liang@mediatek.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, tzungbi@google.com,
 broonie@kernel.org, linux-mediatek@lists.infradead.org, eason.yen@mediatek.com,
 wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH v2 2/4] watchdog: mtk_wdt: mt8183: Add
	reset controller
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

On Fri, Sep 27, 2019 at 06:31:55PM +0800, Jiaxin Yu wrote:
> From: "yong.liang" <yong.liang@mediatek.com>
> 
> Provide assert/deassert/reset API in watchdog driver.
> Register reset controller for toprgu device in watchdog probe.
> 
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> ---
>  drivers/watchdog/Kconfig   |   1 +
>  drivers/watchdog/mtk_wdt.c | 110 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 2e07caab9db2..629249fe5305 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -717,6 +717,7 @@ config MEDIATEK_WATCHDOG
>  	tristate "Mediatek SoCs watchdog support"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	select WATCHDOG_CORE
> +	select RESET_CONTROLLER
>  	help
>  	  Say Y here to include support for the watchdog timer
>  	  in Mediatek SoCs.
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 9c3d0033260d..660fb0e48d8e 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -20,6 +20,10 @@
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  #include <linux/delay.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/reset.h>
> +#include <linux/of_device.h>
>  
>  #define WDT_MAX_TIMEOUT		31
>  #define WDT_MIN_TIMEOUT		1
> @@ -44,17 +48,113 @@
>  #define WDT_SWRST		0x14
>  #define WDT_SWRST_KEY		0x1209
>  
> +#define WDT_SWSYSRST		0x18U
> +#define WDT_SWSYS_RST_KEY	0x88000000
> +
>  #define DRV_NAME		"mtk-wdt"
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  static unsigned int timeout;
>  
> +struct toprgu_reset {
> +	spinlock_t lock; /* Protects reset_controller access */
> +	void __iomem *toprgu_swrst_base;
> +	int regofs;
> +	struct reset_controller_dev rcdev;
> +};
> +
>  struct mtk_wdt_dev {
>  	struct watchdog_device wdt_dev;
>  	void __iomem *wdt_base;
> +	struct toprgu_reset reset_controller;
> +	const struct mtk_wdt_compatible *dev_comp;
> +};
> +
> +struct mtk_wdt_compatible {
> +	int sw_rst_num;
> +};
> +
> +static int toprgu_reset_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	unsigned int tmp;
> +	unsigned long flags;
> +	struct toprgu_reset *data = container_of(rcdev,
> +				struct toprgu_reset, rcdev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	tmp = __raw_readl(data->toprgu_swrst_base + data->regofs);
> +	tmp |= BIT(id);
> +	tmp |= WDT_SWSYS_RST_KEY;
> +	writel(tmp, data->toprgu_swrst_base + data->regofs);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int toprgu_reset_deassert(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	unsigned int tmp;
> +	unsigned long flags;
> +	struct toprgu_reset *data = container_of(rcdev,
> +					struct toprgu_reset, rcdev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	tmp = __raw_readl(data->toprgu_swrst_base + data->regofs);
> +	tmp &= ~BIT(id);
> +	tmp |= WDT_SWSYS_RST_KEY;
> +	writel(tmp, data->toprgu_swrst_base + data->regofs);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int toprgu_reset(struct reset_controller_dev *rcdev,
> +			unsigned long id)
> +{
> +	int ret;
> +
> +	ret = toprgu_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return toprgu_reset_deassert(rcdev, id);
> +}
> +
> +static struct reset_control_ops toprgu_reset_ops = {
> +	.assert = toprgu_reset_assert,
> +	.deassert = toprgu_reset_deassert,
> +	.reset = toprgu_reset,
>  };
>  
> +static void toprgu_register_reset_controller(struct platform_device *pdev,
> +					     int regofs)
> +{
> +	int ret;
> +	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> +
> +	spin_lock_init(&mtk_wdt->reset_controller.lock);
> +
> +	mtk_wdt->dev_comp = of_device_get_match_data(&pdev->dev);
> +	mtk_wdt->reset_controller.toprgu_swrst_base = mtk_wdt->wdt_base;
> +	mtk_wdt->reset_controller.regofs = regofs;
> +	mtk_wdt->reset_controller.rcdev.owner = THIS_MODULE;
> +	mtk_wdt->reset_controller.rcdev.nr_resets =
> +				mtk_wdt->dev_comp->sw_rst_num;
> +	mtk_wdt->reset_controller.rcdev.ops = &toprgu_reset_ops;
> +	mtk_wdt->reset_controller.rcdev.of_node = pdev->dev.of_node;
> +	ret = reset_controller_register(&mtk_wdt->reset_controller.rcdev);
> +	if (ret != 0)
> +		dev_err(&pdev->dev,
> +			"couldn't register wdt reset controller: %d\n", ret);
> +}
> +
>  static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
>  			   unsigned long action, void *data)
>  {
> @@ -187,9 +287,12 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>  	if (unlikely(err))
>  		return err;
>  
> -	dev_info(dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
> +	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)\n",
>  		 mtk_wdt->wdt_dev.timeout, nowayout);
>  
> +	mtk_wdt->dev_comp = of_device_get_match_data(&pdev->dev);
> +	if (mtk_wdt->dev_comp)
> +		toprgu_register_reset_controller(pdev, WDT_SWSYSRST);

Please explain why you can not use the watchdog device built-in support
for handling system resets.

Guenter

>  	return 0;
>  }
>  
> @@ -217,7 +320,12 @@ static int mtk_wdt_resume(struct device *dev)
>  }
>  #endif
>  
> +static const struct mtk_wdt_compatible mt8183_compat = {
> +	.sw_rst_num = 18,
> +};
> +
>  static const struct of_device_id mtk_wdt_dt_ids[] = {
> +	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_compat },
>  	{ .compatible = "mediatek,mt6589-wdt" },
>  	{ /* sentinel */ }
>  };
> -- 
> 2.18.0
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
