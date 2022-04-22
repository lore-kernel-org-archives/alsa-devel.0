Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F64BC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 21:28:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F9CD1712;
	Fri, 22 Apr 2022 23:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F9CD1712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650662914;
	bh=v4i3AmNv4FLK6btws/jh0kCSYBAa4f3ciHtxOpc3dZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yb2LKqExG1M2JXJJeqnNo9BBdoU0wEoqm24YjI6/fGVb3tiezCxglLCiy0OFGiLDq
	 Fslf00TibzNKYwLCwn7PWlX8dNk9jDFekl8zqCATj0eI2lOu9YoFYCbTrkhRtoEfe7
	 VvJPXNRNnDhp5gnO0bImriHIfv0eeBILJ7RWYvsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 189A0F80154;
	Fri, 22 Apr 2022 23:27:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF0A5F80125; Fri, 22 Apr 2022 23:27:41 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B25FF80125
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 23:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B25FF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="JRDatOGF"
Received: by mail-yb1-xb31.google.com with SMTP id w187so7355301ybe.2
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v4i3AmNv4FLK6btws/jh0kCSYBAa4f3ciHtxOpc3dZs=;
 b=JRDatOGFzKK/uf+U50BmSx+6g4Pa7D170MDb5ReJoxJCi2YJ+O1LWcsk3ZR+cCBvOv
 GbI3hNcEt8op7qRcvRwQ1rF5AX0KZrXSyqZ64VdMU5KrD7qR1RorXlZ7BdfS/vwlCh/u
 mu0Nbnoz3MxCqG5idEmXqe7YNX3p+7DVU7y0VRUEwRAjMCgtMxMuM8yFYoIs7OpITDVV
 NFr9xZzrgfbvZDJjyHfftICMW18Gae8pnfjA0n5Tq4hFDIEo2naboitBPARNTgAuA9wV
 NLIyepcfEUNoedq5wC333803/JJ4N5AOBz2KgH3OzXG8wBAGvmI5B9QYV9q2Is2Q60Rq
 2Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v4i3AmNv4FLK6btws/jh0kCSYBAa4f3ciHtxOpc3dZs=;
 b=KdTiCXz3GS2v4XIu/Rk2yNKMGnChPZ75EAS1HG5aevPumMJySz2OHmi0as1+4EFyKv
 AIlJRxZbm4667o3WAQ5DQtUOojGiTSyPqK7bLEOvCMfY/g/k2Z6+OzSz0depMMehM2JQ
 3pN3qQ7Um8BDuXLDDDxz1x4adKS+TCFW2Z945n0rpfO1pFJystGBcwx66PSF0fxgeAMq
 LWWcByUIduTOSb/ZZyV94VMzA7YzFWUdRdymqTzN63PSj3B82r9Gr7SmxncQEPHGvOCY
 KbBULfQ71da8F4/30u6W9nbEOYG3Q2wf7VCi6VusKoSamQddTGuZjqe+h+8fRUyaxSUJ
 O68w==
X-Gm-Message-State: AOAM532TRpsyMNgHf+l2k+lDvkDuzaPBZ+o7PKmSZc0Mwtu3cu9Ac0Dd
 Q9nMwayklQFBawy4zNfi0dl2YUeqmcim2XYWJpogeQ==
X-Google-Smtp-Source: ABdhPJy5uOpR6QqOApr8JTXnRyyqvChXNpcmelnBXNb6YY6fm53l19ExMBperiDNdyr16+uDrBTu9QvaUkCjxxjaNPc=
X-Received: by 2002:a5b:8c8:0:b0:641:e8de:a6f4 with SMTP id
 w8-20020a5b08c8000000b00641e8dea6f4mr6385815ybq.533.1650662851086; Fri, 22
 Apr 2022 14:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Apr 2022 23:27:20 +0200
Message-ID: <CACRpkdYuojrAdz1G_ePeuaEX1Q4hQah=nQuOuW=v0Ty_FOk0Ag@mail.gmail.com>
Subject: Re: [PATCH v13 0/7] Add pin control support for lpass sc7280
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
 tiwai@suse.com, agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 linux-gpio@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 bgoswami@quicinc.com, quic_plai@quicinc.com, judyhsiao@chromium.org,
 linux-kernel@vger.kernel.org
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

On Mon, Apr 18, 2022 at 2:37 PM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> This patch series is to split lpass variant common pin control
> functions and SoC specific functions and to add lpass sc7280 pincontrol support.
> It also Adds dt-bindings for lpass sc7280 lpass lpi pincontrol.
>
> Changes Since V12:

Bjorn says he's happy so I applied this v13 version for v5.19.
Any remaining nits can certainly be fixed in-tree.

Thanks for you tireless work on making this work the right way!

Yours,
Linus Walleij
