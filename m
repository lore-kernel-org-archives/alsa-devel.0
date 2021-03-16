Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31069C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 13:34:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061616500A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 13:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061616500A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE3B11790;
	Tue, 16 Mar 2021 14:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE3B11790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615901679;
	bh=idW3HEXqnpPoKtrIJOEwKkOlMeoeugD0589MT+zozyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agLZ8OAOdRZCTkaGnJaxW3EJrh9ILnNP8maswT775pX4WT7NrRRvocS2VQt4r4FM6
	 RxQT3FlXPePpXVVyqW1+VUk/nINLTuvYmsHbIMptB1yjXCFzEJilTwKH5IccrdAwu6
	 Xnkph2e/KgFk8LEf2W6BBeBw43azVge967P7aR74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F022F80156;
	Tue, 16 Mar 2021 14:33:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B24FF80163; Tue, 16 Mar 2021 14:33:46 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28581F8013F
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 14:33:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28581F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="R+7ONg+R"
Received: by mail-qk1-x733.google.com with SMTP id l132so35162866qke.7
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yxhYiPJJfH15vXoqGY5Nr6454DNFIyQXelAI1Oeta38=;
 b=R+7ONg+RgbaadocUNVLV29LfFtUgU08qGOry13BkXZuUFBFdApt7Q1+HoPq95QNmmK
 2o3ieaXtCTwUuwJLbltLXooTvq9MOIcqDu2j31htqM9p/0qKnYJJG2FbX2hlB2DMQhHS
 wN/YFTNa2+/mIo9Ss9mOnnaK9uViykX44CgthMB7gKsSAtW2dYhUXV+zXJwEYdLvyjjG
 hhlZhAuWKnxeE3sC76kOrqtI+zQq8bHLJepTQ4Bp+Mt8ZOcv2K5z2/1zuQJPcf2gB9vA
 VIhQgygxCx7LeyWGzQTGlkeVXK8pHZxUrbGtLyGgYe+iOyb8BBHkxWWZH5E6i1l09S9V
 q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxhYiPJJfH15vXoqGY5Nr6454DNFIyQXelAI1Oeta38=;
 b=BRbEUd7pxzGzZGknBbh39ost+BWEnTAyWgoc1zmBaZR3SX8MkfdbvZKZDXhBuqqgbW
 gmTvcfUkDiFl+IdDE4Le9RgEl0yAIZM3lE0fQxyrOVjBTKjUbdDeK58it0qOzXwFlQSL
 6ObvuDeJxDBm8Gtn2udwQu7/2PHJ/H9cF3NOiXQnEWRWCLv+kceVaup6g0egdco2U2YQ
 +KFEq7g9YUdCu5B8nWULRM3WMHOe+Xie6lgKiDpU8MEgE37DmYOS3SvRT9R+LoHMkjVd
 MEaEE89/oUg9bJqxw+7fpOH61QY+nnJ1CMTdzLvPwhgGnjn5Em74iw/lYIrvZmD2dIj7
 OejQ==
X-Gm-Message-State: AOAM531GSo3G7FY6DscbNZ6l4sBjth40pSd1qqlyvF/AMBWHBxCylaYr
 Z0kEkNC49ncngqx6YiImlfshIRLQ0WeTdkXiHc8=
X-Google-Smtp-Source: ABdhPJykBK34HSDNuEExOj5PswzE1G8jMi/5K/0nsn1rodmf2p5QQgA9T0JNsjrPtdfQjvlMyoaxymcMxTUmvmisoS0=
X-Received: by 2002:a05:620a:718:: with SMTP id
 24mr30441878qkc.121.1615901611988; 
 Tue, 16 Mar 2021 06:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
 <20210316125839.GA4309@sirena.org.uk>
In-Reply-To: <20210316125839.GA4309@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 16 Mar 2021 21:33:21 +0800
Message-ID: <CAA+D8APfpXvMby-rKKodcOZaJHHsE4sAtSYV9JW867MLZTvj5w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Tue, Mar 16, 2021 at 9:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 05:27:06PM +0800, Shengjiu Wang wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> >
> > SAI software reset is done in runtime resume,
> > there is no need to do it in fsl_sai_dai_probe.
>
> People can disable runtime PM in their configurations - do you not still
> need a reset on probe in case there's no runtime PM?  It'd probably make
> sense to factor the rest code out itno a function though.

Right, didn't consider the case of disable runtime PM.
Will move the reset code to a function.

Best regards
wang shengjiu
