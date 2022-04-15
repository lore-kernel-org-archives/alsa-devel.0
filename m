Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8055DC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Apr 2022 21:40:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF97B1707;
	Fri, 15 Apr 2022 23:40:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF97B1707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650058856;
	bh=6EMqDWWOB9Qj5FEBMkRG7Xl6WJIlHLH3Muo9Eu5bLHo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLe8bQCa/eToXBZgGOixs+/MgNYpovK71STG5FTkFCoor4miULlH95Nfv2X1Yl2T+
	 BAgDVskZb4rgwmz3Gtf5yPtroCVgulkoFf7BJv5ysFIr4OaqIYGoSD041iSRQ+f+rz
	 OsIsX3RbiTOjLMW3T7figHPuwQ9I5FqS25ioiGt4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DFA0F8014B;
	Fri, 15 Apr 2022 23:40:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5FBBF8016A; Fri, 15 Apr 2022 23:40:04 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E304F800AE
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2022 23:39:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E304F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Mr7FDGOC"
Received: by mail-pj1-x102d.google.com with SMTP id
 o5-20020a17090ad20500b001ca8a1dc47aso12681563pju.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2022 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pnnhVnGjhESFSvN5AIAUxQOTXkNGysYpxD5X0481Phs=;
 b=Mr7FDGOCaG90Xqb9CkSUPuMLdgZLTpRANkq0G9fniO9sl7RuxMhwa4pMV7r5aAPtzr
 WmI0puD3f3vvRKTbriacpoZCx07mwNv4Q8uGwKJ58b15UjhjHbYdIdBK34DjlTTZpRkX
 YqcK6dt1qkBadKHIxzvtlkwWFYo49k1qxyF2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pnnhVnGjhESFSvN5AIAUxQOTXkNGysYpxD5X0481Phs=;
 b=eOGdaeKftiQmU4UnyqRHKPjeg8OdqErvd45tauXTE5h/HTF3nE9444ZCX74q3GZoOy
 CetdQAe3IGxYGcYJKapKGaV3ilcIXSK9CasR86d9WmPlbRdCNYxYOEI1YuPU+XSNMe+i
 Dcrg+atWOnkRbxekWzHbUOtq20KHAyd5QfY7uIlq61rVvhcf5oIdBdKSnr0dgtqpNtJA
 5c0RHSQ7triZeYbJor7TUvBMW7bYElEjZqLfQtr5FhD/ZzGNHqrybryfhphjn7f5qQb1
 oA0eHMAOsypHBwWDUY4cTmDawgqsClJq65MziBhnZdn7P6BM8BQYzwc9CIIdq/X8YqVz
 UTjg==
X-Gm-Message-State: AOAM530IsJvnVzJfKSlL5EUGaTM/lLUO6bwENhc5NCfs8M1BRZWl6x2C
 8SCuICPGqWLM2Z0xZ71DA0eacA==
X-Google-Smtp-Source: ABdhPJzezmjazjpZOJiGsT/T33Plq2/us4Na0I8/Us86rxlwMws1XdK7SKgVBfiOxbVNW1v+4cbJfw==
X-Received: by 2002:a17:90b:3b8f:b0:1c7:b62e:8e87 with SMTP id
 pc15-20020a17090b3b8f00b001c7b62e8e87mr6192674pjb.156.1650058794221; 
 Fri, 15 Apr 2022 14:39:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b27a:b3e7:2e3e:e4be])
 by smtp.gmail.com with UTF8SMTPSA id
 w9-20020a056a0014c900b004fb2ca5f6d7sm3707308pfu.136.2022.04.15.14.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 14:39:53 -0700 (PDT)
Date: Fri, 15 Apr 2022 14:39:51 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v12 5/7] pinctrl: qcom: Extract chip specific LPASS LPI
 code
Message-ID: <YlnmJz/wjxfkZFua@google.com>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
 <1647447426-23425-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1647447426-23425-6-git-send-email-quic_srivasam@quicinc.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 linux-gpio@vger.kernel.org, rohitkr@codeaurora.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, quic_plai@quicinc.com,
 bjorn.andersson@linaro.org, judyhsiao@chromium.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
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

On Wed, Mar 16, 2022 at 09:47:04PM +0530, Srinivasa Rao Mandadapu wrote:
> Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
> to allow reusing the common code in the addition of subsequent
> platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

>
> ...
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> new file mode 100644
> index 0000000..8c95d0f
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

...

> +
> +/* sm8250 variant specific data */

nit: the comment seems a bit redundant since this is now the sm8250
pinctrl driver.

> +static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
> +	PINCTRL_PIN(0, "gpio0"),
> +	PINCTRL_PIN(1, "gpio1"),
> +	PINCTRL_PIN(2, "gpio2"),
> +	PINCTRL_PIN(3, "gpio3"),
> +	PINCTRL_PIN(4, "gpio4"),
> +	PINCTRL_PIN(5, "gpio5"),
> +	PINCTRL_PIN(6, "gpio6"),
> +	PINCTRL_PIN(7, "gpio7"),
> +	PINCTRL_PIN(8, "gpio8"),
> +	PINCTRL_PIN(9, "gpio9"),
> +	PINCTRL_PIN(10, "gpio10"),
> +	PINCTRL_PIN(11, "gpio11"),
> +	PINCTRL_PIN(12, "gpio12"),
> +	PINCTRL_PIN(13, "gpio13"),
> +};
>
> ...

The nit is just a nit and otherwise this looks good to me, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
