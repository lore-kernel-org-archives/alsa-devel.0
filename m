Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89081C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:10:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97696145A
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97696145A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D7F2843;
	Fri,  7 May 2021 13:09:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D7F2843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620385841;
	bh=XNLV3v3FLvWKUeQ5ZjEMabq22Hy89QQ7yk7qx9tOO2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlM1UeHF9i7CYeyCv0EFgK4309Sx+23s9qgBXZFx3mW5m1m5y5rxiq+KBIk7dj2F4
	 3FhZ7P9EPhSDtfoWe4wJh5Kn/Q3ZTlrNzEOpTK+nqzE218oVEP7RqLFtxwEgAnBdLI
	 yXAmE7a+pu/GngcwQmc0WPQdfR0GDVYTY0BufZHk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E342DF80257;
	Fri,  7 May 2021 13:09:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDC00F8021C; Tue,  4 May 2021 15:29:30 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53122F80108
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 15:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53122F80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zliUgqxP"
Received: by mail-yb1-xb35.google.com with SMTP id l7so12112687ybf.8
 for <alsa-devel@alsa-project.org>; Tue, 04 May 2021 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/BRhTEpnUP9fxfD+K9LGEgYyn57sT/mfo8VpaW+h4gg=;
 b=zliUgqxPji85MVuM2cxAmdIGtLCvTweTUHzYvjqkyKw1DFdDKq1FgLiw7mV9pHwZsK
 UNYPWJ8+d1pv3FHKwG+OH5uACLhSBfrX5oUh5tEeyGl1cSRpz40BunyzXFyCXT2NNmVY
 9XkgSQwzpmQWggXaG9OzAErU5CCPo5vc28rxA00FE8xrZUISN9W7KnFZxzrShWZ4IyWH
 0zHXDQAFrYohnLuRoHW9kJ5IMg4giaOwn5NnzlagJ7xjhIMX41k1UugAvKn+9fpmGMQi
 +pgHNzCz7T726HaoYWMzFwmIThbkuxMzph2vv4CsK/fZQNjKt8F+7S2Uz6cFMHr4QvbF
 JwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/BRhTEpnUP9fxfD+K9LGEgYyn57sT/mfo8VpaW+h4gg=;
 b=Y6lTvrli2Gu1EFA6kWWOIUjXYVWXljQVGQdSxn9EN/kwcZAw/oKYyyRqqedYp5q89p
 0qQibRXmk98A7rBZzaLDrVKTRiNSh8bEercR+daLA5KiU/9gnEjmwUS87vsh0C4zoFfi
 gmS24nM7CG3egwJJDsb6D3QODIaJKDwnHM1NJY7Kp5LROlTuvHeWpA+Gp2OKtpmQ+uW6
 PCTjFFChL2z/jxyFDG5wXvjFcAEFmAIy5PG7xji6qL1YI8MX795woSM9YruFCQRVh9dD
 M08SxFKDsdNS2q7YMAUFBvsg4LsAQVgMu3mU/JRquS3u+6DOmJI8rK+g3GWQJW5zSnBj
 0QOQ==
X-Gm-Message-State: AOAM530mPpSZTpDHTB9XYSpaTCoerqxkiBByGBBQT8IhrDhOLx0XZoux
 frIThi98QJ0z2uZqWh7PeZ/9zz2cIrWtoeoBadH4VQ==
X-Google-Smtp-Source: ABdhPJwjcqLzq5cHFekTHgpc3kqBBbnRLj4YJ8atyXG840GdCFl/o7yDSxXGW3nl7DG4qFazGfogmf6GNa3C7phTrw4=
X-Received: by 2002:a25:c681:: with SMTP id
 k123mr35487853ybf.303.1620134960204; 
 Tue, 04 May 2021 06:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 4 May 2021 18:58:44 +0530
Message-ID: <CAMi1Hd0Fxj2Y_ZheFGveCpz1XWHhOOx3UYz7xW4-8RVAN1TPAg@mail.gmail.com>
Subject: Re: [PATCH] soundwire: qcom: fix handling of qcom,
 ports-block-pack-mode
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 07 May 2021 13:09:49 +0200
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 John Stultz <john.stultz@linaro.org>, sanyog.r.kale@intel.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, yung-chuan.liao@linux.intel.com
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

On Tue, 4 May 2021 at 18:29, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Support to "qcom,ports-block-pack-mode" was added at later stages
> to support a variant of Qualcomm SoundWire controllers available
> on Apps processor. However the older versions of the SoundWire
> controller which are embedded in WCD Codecs do not need this property.
>
> So returning on error for those cases will break boards like DragonBoard
> DB845c and Lenovo Yoga C630.
>
> This patch fixes error handling on this property considering older usecases.

Tested on Xiaomi Pocophone F1 (sdm845).

Tested-by: Amit Pundir <amit.pundir@linaro.org>

>
> Fixes: 5943e4fb14e3 ("soundwire: qcom: check of_property_read status")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 2827085a323b..0ef79d60e88e 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1150,8 +1150,16 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>
>         ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>                                         bp_mode, nports);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               u32 version;
> +
> +               ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &version);
> +
> +               if (version <= 0x01030000)
> +                       memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +               else
> +                       return ret;
> +       }
>
>         memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>         of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
> --
> 2.21.0
>
