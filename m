Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76AC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 04:12:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610BB64E89
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 04:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610BB64E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F826168D;
	Fri, 19 Mar 2021 05:11:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F826168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616127122;
	bh=6eaIzUbrgC2deVc3JABdX0qrF5d1KkLxOnLeskou7fs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuFa1PX34jqazhQsRTE3kc1QGI8RSWAcQYD+A9bM9p0HXWvb3OkS+NF+39FkuPDUv
	 T8BgagmfG+VfihGP8IJ2XIcT9Wc8fc+xRXyG1w7Kv6qNtv5BoEXTYFGjbxnIAZHtT/
	 X9rHzsZsQNt4/v6TcwX1ljUs8cBlE2DFmG6qiUR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFD72F800BB;
	Fri, 19 Mar 2021 05:11:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6E9BF8021C; Fri, 19 Mar 2021 05:11:06 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBA99F80124
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 05:11:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBA99F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NI0jLE++"
Received: by mail-qk1-x72e.google.com with SMTP id c4so1643323qkg.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 21:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aaqZ5Xka3NFx+U71V6vC4ru0MXh/qF63OiW6ltUtrL4=;
 b=NI0jLE++PD268TEUsgTuwXAQEtQ0DqWORhgI3TDVqilngZgb2T7BzCI67g1UWdZe/7
 OzmvhEbfa+AfFzDtEx0knv8QT1ESOaaPMc/cYIoaSy34gTlFrT8Qv852alxW3Q+lcXJx
 LQDa9dJlw1iqfBK2+zWUq/5cLb30A+nOlfkFhnl0sqXC7v7sU+MumB803mAy9VRrFCDI
 kvWOnjTBj4CeFsPP3BiBGNq1KEHly/IeS8Yjhj+SPwjyPXuAAG8LsZl16S/v53lL0TEN
 9plCewyCIZcBR6i0iazU6D3yd8uYE0mFaZpjsx5l6TMFTy9ztlZf6DxouOTPzldIhzx7
 LyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aaqZ5Xka3NFx+U71V6vC4ru0MXh/qF63OiW6ltUtrL4=;
 b=p6Mr1ByCGwlgXnJKGdDaXo5HVrLM3eo7gNEMfLXuRmdaM6D9peeVXErR20MIQ+ydfh
 klTfJWOPmbjM5/BbZRJqmK57mwEoEnhB+WfRZiEWAUah3gwEP3YikvMtRVgucZ+miWCK
 R8BicqKoG96fPrSzbyjEaALtuPM4KyDEE5uwwFRxJBfrU0z/VsEbCBAKUQyfRRXR5Tzq
 UZWB6dyT0wXn9iWT9UuFFdLIoJv4rzHh5XeD87gBSU9lHce3h2dr1FkWpeh89b8S3vDG
 esF+RWdxf+CeF3MUeISB1/WUvLitzedAJ3zseqEPV1P9PziDlK9NfRpVS7bpyVCPYFH8
 SqRQ==
X-Gm-Message-State: AOAM5307erGCwF8YGoQ38s/2SIaM9Fo9jZjbrh8uozLp30cz+ECSce5b
 hXvyLv7LXDPBTY13gJPJpIJgKEd4/pU2YCEp+C0=
X-Google-Smtp-Source: ABdhPJzSglnF+PloSPSyO4A9pea+8tGafdjSrifWXMts+rIqOZ1H55BiTRHYe1r1wfNKoEJ/HxJR8YAxSIn9uipM6Ms=
X-Received: by 2002:a05:620a:102c:: with SMTP id
 a12mr7643841qkk.450.1616127059424; 
 Thu, 18 Mar 2021 21:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
 <20210316125839.GA4309@sirena.org.uk>
 <VI1PR0401MB22721D0D266207472B3C7829926B9@VI1PR0401MB2272.eurprd04.prod.outlook.com>
 <20210316134915.GB4309@sirena.org.uk>
In-Reply-To: <20210316134915.GB4309@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 19 Mar 2021 12:10:48 +0800
Message-ID: <CAA+D8ANuUWne1nzGH6=V4nj7YMRczuZ+pH--eJ+ghiGWfo_0sQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 Viorel Suman <viorel.suman@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Mark

On Tue, Mar 16, 2021 at 9:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 01:42:40PM +0000, Viorel Suman wrote:
>
> > To me it makes sense to manage the clocks and reset from the same place.
> > Currently we have the clocks management moved completely into runtime PM
> > fsl_sai_runtime_resume and fsl_sai_runtime_suspend callbacks.
>
> Usually the pattern is to have probe() leave everything powered up then
> let runtime PM power things down if it's enabled, you can often do the
> power up by having an open coded call to the resume callback in probe().

It seems some drivers very depend on runtime PM, if the CONFIG_PM=n,
the drivers should not work.  What's the strategy for this?
Do we need to support both cases, or only one case is also acceptable?

Best regards
Wang Shengjiu
