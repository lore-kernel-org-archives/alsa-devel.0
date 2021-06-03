Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C854C47083
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 02:56:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF42613EE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 02:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF42613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27B9316E3;
	Thu,  3 Jun 2021 04:55:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27B9316E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622688976;
	bh=/mhDqnOCO8oOSE1QbJYdewgtEXJPWp5C6F1jbsEoMRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuKyjTnUnhOly0mVctt7QKpZsPq01lNSeeeH4kgYCMVHuu2VenhHpwzrcooGMDD3H
	 B04piT6asmQ7TzS366Es0B15VKsZwqeTF3z84JiR3cmAjeJaT11VGE562y1nUwL2rp
	 bYCWzfzF4WIJhqY8MrHgEliRrQFMZ6wv86cwaqWY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92AC8F80100;
	Thu,  3 Jun 2021 04:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFEEFF80254; Thu,  3 Jun 2021 04:55:21 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34BB0F80100
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 04:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34BB0F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lAu355Dg"
Received: by mail-qv1-xf36.google.com with SMTP id m6so2527839qvg.1
 for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2021 19:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L3qETxpua5Szzx3IugrqwdN2RVBVS+htIlKHHGHgjcE=;
 b=lAu355Dg9iol96NUognh3Z9XUcRdsebrjJDTLIdA0MB3bNopNWwQxCdRUYRX5sAb/Y
 cGUf0l8eVRCedzkRA6AGkEjrkmrHlWSm7nvbhYMMLu9iMNPphZ5SZ/a+Bpa5bo1aiYEo
 dIE2o8o3V3yvHP9fvL9p26aKPWF1n1rF1uiUk/ohboF9EEsQGAsVDBlQW58TXUp3RdAv
 Fvk6VaayMCGK4kT7U63ylfbABmr93wlLZ8IEFKsunB8FgRlvW0igaOt4Ss15ZGYruu2R
 oc0Y44YuKWQTykQrCrMj0huXHvbxsxHM3HDo28txiTevaaW241YRYpyfEsHTd6HFCrO+
 puLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L3qETxpua5Szzx3IugrqwdN2RVBVS+htIlKHHGHgjcE=;
 b=PJ+oaX3kq6U+whBQVnNmpQ5iNFBHNY/dTWKT6vcEuw10/aulPlti61CWgepmHfisHo
 M76QVm7ul65FwX0EablyzsEm46IiLX7A+HLJKEYCZ0rbWegXkRZ63NSC1KUCfa8xHckO
 4KhrO5vRgOsxgz/wY4BSzIFD2GbmOqhmwrQpOyKnZxe4cf6yymcYNJ/qVn+klMXImD1I
 GKxpXhKZVEJZU0wxnWEsatOgxVD7u+DKx3YCQNbr2NaNZ2o/j2/WvqTfxvrssQCzBKI8
 DKpSFbb8RlIDNXIRRohO96j/iZqP8QOZqmsTN7Bs8xZ4rYUJM2WbHXMflpOKWRBK/OgV
 WxfA==
X-Gm-Message-State: AOAM530zY57C12d/TU7DsMitkV/o7CieI+uttLA14G5bqcF0A4+0ulls
 7SYFDYSd3rg09A7E+Z/XYzLPAYovi8S1i6BS+v8=
X-Google-Smtp-Source: ABdhPJxezezpVM5btuESQMr8sQAiEXZQElm22pIaMrpGjdBnAbnRFJ9jW78E4wHzQhgfJltscBSnDG0cUu3iIS9EoZk=
X-Received: by 2002:a0c:dc92:: with SMTP id n18mr8866816qvk.8.1622688907466;
 Wed, 02 Jun 2021 19:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5An-v0mLAvjofiWLc4ufJiE4EzG1b4NDwToPSvgODrHjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5An-v0mLAvjofiWLc4ufJiE4EzG1b4NDwToPSvgODrHjQ@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 3 Jun 2021 10:54:56 +0800
Message-ID: <CAA+D8AMYmy=NdQU+9gTwa_7j23kmxgU1Xj-pkzuHPCNX649iYQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer
 probe
To: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Wed, Jun 2, 2021 at 11:45 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Wed, Jun 2, 2021 at 3:59 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > Don't need to print error message for defer probe
> ...
> >         if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
> > -               dev_err(&pdev->dev, "failed to find codec device\n");
> > +               dev_dbg(&pdev->dev, "failed to find codec device\n");
>
> You may consider using dev_err_probe() here, which fits exactly this purpose.

ok, let me update it.

best regards
wang shengjiu
