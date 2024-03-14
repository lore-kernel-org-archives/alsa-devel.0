Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B45C54E58
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:39:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 503BD162D;
	Fri, 15 Mar 2024 09:39:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 503BD162D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710491994;
	bh=l85vnkr5IVShaY0q/S02bkIi9AiEbiKbWt69y83fl00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kN5JXC/THy7ZJ0x4d/URbhigtvnxSQyfO+pwY6uQ7PAKKN9mv259xovE4ZiKovvGj
	 opomQGKjjyETikf5CxmqM5WiHYvwJWrHGE2v3l5fOumQyaYFfoC1bUOXV6ra+1r9Xn
	 N+FzFLRK87dJ80J8tjmhhWvAE9cx2f/KlpzYkVpE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D142F8028D; Fri, 15 Mar 2024 09:39:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12FDDF805B5;
	Fri, 15 Mar 2024 09:39:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 78802F8028D; Thu, 14 Mar 2024 11:30:18 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E50A4F800E4
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2024 11:30:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E50A4F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20230601 header.b=xI/zqmxo
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so75041666b.1
        for <alsa-devel@alsa-project.org>;
 Thu, 14 Mar 2024 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710412201; x=1711017001;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcGu0HbVhJ43nJUYs2HgED0p2686qNZu20aPF6xMbD0=;
        b=xI/zqmxodIhuLPdcBegqQwBxY/rKlVNAdXOMMts/9gP/j0vPpwTMNMRjloNnTRnUW4
         g+h6GZJQNv0WPLt8FxKqEExnFyT10SSsEEVrPivfeSHWMa0gSJeTE4WF/KYPxr+Pl7W/
         xHZncPhwK4cBT7ujCdcJiviKCrQWwNTvORcLT1mojYiRFyBOjBT+U5OAp3vPNiTRnHTj
         6CiK1D2ct3p7THXIgkHSci1uLQxKsNNMsc00HM8z5ItI8JqyGkH423lrSsFGPzsIg23M
         GwlOgEKKvgAaQAfULNBVazWB3MhcCQnOPXLBsYwEiUpXjFftQw9Xgm1N4+NDn4xqX1sl
         QDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412201; x=1711017001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcGu0HbVhJ43nJUYs2HgED0p2686qNZu20aPF6xMbD0=;
        b=PkyrzWoDr4/XHAfsLtY2rkbEZpNQPZoaEWrppByuc867Fz2Qq/4QwSd86hehsBBQF4
         kOWO7SpTBgvwOGw2ZRN1KYMsdx3PDnsuGcDvCuF5NAhJ+yKP6wuvmSUjeNwaH4xdcrdU
         9oDgFup48bYvnDHGhsrV7tI+gpusFMHdhoDCd3ns6UWZBprJULWxxLadWEiKjtIWP5QQ
         3sEEOwvtVah3ulWSlIKaoIN8hvi3bWbWRLq6Nv7u/UOAMKEbreAnmKSZ09P8oDVPx3A5
         krPvWKpFoHprk1WD1RqXMr3Y78xrQ3CluJjYUObABTUwDvByTJk1+QB6p+NKGCaIhWHu
         ji+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3wux0ikMsCo9H3LtW+wlXgkTwv0ChGIcG8S2Ybae9tJo1cakAUeDVpKkehUpfZVC2Cozri9380U2coLnGiQTGbcx/eAjwtVtxQm0=
X-Gm-Message-State: AOJu0YwJpT29lfHEyMedP3b7hwkIpM45Evg739e+glyFhpEI7VD9rN/i
	ptDcjvbdcqcIpkQoGLi/StsBlZEVusQK261s3mq6Yp31oc98STXtq8uyo3+XSsW5X4UlYKMOY/f
	h9w7w0damxACQhoOQWLwKgcmcT+pj39wcvr6G
X-Google-Smtp-Source: 
 AGHT+IGON9Se+9pz19hDr8yNzBsEwejkS9/dMYiC1+kL2sDCzCuSpkLFSJJXHnc5NytKjijIcb1mX2sR+v6mI2ND08I=
X-Received: by 2002:a17:906:99d3:b0:a46:749b:58a with SMTP id
 s19-20020a17090699d300b00a46749b058amr784155ejn.57.1710412200434; Thu, 14 Mar
 2024 03:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
 <20240228013619.29758-21-quic_wcheng@quicinc.com>
 <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
 <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
In-Reply-To: <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
From: Albert Wang <albertccwang@google.com>
Date: Thu, 14 Mar 2024 18:29:47 +0800
Message-ID: 
 <CANqn-ring2uf=A-F7VuRwnJ--n=FtFzSddCmR-=nfxCGcFAF2g@mail.gmail.com>
Subject: Re: [PATCH v18 20/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz,
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, broonie@kernel.org,
	bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
	konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: albertccwang@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YFBCL45PJXYPHWKS5O2ZKGZYEP5E23U6
X-Message-ID-Hash: YFBCL45PJXYPHWKS5O2ZKGZYEP5E23U6
X-Mailman-Approved-At: Fri, 15 Mar 2024 08:35:08 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YFBCL45PJXYPHWKS5O2ZKGZYEP5E23U6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Mar 14, 2024 at 3:18=E2=80=AFAM Wesley Cheng <quic_wcheng@quicinc.c=
om> wrote:
>
> Hi Albert,
>
> On 3/13/2024 1:03 AM, Albert Wang wrote:
> > Hi Wesley,
> >
> > The suspend function `qc_usb_audio_offload_suspend()` looks to stop
> > the traffic on the bus, so that the bus can be suspended. That allows
> > the application processor(AP) to enter suspend. There is a subtle
> > difference with our feature, which is to allow AP suspend with the
> > Host and USB controller active to continue the audio offloading. We
> > call this feature `allow AP suspend in playback`. So, I have some
> > points to clarify with you:
>
> Yes, I'm aware of that feature also.
>
> > 1. Will the suspend flow `usb_audio_suspend() -->
> > platform_ops->suspend_cb() --> qc_usb_audio_offload_suspend()` be
> > called when offloading is active?
>
> It can be.  This is why in our case, we are going to issue the
> disconnect event to the audio DSP to stop the session if it is currently
> in one.
>
> > 2. As my understanding, the suspend function is to allow AP suspend
> > when the offloading is IDLE, but it won't allow AP suspend when in
> > playback or capture. Please correct me if anything is wrong.
>
> As mentioned above, it will let apps go into PM suspend after forcing
> the audio stream to be idle.  We won't block PM suspend entry.
>
Right. Your design is to force the audio stream idle, or say, inform
the audio DSP
to stop the current offloading session first, then AP can go into PM
suspend as usual.
Then I can say the current design did not support the `allow AP
suspend in playback`
feature, right?

> Yes, I saw that patch as well.  I'll take a look once this series lands
> upstream.

That patch is rejected and archived now. So we need to find another
approach to do
that, even based on your framework.

Thanks,
Albert


> > 3. We would like to integrate the `allow AP suspend in playback`
> > feature with your framework to become one upstream offload solution.
> > Here is the patch:
> > https://patchwork.kernel.org/project/linux-pm/patch/20240223143833.1509=
961-1-guanyulin@google.com/
> > .
>
> Yes, I saw that patch as well.  I'll take a look once this series lands
> upstream.
>
> Thanks
> Wesley Cheng
