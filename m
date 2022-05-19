Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E500C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 19 May 2022 13:24:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AA7B1638;
	Thu, 19 May 2022 15:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AA7B1638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652966654;
	bh=nOqlLiouW4W1hf7pD7RNU3wPBkihHgj7zIs6YeqN0Xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JB5sRPdld8tw4rXqVldFnbHXPgGXdM7TUBaSrMkEEtHWW8BeK07jl4/LCh16EZPM2
	 xV0KvLg8+/+MWcZvLcXAhLZPpZXzZ/AayCspMG+U3nG0humCjgZK5QRm2WFsvxMpBe
	 iLXFpYOwWJlaZ6TCtcCVfWpGszl5+sTulqB1ajYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EF6DF80237;
	Thu, 19 May 2022 15:23:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A5F9F8025D; Thu, 19 May 2022 15:23:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A0FBF80109
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 15:23:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A0FBF80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kqyqe4kq"
Received: by mail-ej1-x632.google.com with SMTP id i19so9886004eja.11
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2022 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u0w8abIetG2abMfdqOSd7Y82vyjnsYTVbT2dM/SJUnQ=;
 b=kqyqe4kqxe8fIM4wT/Lk+TKu3gZPfVVJL7C4awAbF1WarDBgMnhX/jTNZMl/vxTt85
 O+Z6wBabc4+ZNCx8n0IHE9REoVXdCMvPJlFCnZZYhFj1hzZxP+8mcqFOUhlVZbDAzPre
 Kc/q7pYmg1xfxtbb3BFBaHJS52S/wJHPIZsXAseZ8vOuQdzGf7Q8TolTfts249OnHSX2
 Zvvj5lEJ4vqVz5G0WslC0SbW4MlQrCVSSX7e6+KrAampo/iIcwlgZWo1YulA6XmleJ2q
 lrwd2wIj2hyi5kx1AWJ3qxAkGhNfEyLpl2qlX5PGPoPvv92sBJrzSyZNuz9JxC/w48oG
 d3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u0w8abIetG2abMfdqOSd7Y82vyjnsYTVbT2dM/SJUnQ=;
 b=SXGQFxIJG/BstgAR9anSqxZhQtgNAWh/fhYyFIZbwiZGmP4IUwMvnHpwVu+oG/+pMr
 jhfs05Id1lqJueEgfR6pHnvT8Am0RXHWFoaOiP6wxXmnZe+HSSs5PNsMxwNLXO5eiLj6
 +FoOHg3n3c6BCHRSqFty6nqVf9lK/0KyvUpknQ91z3RDPgUF9+IqKnehjCFgXVQmjPp1
 vNr54IeHAeRs3Nme159j9Iv84OoOCQImGQQARCFxqjk+uVQxtvVvzS+E0logQ5GhacgJ
 l+Lp3n1vuFGcXBqZWpdjUyuUgfI3AJV+2MKxJHqGGWqryAy9Gkfv1LlTKxIZpyfbBjZ8
 lKKA==
X-Gm-Message-State: AOAM531hluKWpFUoZ8IQZ3aGL1HE9R8SfNfKw5+vOg2bAjIHJk4NHr6u
 3eQ/+4wUqN25F3U2t5l1w0No3nh7ZkriAdMp2aY=
X-Google-Smtp-Source: ABdhPJxNRiGcRFJtK3UBMZH041EXrP1arR0vXHoGPqJhbNCeJrxP1aggikIpmh71PFSM0Xke5vQam54J3vaSYyrXjBg=
X-Received: by 2002:a17:907:7b9f:b0:6f4:d8c5:392c with SMTP id
 ne31-20020a1709077b9f00b006f4d8c5392cmr4265502ejc.652.1652966594102; Thu, 19
 May 2022 06:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 May 2022 10:23:06 -0300
Message-ID: <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>,
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

Hi Shengjiu,

On Thu, May 19, 2022 at 9:49 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index fa950dde5310..dae16a14f177 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -437,6 +437,12 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
>                                    FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
>                                    savediv / 2 - 1);
>
> +       if (sai->soc_data->max_register >= FSL_SAI_MCTL) {

Isn't it a bit fragile to take this decision based on the number of
SAI registers in the SoC?

What about adding a specific field in soc_data for such a purpose?
