Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46DC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Oct 2023 11:37:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7B251D7;
	Mon, 30 Oct 2023 12:36:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7B251D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698665861;
	bh=csnOKH0S/yzTOhLnRQCy767OQRSbbASGrw4KMOOKM64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rYhiow3scpfrqCJuwEng1uW6nF/xc/RKjJ6ngKD2Tcv4b5IMroS36DKplY+UzMiOu
	 tPiZfD4puaGSzxIveW+9g4jXUsn6aTJvQlL7KphM9UHfZxqDwCFNu0KsaaRlPZ+Scj
	 zxMSDUgQRB1k8zqcf7BXH1N/+4e9ctqfjp5RjJGM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1957F80166; Mon, 30 Oct 2023 12:36:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A30C1F8016D;
	Mon, 30 Oct 2023 12:36:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3915BF8016D; Mon, 30 Oct 2023 12:36:16 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44F62F8014B
	for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2023 12:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44F62F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Yc2kH68Y
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so648081166b.3
        for <alsa-devel@alsa-project.org>;
 Mon, 30 Oct 2023 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665770; x=1699270570;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csnOKH0S/yzTOhLnRQCy767OQRSbbASGrw4KMOOKM64=;
        b=Yc2kH68YqDxMz6+iOLBfjKotPG9lKxvlk4Ly0BJ5auwOJ27YfqVD+Y0maoPYqruIRx
         MV7lnjdD32QGMuQwPuEUP46+O6yOW/MBOrZoRDCVBncrFDvDu37B2EWFPFc8Wh/3rWsK
         hdgn3MJ5FkTFyk0+d0a0GDByzO/iA5WVrtRNySojmDQRFr279ANrISwGNZSxTo/BNP2e
         PsIyHFwaule6SZOVlMHWTgc5gdj8hzIa/eWeO/sUEQSYGDoVIyc2nwuhDxnuxe+vA8pV
         0Av7TkWi8MK5ng9/TQrhdWjJGzKIw1nT3CRGTICN+OnUQ9CRJwZn+UYQRjPc6HBoOXId
         PkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665770; x=1699270570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csnOKH0S/yzTOhLnRQCy767OQRSbbASGrw4KMOOKM64=;
        b=HZNdIM4NVyKNtrm7ectOnhsQRj7kuS1qmDYn/WtAMHhEv4oFSiMaWA5lExe8FCDJcd
         zfFE/ErWibQzCWxxh07YxIa1oC/CEm+LkaP/Jwhyh6vYfK6t1+7e2xr67r6I6M6biWPi
         EG/43duhwNeSZVPn8zcx1eLA7O5NigTsEvIoflyZ/xkYYm1cDz83V0B5DNp3Boued/SK
         qVYRD42KJjD8IblS2/Rt7BeTbF8JuSCr493rrtR+uPWOxQSrw2qL0GjwK8ALINYb6ODE
         75kcRe0+vEEVlbbqwWciY/d8JcO6lFF9L80brsXAwiC3XkP/zysAOvCEaUrBimFutpHs
         7F2g==
X-Gm-Message-State: AOJu0Yw/9kaM5wyAFHr1BwYFoNikAhLxYzfQAPEIMblU1W7/IiAvb7nb
	osK3FZJbg/nQk2hNZmgx1BsyY7UGWYeIQe+Jg7g=
X-Google-Smtp-Source: 
 AGHT+IHL/kCqmaB88Pd1lPonhz6Vn742Gqxb3ymqWLk7yKiz6eLcTFUoPUHkQCusca9qSLjjOQRPJZIMXFrM3pWF4XY=
X-Received: by 2002:a17:907:608a:b0:9ae:74d1:4b45 with SMTP id
 ht10-20020a170907608a00b009ae74d14b45mr8197615ejc.65.1698665769789; Mon, 30
 Oct 2023 04:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <1698402948-10618-1-git-send-email-shengjiu.wang@nxp.com>
 <c1cfa3e0-6e5d-4e1d-b6e0-4d1045196a11@xs4all.nl>
 <CAA+D8AOCujL-eD2-chqHAW7UN7UmLrO6CWRd7d6wTCPP8=VyfA@mail.gmail.com>
In-Reply-To: 
 <CAA+D8AOCujL-eD2-chqHAW7UN7UmLrO6CWRd7d6wTCPP8=VyfA@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 30 Oct 2023 13:35:56 +0200
Message-ID: 
 <CAEnQRZAGOTm=5j_9CStnKuZVPBK_Oxr50L8XLaFd7Czr7SLnWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/13] Add audio support in v4l2 framework
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 sakari.ailus@iki.fi,
	tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: WDQZNSVOQH5DVYRBJTSAK4PE5ZDWL6WV
X-Message-ID-Hash: WDQZNSVOQH5DVYRBJTSAK4PE5ZDWL6WV
X-MailFrom: daniel.baluta@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WDQZNSVOQH5DVYRBJTSAK4PE5ZDWL6WV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Oct 30, 2023 at 3:56=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> On Fri, Oct 27, 2023 at 7:18=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl>=
 wrote:
> >
> > Hi Shengjiu,
> >
> > Is there a reason why this series is still marked RFC?
> >
> > Just wondering about that.
>
> In the very beginning I started this series with RFC, So
> I still use RFC now...

I think we are way past the RFC stage so if there will be another
version, it is better to remove the RFC tag.

RFC means that this patch series is not ready to be merged but is
merely in the incipient stages of development.

thanks,
Daniel.
