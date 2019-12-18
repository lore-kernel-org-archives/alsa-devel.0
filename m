Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE9C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:00:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A5B2146E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qh3niAs5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C+CCtImE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A5B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 214EB852;
	Wed, 18 Dec 2019 22:59:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 214EB852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576706433;
	bh=I71RRmmkarsE8VEsBK7HDpxA23+eXQmWmqTAjavXBmY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qh3niAs5Ogq8SnUY0jpApPom2PF/5wC1kEF8LpLSmSHjhRvmGniI+tXJ3m/FHKg/4
	 egsFzEjbLxpcl+lAM/Jf6BJhtV8dr1iat1Y8ZkIRBr73JELwnLRxdyEjPJEAVOgVEM
	 xxsbATZ3H195tEIh3OOfVqpGtiSpsMp/o73eUkhM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95137F8015A;
	Wed, 18 Dec 2019 22:59:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD582F8022C; Wed, 18 Dec 2019 22:59:40 +0100 (CET)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2611CF8014C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 22:59:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2611CF8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="C+CCtImE"
Received: by mail-il1-x143.google.com with SMTP id t17so2999352ilm.13
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvw95NiaPAJ5Y25HNRYxnbjjR7EmkANyyvN7fRFlK5U=;
 b=C+CCtImEhdC9zTlppoB86nKaWJQTH6C175e37IwHmoQ4TST0nxcWqygR6Fwd11X9tz
 ghpDDCqGQUSs0OUVsj/758tvc/VLKYqHHc2LQjRIsCF6P7LGfJ1vMXIyKRfffpr+xuku
 C5teWaPeIDQ+hBituAKD1f5fQBJXfeCf3yktQtwqTaqfsrkE9y4gd0SthRIdWdF3LGNe
 pyzJQGgsMeUDfgOhE+v/JFapWTDZp520ydD53QrJN3Vbo6hV4Q44g/ESOjesPuzFv4/2
 T9Yg2eGuGwiCCvY5+VVWuEpr9vcYJ1IiT83C1egUNn5U4TJlRHEPruGDuWmVR2ppd+sj
 CFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvw95NiaPAJ5Y25HNRYxnbjjR7EmkANyyvN7fRFlK5U=;
 b=qGcU24JrnFIXv8pdkpcTpQ5kVlblYauCK1PJqAQ4OhEl0fkgl8S//vzoFwJg4qhJtF
 loRVL7G7VsokUeCuI5K3QRB/Fzkr14o99GVd1gcHDAtEhGsYc5/Y3HOJw8jmmLATNK+o
 Qh/u+v1yfiLVEt3G3tPN1v8B6F+OuSCeqdpjw3nDgs/CUgjdurCsnWR3ZPhwTFKOXyrZ
 qWIwiUdmjHR6bUQC/qHa94PLZ/65eLVPEZGhNlcFDmZLH5RLK+xt/w5a5Cz5/2KQ2KpE
 HjbCW6TCxY1O2uQFN5IpOgIiwfCUwz4KitRI2ZPAaxaTqG/q2rOYTzfZY3Bo/nIBXYFW
 MS5w==
X-Gm-Message-State: APjAAAU/nO5x7DCEL+ibhp6nbSnJLDxAuYB6Gz/WiPtNQm7Kru+1SjgH
 PLU89iUMxFCoW4MM1b6e56VTlm7QW7lagwmfDii5bQ==
X-Google-Smtp-Source: APXvYqyATbBjbPrjVL/AdalN0+mAq28zeNSqQNIsoZRuGoE6nnyDzaRTKV2mafFX/sLIrVWQMgMtua041pc1Ub0zy/I=
X-Received: by 2002:a92:99cd:: with SMTP id t74mr3766725ilk.213.1576706375621; 
 Wed, 18 Dec 2019 13:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20191218185938.38282-1-broonie@kernel.org>
In-Reply-To: <20191218185938.38282-1-broonie@kernel.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 19 Dec 2019 05:59:24 +0800
Message-ID: <CA+Px+wUBdCt_VCmKHSpHmi9WO7_eQAxSVZL+Q3oLMdH6C-RtNQ@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090: Remove empty suspend
	function
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

On Thu, Dec 19, 2019 at 2:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> The suspend function is empty so can be removed.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/max98090.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index da23810f958e..68271042f586 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2838,15 +2838,10 @@ static int max98090_resume(struct device *dev)
>
>         return 0;
>  }
> -
> -static int max98090_suspend(struct device *dev)
> -{
> -       return 0;
> -}
>  #endif
>
>  static const struct dev_pm_ops max98090_pm = {
> -       SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
> +       SET_RUNTIME_PM_OPS(NULL,
>                 max98090_runtime_resume, NULL)
You replaced the wrong "_suspend".

>         SET_SYSTEM_SLEEP_PM_OPS(max98090_suspend, max98090_resume)
This is which you should replace to NULL.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
