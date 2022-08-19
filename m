Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE4CC25B0E
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Aug 2022 08:52:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ABC215F2;
	Fri, 19 Aug 2022 10:52:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ABC215F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660899173;
	bh=Ve+ctJbtYKLwu+oiOEWL27N6fUcEIoMGbA6/2i8Fpho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UeyfMI0lostT7rQgM01Z44nXhbPRBsH1BAJYMlIqpgpX5zn+DxEHuo4GFJJTTDoIM
	 6r40f7RPFway94E9EoJ2Sk2+nBSAaXBOTdGP6gKc6XrZQrDE+7iccUQM7FUMKPwqcl
	 xPvd2KnTONALgR9QL8v7i3bO/UhREuEk/3dgjk1g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A18EFF80128;
	Fri, 19 Aug 2022 10:52:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F458F801F7; Fri, 19 Aug 2022 10:52:01 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 978CBF800EE
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2022 10:51:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 978CBF800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="blMjc/6k"
Received: by mail-oi1-x232.google.com with SMTP id w196so4100279oiw.10
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2022 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=nF0tn/gqHX2oF+4Z5pCAzKHZIqOMWauw7VYS0cwAOok=;
 b=blMjc/6ksopKkDzK5Zegh4Xaa2gWWCSmBGbBg1g5Oc94skjuei7Z8cN2xWs8mLwfSA
 EZdZU7741dKg5L40fpwDT9AtXZkm/9zMb30QMZoB800mBtS0sK5R4bYp/DCdwi9WLzTj
 xBjYsU4ZgfefRaDFE9KYGbljqrOPmLtG7UAroVbzFhEE7y571TjJg1IvHGfKHbucSvub
 nggJMerbg1UGKacrAOxu8iqH++pusk8sL2MnVQmnGVciC+FAczlchs76hdTV0oesbYLK
 KFOffT5mH62nfGubDd/hW/+nuItXDRT6bOnrRKEqouuJFcT0c5cmMTpDvuvtvPxs7Xs0
 S2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=nF0tn/gqHX2oF+4Z5pCAzKHZIqOMWauw7VYS0cwAOok=;
 b=QZAqFflBaXjKlRoPta++cpPe7h6Io3U+8q6TLLdNmpXmTgMsBT5uSEzwHBCP39I6z9
 xCr8L7ERMpSiYOsw3toGNkPaDGxlA5d4Qj32VgQsig+Y2FVKbgjlchvq3cNoSG63ft+k
 U/v1fOHeTHY4pE/z4PnC7fO83px2GBayDb6HJKcaVa28/QcBaQ5q06xWVrFnd4JqKFYJ
 rhhBAT2GY2NbJFK4JW6lS4NMRQ3vdqdg73Bav/ixUHs+4l9C6a0aTpBO9g4mSh4h3cto
 Y97+xGHQodjw4rkC1Moy86pMkbDChtwMtsxJUvdjNG9/ut1x/iQROmmthpaX+ud5Yg0D
 dk6w==
X-Gm-Message-State: ACgBeo2hVFZlkwO725HlUkAFkjC6hakeDucr16U7K4jMqT46pRNulsdO
 pIVmXFvr6bfJ1VDZt4KzUlN4y6iwSYYPU0YFZYYLnA==
X-Google-Smtp-Source: AA6agR6UqzK3ndt0r/lpsmdJ+6+R3XX8weq5nK6uHhY5EviJWIuX2wqEG8EgXjLsPA7Dr2zeXhLnFJymLvNXn75T5fo=
X-Received: by 2002:a05:6808:3:b0:343:7d5c:ac50 with SMTP id
 u3-20020a056808000300b003437d5cac50mr3057270oic.108.1660899112103; Fri, 19
 Aug 2022 01:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220818035105.5510-1-steev@kali.org>
In-Reply-To: <20220818035105.5510-1-steev@kali.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Fri, 19 Aug 2022 14:21:14 +0530
Message-ID: <CAMi1Hd2uqbs7mmX+FbNxsnqxTCkBW1CbR3En5f+ov7XZ87qPrA@mail.gmail.com>
Subject: Re: [PATCH] soundwire: qcom: remove unneeded check
To: Steev Klimaszewski <steev@kali.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Gross <agross@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-kernel@vger.kernel.org,
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

Hi Steev,

Thank you for looking into this crash. Srini submitted the same fix
earlier this week
https://www.spinics.net/lists/alsa-devel/msg146137.html

Regards,
Amit Pundir

On Thu, 18 Aug 2022 at 09:21, Steev Klimaszewski <steev@kali.org> wrote:
>
> commit 1fd0d85affe4d6 ("soundwire: qcom: Add flag for software clock gating check")
> added a flag for software clock gating check, however in commit
> 33ba01788889666 ("soundwire: qcom: Add support for controlling audio CGCR from HLOS")
> the same check was added without the flag, so we would still end up failing
> the software clock gating check.
>
> Originally reported by Amit Pundir on DB845c, I also saw it on the
> Lenovo Yoga C630, right before the splat, we would see
>
> qcom-soundwire wcd934x-soundwire.6.auto: Failed to get audio_cgcr reset required for soundwire-v1.6.0
>
> however, SDM845 has a soundwire-v1.3.0
>
> Since the flag was added in 1fd0d85affe, lets just remove this one.
>
> Fixes: 33ba01788889 ("soundwire: qcom: Add support for controlling audio CGCR from HLOS")
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 709a7c1e0704..b621f7fb866f 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1355,10 +1355,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>         ctrl->bus.compute_params = &qcom_swrm_compute_params;
>         ctrl->bus.clk_stop_timeout = 300;
>
> -       ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
> -       if (IS_ERR(ctrl->audio_cgcr))
> -               dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
> -
>         ret = qcom_swrm_get_port_config(ctrl);
>         if (ret)
>                 goto err_clk;
> --
> 2.35.1
>
