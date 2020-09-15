Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E1C43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:58:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CF62145D
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Toblgsjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F25174C;
	Tue, 15 Sep 2020 18:57:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F25174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600189081;
	bh=LQD1Vu3GWasUidb40nkvcp/N/FQcheCJDWP0eLKS6C4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ToblgsjwCV8ALG10WFg4yPECmZH8j4zIBvvRQ4KbqTJY/t1wbl1DnuW6zafR6z/j6
	 +aJ0OiNUO9JEF2QZfAXZ8k/VB0m02jXP1X6AWdyP7cVUCpwbHPECpSL15dSrZQQKMk
	 mcvz6C7dxP7fRMkPcFZJg0kocmY1SV5Wy76C/brc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C98F4F80159;
	Tue, 15 Sep 2020 18:57:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86E42F80276; Tue, 15 Sep 2020 18:57:09 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC633F800E5
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 18:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC633F800E5
Received: by mail-il1-f194.google.com with SMTP id a19so3635324ilq.10
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 09:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qgVvip2gid1sMQiuIbXhFpJDtDAimXj33Y+agHxQwcw=;
 b=UWdjpnmmpgJ76w+fXFAF4qGJae4lapv+ETbOJIjAlRcfeqeurc2t2uQbfSHScsp+3l
 50Y/ag3nQE//n8c6p6MjYvuPjFP0PPVA4VfvgFoEL2J4RdRiUbdwzOoANv7VHekaTyuv
 v4w7IZvap4S1QnQLfX3oGZy22qOG7mK2MmFW3lh9Cbn7g7aHojJfjq7/eT5K7OnmvtXC
 8h4K9JkKzevhfqFkJBIsq9wNKoY9qJ7K4fqxhG7sFJVIBrU4dzTmpjiDGYkhqIMauovi
 Jn5ji46bfkVhNxzPHxB3+rEMQZzF4n/gMei9dAjlU754wp77S6faojw1Zqu6VHoK36Xr
 r7/w==
X-Gm-Message-State: AOAM530a5cjvt3mZMh5izDzU17+v0JfMoKwkrf6h8sVcg2tyaWhq6v0l
 gI5oY87d8gZ9ISgPCTLFdw==
X-Google-Smtp-Source: ABdhPJyxiIldSduc04usuk5QBvT+wnoYzzAPNrEfmL6fLJS15ymJJogCJh7Iz6y2lwVoZrM6BGoOuA==
X-Received: by 2002:a92:c702:: with SMTP id a2mr2102118ilp.235.1600189017553; 
 Tue, 15 Sep 2020 09:56:57 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id d71sm9343639ill.52.2020.09.15.09.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 09:56:56 -0700 (PDT)
Received: (nullmailer pid 2118248 invoked by uid 1000);
 Tue, 15 Sep 2020 16:56:54 -0000
Date: Tue, 15 Sep 2020 10:56:54 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH v4 1/5] ASoC: Add sc7180-lpass binding header hdmi define
Message-ID: <20200915165654.GA2118198@bogus>
References: <1599587037-6742-1-git-send-email-srivasam@codeaurora.org>
 <010101746ed1bf90-d7293075-e0a7-494b-80f6-e59569e60fdb-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010101746ed1bf90-d7293075-e0a7-494b-80f6-e59569e60fdb-000000@us-west-2.amazonses.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
 broonie@kernel.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
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

On Tue, 08 Sep 2020 17:44:33 +0000, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> 
> Add header defining hdmi dai-id for SC7180 lpass soc
> in dt bindings.
> 
> Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> ---
>  include/dt-bindings/sound/sc7180-lpass.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
