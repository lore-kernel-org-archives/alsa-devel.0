Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48990C43461
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:58:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B702076C
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SwSm6OHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B702076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8DEF1680;
	Mon, 14 Sep 2020 19:57:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8DEF1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600106319;
	bh=QAK+t1syT/ebHm4FsS5dCJYFraVc6tlOb0nnzZPyny0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwSm6OHUgKWxMfdZFUz8eZEmMz1+mOQq1Z75fCOIYbs6nwNi3+lxKMQME4W3PszKu
	 D6pfr3nMxxMeA0L5W2m3LJggSB4sBpGD6NG4kKks8227zaTAmJ4Rqh5VE9HMXG3Raw
	 +tIQ33bJIehboSDeP1OZHQGe5xYBGufDwfv3Myn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33D09F800F1;
	Mon, 14 Sep 2020 19:57:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62C68F8015A; Mon, 14 Sep 2020 19:48:37 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22DC2F80105
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 19:48:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22DC2F80105
Received: by mail-io1-f68.google.com with SMTP id u6so1005667iow.9
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 10:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PqPt1xAT32RIxLIZosJI+JQoUjrXFn0vUMes1djvxjg=;
 b=f5siGsDShetD/XX6bJKlyw+23ouzZ4QhBT2jby48ZwR7C7ZtwpzOzS948xVg6il9Lk
 jpXmIYUYieL+f57AI4X/VWUoB1rs2aQmcsQ/C+MAPAu74ivRPsqe1sLW0Fip1P08jHVf
 QXCcHLXT2r+O7vLko8zI7gkSMgSaNK0Pp0RzDEiVY/rlLxYkLC395c05j6XlBHSXJHgK
 NDKoy1a/W3iJAWhf+bM5TWg+UDa6bqBN3hFOc9QWdxf//8kWxWHjNnx/VV1SJWvx+BnC
 xcgtdN53A6HKc3ONmFWYNA4D0Xp2mkuave/eOphl3oq5PdciFfxuqiOfzeV4s9mUFydH
 xvfw==
X-Gm-Message-State: AOAM530JyKUNYPjg654qRYSTxyH9pHqKsgoAhmsW8x6oKeJLK04LwbQt
 BeuKLZdvNyoR3FcKSOp6TQ==
X-Google-Smtp-Source: ABdhPJzMqG/uDJkJEjtFvej4Mc/bN+DjyUJgglEvHKfxvSE3kgBG2dw0CE0nO8CSpV+qZuBKSv5uXA==
X-Received: by 2002:a05:6602:2e87:: with SMTP id
 m7mr11860757iow.106.1600105697758; 
 Mon, 14 Sep 2020 10:48:17 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id k1sm7254435ilq.59.2020.09.14.10.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 10:48:17 -0700 (PDT)
Received: (nullmailer pid 4126584 invoked by uid 1000);
 Mon, 14 Sep 2020 17:48:12 -0000
Date: Mon, 14 Sep 2020 11:48:12 -0600
From: Rob Herring <robh@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v11 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
Message-ID: <20200914174812.GA4125843@bogus>
References: <20200914080619.4178587-1-cychiang@chromium.org>
 <20200914080619.4178587-3-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914080619.4178587-3-cychiang@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Rohit kumar <rohitkr@codeaurora.org>, Patrick Lai <plai@codeaurora.org>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 dgreid@chromium.org, devicetree@vger.kernel.org, tzungbi@chromium.org,
 Srinivasa Rao <srivasam@codeaurora.org>, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

On Mon, 14 Sep 2020 16:06:18 +0800, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

