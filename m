Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763AC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BDF619E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09BDF619E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 721381676;
	Tue, 24 Aug 2021 19:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 721381676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824920;
	bh=RjZBft8vxHSOa2EhFjdDfKPpTVG+V+OEKxqfWOj5Igw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YNANOMcZrn+HZczkZ8Wu9gyeT7AIcIcvlDtG4CzaowRzgjobW6ZT3oKCPmIg7YglD
	 PakiAxWnS6ghpCzQLIwcv3ji9d4LOgKUbBFbJV0kv+TGoGrGZ/9msXiiB7PZ7W/vsn
	 H8JmPvaO4Y85Aa6wEyi1ETnz98354zpDSFxRxeJE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C815F8025C;
	Tue, 24 Aug 2021 19:07:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DC34F8032D; Tue, 24 Aug 2021 19:07:38 +0200 (CEST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BC9FF800AE
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 19:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BC9FF800AE
Received: by mail-oo1-f42.google.com with SMTP id
 m11-20020a056820034b00b0028bb60b551fso6724974ooe.5
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 10:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x0+Ku3uRYUZNsC66GsbdnR2uZPO2vq9Jho8/8ikUv4w=;
 b=ONKbRseaNAxW8SWQVTZ7l9KwWTHXOkgpT/x7mGHAglLgfvvbH1vLFx2ENZwaAYtDmr
 ZA6jPuBoEdVuqd05W9Mk6SaKZXG3nQ/ucOh9UUc2T83N4eYxulJqyM7XgEDJBUmpXgY2
 XrSHUX1wv300OgIZHNqb59L7efixUocewghwH1cFgfd9zQreKUK0yHRjz6RlBcg/2VHs
 kYam0syNcVINfD+19uB5l5W6bH6lC1G+N3T2shKZqcBos1WWbZs054aRoCIgp7PveqVm
 Hs/9Yqa/L75nDnWaa+OR5xzO85j+bvXQCej+l3o4tlnjRVicbI9eTmBZZFIgXUHM2UGx
 aC8g==
X-Gm-Message-State: AOAM5333Fs4YdGUz8sqb0/n0vA/wanqYjdO+JfSkgcUhGpe0Ri9ELnCN
 pu7Zo87LR6YkZdNAMIorYw==
X-Google-Smtp-Source: ABdhPJzFcRyrinyVmQXXuVJkq9e3q3DPx8HeY+Xs4gHp1ZiXtcwNhbdUGwNoK/D/cBshzThYrQhing==
X-Received: by 2002:a4a:2549:: with SMTP id v9mr30504371ooe.28.1629824850050; 
 Tue, 24 Aug 2021 10:07:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id n130sm4521973oif.32.2021.08.24.10.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 10:07:29 -0700 (PDT)
Received: (nullmailer pid 639790 invoked by uid 1000);
 Tue, 24 Aug 2021 17:07:28 -0000
Date: Tue, 24 Aug 2021 12:07:28 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 12/15] ASoC: dt-bindings: rockchip: Add compatible
 strings for more SoCs
Message-ID: <YSUnUHwMDrU748Hs@robh.at.kernel.org>
References: <1629796561-4025-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629796734-4243-2-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629796734-4243-2-git-send-email-sugar.zhang@rock-chips.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 heiko@sntech.de, linux-rockchip@lists.infradead.org
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

On Tue, 24 Aug 2021 17:18:51 +0800, Sugar Zhang wrote:
> This patch adds compatible strings for more SoCs.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
