Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D49C48BDF
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 02:23:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96F660C3E
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 02:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96F660C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42F7B180D;
	Fri, 11 Jun 2021 04:22:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42F7B180D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623378215;
	bh=VJJU/fMw5bQhr/bb0mvaJZ77AQmkNAvOg0+Tf/jKDx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzramcZmITiNY4OTelJtxCbEMY86vH6UR54Z/sOLQiGbw2KazS0dCeLwmnBIzi/K+
	 BnonU/2pTf9kqqZq8LH2LunxMxG/RpgY6TUeRiZy1UuSxauPNft3IX0rDt6ERGoTEM
	 +H4in4e58ce9N5QxttECAmKAO1dng8CnNI6EUxAQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D54BEF80212;
	Fri, 11 Jun 2021 04:22:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 898B8F8026C; Fri, 11 Jun 2021 04:22:42 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A31FF80149
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 04:22:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A31FF80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="nJCere7L"
Received: by mail-qk1-x732.google.com with SMTP id c9so3201877qkm.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 19:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
 b=nJCere7LOSrhMIfWD9e3SYHFAobt75P+qmj3bZ8wly9ssO30SIjc03f5DOKJZBgIrA
 E1CRT2L2mbWltL8t/yPOo1LFACAc56vOI2yhtRTYFHMnO1tlshUUAkMo/RCMCTWukNAx
 p4jf2YOSVxJkWYq/J1pj5v80b6kvfUsdHzounC04d8n6tv2dT5bTCioZqMeukW6Jhp5t
 vPA9GRhD2pNsr23B0/yiT1HF+mVB/J6gG4E9zuhEXGUvJbg4X4GdhE9/6hiWSmOihT1s
 tF9QNNLxQU4+YpiG3PxT4qDlp7LH/F1LjfsFcEu4eZh9EWvirF6S2KVBZMDC0Pf2mWZW
 tFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CTFlovwtrqxUOZ0WoQulGA+S/cNwfLiqBtlEH+BQzqQ=;
 b=ey2+S1qffdOkQPcQJdAFvHiu6N+VeUKy8/lGWxxjeLc4pJX6RvSepV37Enacyf8MM8
 NMAEiKJPUdTfdK1SmyBlHoUgag8Kk79RwGw0aibSqheqUyoR0pBLcgR66z5d9j/bCCmQ
 jMKIAapF+xNzs8Kr5jxnxd/qexTkZOqScv9DeesmWPU3xA6lzEgvYDznTokbcJmK+w0M
 ebYyjJQxCEEjMwfY88TEBJpAy5Q0kNZCkXYZ3ftWB3ctMQKfQwr0NGp71ouIns/+pNSu
 BPXfACiYCkVlDaRA7FL+OBWR/uQD6PWPZsvHE6UJ2W4aXSi64utG0Kz+7EE9PSfOzyE1
 ak8g==
X-Gm-Message-State: AOAM533FEeHLyU8hhl5yET5/DEp5W7e4/3jP4VEATrEQAoj10sm1T91/
 Tm4tpnElVYW36p6vYgqhJma9bxQz5N7ciK4RcPo=
X-Google-Smtp-Source: ABdhPJwVE3MlwWUimCYQvJayxGP7hU75ji8nembIFoLu6+sidUiX6/wx3tIsymXPfJaTimO7t79BV4a5rJbWDLVHbIc=
X-Received: by 2002:a37:af84:: with SMTP id y126mr1725374qke.450.1623378153832; 
 Thu, 10 Jun 2021 19:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125052.1280-1-hbut_tan@163.com>
In-Reply-To: <20210610125052.1280-1-hbut_tan@163.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 11 Jun 2021 10:22:23 +0800
Message-ID: <CAA+D8AOHdArkc2mM--4yLLpGyEzfZb241MWj+10JjezXY_-UZw@mail.gmail.com>
Subject: Re: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around
 platform_get_irq()
To: Zhongjun Tan <hbut_tan@163.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Tan Zhongjun <tanzhongjun@yulong.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Jun 10, 2021 at 8:52 PM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Tan Zhongjun <tanzhongjun@yulong.com>
>
> Clean up the check for irq.dev_err is superfluous as platform_get_irq()
> already prints an error.Remove curly braces to confirm to styling
> requirements.
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl_easrc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index b1765c7d3bcd..25747433916e 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
>         }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "no irq for node %pOF\n", np);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
>                                dev_name(dev), easrc);
> --
> 2.17.1
>
>
