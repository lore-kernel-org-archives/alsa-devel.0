Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E98C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 05:27:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F1431742;
	Thu,  7 Apr 2022 07:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F1431742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649309257;
	bh=28th7LaOg9vrHcurH3SfaQFHYEAGGP920UtWhOdK8Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eK4bjhGXurDTUWDTaJKR4Cka5jcLdHe5wyaoPkvUQEA0LI1+R+yDEmXxlyMYozXtS
	 Qhkf3jxglHQLK8o7KvM1gwCyVTBrhf6ytvQSi2e8LSR36KTNe6qaNLI2oLF1GvjpNH
	 JctVXNsvPjisVrZBhjNzs1XYzUmvqAU/asc5vNfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 211FCF80141;
	Thu,  7 Apr 2022 07:26:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5A83F8024C; Thu,  7 Apr 2022 07:26:45 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 979A7F8012A
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 07:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 979A7F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="FQYO8Kar"
Received: by mail-qk1-x735.google.com with SMTP id p25so1360436qkj.10
 for <alsa-devel@alsa-project.org>; Wed, 06 Apr 2022 22:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mcC8x/SKEBo0jwqbW1G9U672ZHmqA/XXs5+KjFXDsL8=;
 b=FQYO8Kar5DgrQSgdz5aiLxbnyh+r4zbuBH3QfiOY6FPF51jnD+9RBE7AG8H7rhuhXw
 9pUr15mKcLvyH6WGeauFoKHP99py4xFCIs8vWyjMs0OlQVyvbTdbAtk43WWyMj96rnkM
 IKsxVpqj0rsTZWB3OV6BwUTGQkPZHIMUzDPmA7sZLzAc0rtrFymFr1C9ewxTIejAO42K
 ntX8u4zVl7bwjORhVUAbuyKwIaghccPu8QbYnPUQvTusUnFR5kmUh/OR2R2gax/Ae+dY
 K1tqAaqQ2Nl4bWG0xkR6xZed6JnQb3DOjRKYzAgjQw6obmi5zE6WdUNy4PnIDDdggQzU
 BWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mcC8x/SKEBo0jwqbW1G9U672ZHmqA/XXs5+KjFXDsL8=;
 b=PQiCpaUZ3C84iPt3XgKt2eyOdVg1cJSTMEwmax06jujP6YsMVSoXOLMBp1movoBQlu
 o1QxUAv9O2e0RPMK+DtmXTwOlJW4/tKb0HOJ5eQDG29QazV8H7QJYP8AlpAq+MGjmaas
 igIvXMigo3ktUdIX1WNeXaKhBBY4FxFix8NmJhOffXwAMGA6ku1+Zf2P9G2padZx6ghI
 Vq5RP2WHCqKNeiJDy9OdvHx48QxoB8QcN4HQIL2zxhP1sKW0YRWwVCbL1kytKt2tW/tM
 LHizP0xHVrSKuntKmWwPP9q570Scq926CZt6gOh7t54uH7nVpGQoYqCgY8RnX+d6EeRy
 PPAg==
X-Gm-Message-State: AOAM533K8qUWl+3PuloGyXc1FWwrImLnhqCoOlovwonm0ipqrXpZ7OX5
 JcoTvrBep9jEKixgP9/qZmDgNyJ54Oql1ovRhb8=
X-Google-Smtp-Source: ABdhPJwqItMFdFAUrW9nYh8ut06w4oVvnMNytCh4AlV1ZkkImUNHd/cYjrhaE/agCIkje0pITowAOr4BXlKm6RRDWQM=
X-Received: by 2002:a05:620a:4592:b0:67d:8ed9:8c37 with SMTP id
 bp18-20020a05620a459200b0067d8ed98c37mr8177638qkb.150.1649309197866; Wed, 06
 Apr 2022 22:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220405075959.2744803-1-s.hauer@pengutronix.de>
 <20220405075959.2744803-18-s.hauer@pengutronix.de>
In-Reply-To: <20220405075959.2744803-18-s.hauer@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 7 Apr 2022 13:26:27 +0800
Message-ID: <CAA+D8AO4JiGPFCUD1A=knF_LKVgki2ykBE0L2+W0U_oE8DXpAQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] ASoC: fsl_micfil: drop unused include
To: Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>
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

On Tue, Apr 5, 2022 at 4:00 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The micfil driver doesn't use anything from imx-pcm.h. Drop its
> inclusion.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu

---
>  sound/soc/fsl/fsl_micfil.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index e28a2e2ba5c97..f7742a6e6c204 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -24,7 +24,6 @@
>  #include <sound/core.h>
>
>  #include "fsl_micfil.h"
> -#include "imx-pcm.h"
>
>  #define FSL_MICFIL_RATES               SNDRV_PCM_RATE_8000_48000
>  #define FSL_MICFIL_FORMATS             (SNDRV_PCM_FMTBIT_S16_LE)
> --
> 2.30.2
>
>
