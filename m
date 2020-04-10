Return-Path: <SRS0=EEmF=52=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDEC2D0EC
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:45:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40950207FF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2020 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hRpcvzdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40950207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B3FA168F;
	Fri, 10 Apr 2020 19:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B3FA168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586540715;
	bh=NzY5vOWWuQUYRQgthUZFnpFjROcRtToCuD2grSEo0xk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hRpcvzdhK9Vc/CJV7yC8SyKLldb/SPFoibmPviY16w5J+AbLKYgk6GZN+G7elFA+N
	 F61GQlxVPbptfWC3r0v+RRpUWaXEDBJKAyewlsmwtcBm9qs+rCaj62diNcGE3hHon0
	 0IH+WW/M5H1et+Rg7cdN1MH+1Ck/fURUnlLGgqfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2894AF800B9;
	Fri, 10 Apr 2020 19:44:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 856ECF80143; Fri, 10 Apr 2020 19:44:23 +0200 (CEST)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F29DF800B9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2020 19:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F29DF800B9
Received: by mail-oi1-f195.google.com with SMTP id d63so1984349oig.6
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2020 10:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gSwNy1tJz4LnthkNz4eu29xiKtjPqkQs8epKrYetAcA=;
 b=iLKZIeFTEZfN6ikO8IFZ3tW4b4PmWUe2K06vpYhooR8X/n5WJyroYQo5GuizW02k3E
 AZPAJU6FzXUUDDwzQt0Iy6BKXxrDf9eHvHCHzSLOND/Ww0yxIViDFp7yUZFQLjoCn8pV
 auz8hTB2Ob9jZ4sylwoU5FupfkwJSISG65Cty3Dd00SDNY8pUJaJTre3Hi46EoqQKlnE
 zBtPitrBp3rJ0SyqUw9EtAU8iR75mFLDyMPqfruRMF/0vhCh+kVx/L1H3bc4h8YCBQ1C
 rJBfj1fRt43RBDfdwfsVb3jk8gjntcg8IECMmvtERP7ZH9GVZsZnMOOvhBrdK9neTSN5
 i+GQ==
X-Gm-Message-State: AGi0PuYhPX5aL3MmLORa8SKvM+600nJEN9eo3c21XVfY82VD6e0D7xB0
 zK6FwAQdOyBFxgx6M28ZAg==
X-Google-Smtp-Source: APiQypL2ZJu/xdLEJ0I6dA8ilTA3Y6JVALbbZMRVcfLcQccXYD6tcxnLAOWU7dYVvd9Ls/XBydO1gg==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr4324743oig.40.1586540657449; 
 Fri, 10 Apr 2020 10:44:17 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net.
 [99.203.29.27])
 by smtp.gmail.com with ESMTPSA id m13sm1270005otf.15.2020.04.10.10.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2020 10:44:16 -0700 (PDT)
Received: (nullmailer pid 21853 invoked by uid 1000);
 Fri, 10 Apr 2020 17:44:11 -0000
Date: Fri, 10 Apr 2020 12:44:11 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: sound: tegra-wm8903: Document new
 nvidia,headset property
Message-ID: <20200410174411.GA21788@bogus>
References: <20200330204011.18465-1-digetx@gmail.com>
 <20200330204011.18465-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330204011.18465-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
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

On Mon, 30 Mar 2020 23:40:10 +0300, Dmitry Osipenko wrote:
> Some devices have a 4-pin headset jack instead of 3-pin microphone jack.
> The new boolean nvidia,headset property tells that the Mic Jack represents
> the state of a headset microphone. This additional hardware description is
> needed because microphone detection procedure differs in a case of a 4-pin
> jack from a 3-pin jack.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
