Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D65C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Apr 2022 23:45:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB48D1729;
	Sat, 16 Apr 2022 01:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB48D1729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650066306;
	bh=LzE9Bw7qNlZBemI3Fek/7/11zmjYl1WdqOohDr8dRQs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMnnoZyJomwgXUJDJ1glAUVrgEuRUVGMCR2ydZCAFmraCP+RPWqX6hzeKfUiFoGIQ
	 jo+A931payEguoEY3ZrAlyjixcWW+zCmM+rsmbmckqqVY8A/oAzHb7RXCIWwmeeV22
	 aR1DTNkakGM1MQu0MrviTfCORa29w48aGKl0+7IA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63133F8014B;
	Sat, 16 Apr 2022 01:44:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC985F80095; Sat, 16 Apr 2022 01:44:14 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A12F0F80095
 for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2022 01:44:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A12F0F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="WQYEUw+T"
Received: by mail-pj1-x1031.google.com with SMTP id o5so8671066pjr.0
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2022 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w2QrILTyqQ+Pt7TX+dc/u5nUBhPOOUFyhDJl0/uG8KA=;
 b=WQYEUw+TfPdba4M0qoV3YoYNx0EokWXTwcm94AT/cqahCQWwwjBWEbOZD4bvmT0NFb
 Xcx5ODn0k7YRALA13OhixgkDU8uYYogteOunDDY5goCtmJyK/qUBiMez/8Ex2AWPKxfs
 zWYTFOtjGivIKkh9dDxV5C6NheZrsC87+NjXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w2QrILTyqQ+Pt7TX+dc/u5nUBhPOOUFyhDJl0/uG8KA=;
 b=FPauZPUqIdk3vwUvsyinAl6j13B9jKyp5zyjPA6NnAzGD5v7I5eNfGiBMqkiyibRUu
 Pftt341ezk+rPHi9oo8oxCVNlU1uLI+2FciwmYNZXTIKgTQ5wFLHJiSMZsRSVm6d2hdu
 xeVrNx+VrzRc6/64pMVVFwPfykjMH992xuYYpwU+hi+z4sFR+6QPDxKS7Teoro+JgSrS
 pAJq8E/QXpJkuFRAUamJScMpV3j3HlWsLoWeUDz2y33drd8KsXmyIiDjyijs3ASCngK9
 X+ASloUvYNk3xWNIoZj7siAFfhEHnv1Pbese08E0hvK0z0L271RYygRVeNxHqfF8i0z+
 enCw==
X-Gm-Message-State: AOAM530hKdSHd7NcgUuFn1jQ2sCpZwwyIo8T7tpj0GQwiCPJnLp5I9F4
 DzpxZZaB880jA7KORAcxbM2Skg==
X-Google-Smtp-Source: ABdhPJx5DUqDtUFoTZutT3tV3A+5mldSPzpeVrsrxCdXDbVcaqBeXAPd4TrSNpEqM3FQkJq1z1ovDg==
X-Received: by 2002:a17:90b:1b44:b0:1cd:49b8:42b8 with SMTP id
 nv4-20020a17090b1b4400b001cd49b842b8mr1313605pjb.102.1650066246324; 
 Fri, 15 Apr 2022 16:44:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b27a:b3e7:2e3e:e4be])
 by smtp.gmail.com with UTF8SMTPSA id
 k10-20020a056a00168a00b004f7e2a550ccsm3938967pfc.78.2022.04.15.16.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 16:44:05 -0700 (PDT)
Date: Fri, 15 Apr 2022 16:44:03 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v12 7/7] pinctrl: qcom: Update clock voting as optional
Message-ID: <YloDQ7V7JTNYkjWu@google.com>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
 <1647447426-23425-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1647447426-23425-8-git-send-email-quic_srivasam@quicinc.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 linux-gpio@vger.kernel.org, rohitkr@codeaurora.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, quic_plai@quicinc.com,
 bjorn.andersson@linaro.org, judyhsiao@chromium.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
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

On Wed, Mar 16, 2022 at 09:47:06PM +0530, Srinivasa Rao Mandadapu wrote:
> Update bulk clock voting to optional voting as ADSP bypass platform doesn't
> need macro and decodec clocks, as these macro and dcodec GDSC switches are
> maintained as power domains and operated from lpass clock drivers.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
