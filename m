Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A03C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:37:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EB920786
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lQzgDmj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EB920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 632E916ED;
	Mon, 17 Aug 2020 22:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 632E916ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597696623;
	bh=YrqLb9GOScQina8flKUkbCictXz0PxKRcpxzaCPkE9c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQzgDmj95xTD7uJzB8Pg6e/b35jB6fSpxWVWAIOGdczzuU1qh5tN9fN2cdyrfwVvS
	 e6M7IfTIY4eZ2zFdFLLvA7f+GPfGthFkT07G3OUiI39af5bIGQrh6RMXu81SiLP7Ya
	 abcV7pgCpp2VhxpW0EIee9vHyicOweE0K+Lny00E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF96DF800F0;
	Mon, 17 Aug 2020 22:36:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74CB6F80216; Mon, 17 Aug 2020 22:36:11 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11710F800F0
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 22:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11710F800F0
Received: by mail-io1-f68.google.com with SMTP id u126so18889727iod.12
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 13:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gggmf4/obf3xyX8N4OL6u2ludp+W78q9wdQyjaXQVTA=;
 b=deWU+iOABlYEHHvfE8Jh/89ehVsHyPv5OipS3aahfl1njTibSOCE857k2GcHWDzRVk
 B4Hpjiuig8cfW27h4u+B3RR3EMkVrH/NQrB5/SP0W2N0nn7W/4h9eH863UZY/M1FNnjn
 5sBgEI5pXKaHODZ8RSBZwjF4rMVl01Vtzb6Dmh8kRBs5IRio6L4crJgFGyV7eWhSb7/b
 JZ2S3XtRg1BOmJM8X4OC/MLyXHX9YhN0TmL5Dvpdcs5qEYbl4/w09hGvjKQD5O6Ppdx+
 +23vACK0LSntJyvoiGJVVZmjpNNztx9/zDPxDIIEqFSkXGH86erYqP8MgYdt62gRWnzt
 C2jA==
X-Gm-Message-State: AOAM531JTLCDqzJB5VXvQjn2reY+igyspGU4XLgulzM+Kb0zJJMN3PUi
 Gr91SPv0FOb3/zXE1FekBw==
X-Google-Smtp-Source: ABdhPJzdeGjzY2eK3orrhQ6ZhXXYF4B8P4OnWpr2Kg2IjB7nPlnMYmtp7GDglYyFcTF2wKxx0RdFlQ==
X-Received: by 2002:a02:95ae:: with SMTP id b43mr15885225jai.19.1597696557970; 
 Mon, 17 Aug 2020 13:35:57 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
 by smtp.gmail.com with ESMTPSA id o62sm10249657ilb.38.2020.08.17.13.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 13:35:57 -0700 (PDT)
Received: (nullmailer pid 1512415 invoked by uid 1000);
 Mon, 17 Aug 2020 20:35:54 -0000
Date: Mon, 17 Aug 2020 14:35:54 -0600
From: Rob Herring <robh@kernel.org>
To: Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v6 07/12] dt-bindings: sound: lpass-cpu: Add sc7180 lpass
 cpu node
Message-ID: <20200817203554.GA1512270@bogus>
References: <1597402388-14112-1-git-send-email-rohitkr@codeaurora.org>
 <1597402388-14112-8-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597402388-14112-8-git-send-email-rohitkr@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, broonie@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 plai@codeaurora.org, linux-kernel@vger.kernel.org
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

On Fri, 14 Aug 2020 16:23:03 +0530, Rohit kumar wrote:
> Add dt-bindings to support "qcom,lpass-cpu-sc7180" node.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.txt   | 55 +++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

