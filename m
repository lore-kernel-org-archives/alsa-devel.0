Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C2AC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Mar 2022 01:49:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ECE516CB;
	Thu, 10 Mar 2022 02:49:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ECE516CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646876997;
	bh=FAXkl1limneIu6zadIVD+oUEvSFKkjbiLhuvk/m+Ulw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jv9eB1kAlI6wyYeAW712Ky5EZ6jIzGO9tMGrxM7CN3C9plegbj5oJwfqbfJ2ImWWY
	 +AunqVBvGb9ea2KjAns53Fk5zO8SogyjkFQf+JrJVhosqocws8ZkYKm8j23rTkAqEk
	 LIXlolZi7RC//aC39stOXemq/knxY1fRi7hfg5zI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BD82F80158;
	Thu, 10 Mar 2022 02:49:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A943F8016C; Thu, 10 Mar 2022 02:49:04 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 507BEF80155
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2022 02:48:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 507BEF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="okRt2sjd"
Received: by mail-yb1-xb2e.google.com with SMTP id f38so8099613ybi.3
 for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2022 17:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1bLFaEO8mOotUe50ZxcYVhyRYpxUpsrpzjYVsiD2crY=;
 b=okRt2sjdarUbFOvYxqa+MiC6FqIGlYjtkYgvjUGqx0oUvh9zbaVJlod0YPIMc1NOho
 sUGY4zrOxfYezQN/KNemtXHsN7oS1GE0kcWIS2uFpH7ueLnflcPEVrV1WtolKcBUOX0e
 W34A4KJj0SodBs1o2DTWwJJq0yn7stTDNRwmNLQs+ITs4jQg02py36luWd6NVlG7oAPw
 w3ZUUvzWlpRxig7MyGQrAAIniItOSCT6MWKgN97bJr4IXVfxmfXytRDvWqk3LdVZr34A
 GJzMQV+otuRvyUvpx/H/cNyqV7xJnpgWVgJvefbtrdvK16Ripp2nmgUzeMxKvMfSvUSn
 j9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1bLFaEO8mOotUe50ZxcYVhyRYpxUpsrpzjYVsiD2crY=;
 b=Wu9118g9lDj8t4PffI0unGi1DptR3q+GY6bhHpYWYSOFoKg7cpJ8QSHMiB9KwhtyqK
 REMPlXRjVMRt9/Y8unc48zSpOdu5r0ynHmSB4Wd5dHRnxSR9mtPuoMcUlQZ1qQIsZQe3
 d6DdSWD1fjwEEqPfWglEZM+KlcKpsnHlnj026ZM+45H+g6NNbEG+9L33wK0bQNn/Kd0Y
 u5Uo4e7pmsFPsIm2zQnU7SQFsTzZ+27DbGrWBL7GGuJRTp5dgwSpss0q7UTagzfpiz48
 LCJ3z3TzTTsWpiqEjZRZxe+XnH97ymI7viPrnj0M6d/ikUlEICslLmzNOgI1yi4bjIXY
 9zyA==
X-Gm-Message-State: AOAM533DIny0yLgVV7xjeZN+zPmjbB6X9rHQEEzDOTSIjBOvMi78CD5H
 ay1/q/j705VNPvAtx9X3WipOFgRby/dp9855KIE=
X-Google-Smtp-Source: ABdhPJxIdVI2E/S4Q3a5l3PHvoEWzspgq0xDfqimguAi8hOWMxPm06Tq6J2Cxxa0VKkWSwOghbFdX5nVmjuGUe8H2eU=
X-Received: by 2002:a25:8289:0:b0:623:dc4d:28e5 with SMTP id
 r9-20020a258289000000b00623dc4d28e5mr2137425ybk.182.1646876935381; Wed, 09
 Mar 2022 17:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 10 Mar 2022 01:48:29 +0000
Message-ID: <CA+V-a8t4gpiSM2uF59wHA=eF+yDcss90OzL=2CiBNSq6A2FwJw@mail.gmail.com>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the
 interrupt
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-arm-msm@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <agross@kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

Hi Srinivas,

On Fri, Dec 24, 2021 at 4:13 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi,
>
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
This patch is not in -next yet. When do you plan to merge this patch?

Cheers,
Prabhakar

> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 7040293c2ee8..0f29a08b4c09 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>         if (IS_ERR(ctrl->base))
>                 return PTR_ERR(ctrl->base);
>
> -       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!res) {
> -               dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> -               return -ENODEV;
> -       }
> +       ret = platform_get_irq(pdev, 0);
> +       if (ret < 0)
> +               return ret;
>
> -       ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
> +       ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
>                                IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
>         if (ret) {
>                 dev_err(&pdev->dev, "request IRQ failed\n");
> --
> 2.17.1
>
