Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DBEC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 00:09:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844862067B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 00:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DQoXgIz7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCh1Bvui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844862067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C1FB1614;
	Thu,  4 Jun 2020 02:08:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C1FB1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591229338;
	bh=guBPCWyssErbM2lE+OHSnFt5M8+33BoTTNKhw4n9i9E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DQoXgIz7Ao1jpDoUbo68tUqbmm4B06WOxnCeZGVz73gf/kQdJnMdgTbzNy+fGX+HD
	 bdaXXPp/LqrRKGhm7gBf9ki/z3lqR0zstNLG8F5zyl68w+SFpQmXgguwwO8O7HuRYv
	 Jr8GanPq6uzAHjsZkdT+ukPrCx77UGoBWnImDHH0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A919CF801ED;
	Thu,  4 Jun 2020 02:08:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73684F800D0; Thu,  4 Jun 2020 02:08:06 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25373F800D0
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2020 02:07:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25373F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XCh1Bvui"
Received: by mail-pj1-x1043.google.com with SMTP id jz3so289292pjb.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2020 17:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
 b=XCh1BvuiQnQ9Zm1oZ2yD4vKaikfXRb54M1szSL15zdmA4Wu3zIleoiijey1ihZJYmu
 yH73ihq2hNe4EPGty0ElAgH+2jO8uB3PwYRbUhMIb4DwZaakWiQkO4TsYbjZ5ZfQwLla
 Dqk8QEEEN5t2OKagg3lhOVoFlGROQAl6R4HBIvKnIpKE18gJTBbEaBog8i2qLQqPs1dN
 gxCOB8YGuOkwR1p5JZYt2ci26kspsM5+IdV/AzGK/7iHdc/Le+ZHHkfGXsx0vT868TpG
 GNtNEkGq5vrpV81Zk9flKNsy1k2xnXdO4yq9GaGhqZJdAhQZsPom222FE/RMcP8kfewk
 hkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
 b=Srfv9agevniPQJjPECJgPomyw0vTU3wPoP7xBYx6iFrlk1Lm4Gxb/l80IsOCAkT5+X
 ANZSSl0P8Ye01HKzgFpkRtjUDT4A/0ZQUn7EldsvoHoZv7G2BrVFR1YA0/gmK3hYJNbp
 REDLRJs+2lF0nYAuz9KjZW8CZUMIS505nBsDEpaZFDQc4N7nYjnUrJxeaGMUfPMR9Jth
 tdOOg9APRq4vvUUlLqIDwcOfwAvMqFRIZ35cgWZ7L3UBjn6MNSOZgkxiS8h9RbfafxMW
 wHBsE2nuXHwGg+lQIoJq9koKGIRzoQKw4xC8kuMSOx2KojWl1VzI0IR1FwFBuoZEVyPv
 T3ng==
X-Gm-Message-State: AOAM532uA6Y+1ZSVp/m8Mum+HAEk1nPMzvahAEzcCoZYaMB8qQ4um7oa
 kS2r6ITWA+qClys/Irers1o=
X-Google-Smtp-Source: ABdhPJyx19haOwN64kw7j8RFpa8HEmcAYpFxgEWl1NTCvbX0UCfPaYbv4AlWn6qfCVsMTOK0HzJ54Q==
X-Received: by 2002:a17:90a:a107:: with SMTP id
 s7mr2777391pjp.199.1591229277291; 
 Wed, 03 Jun 2020 17:07:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id b14sm2549035pgb.32.2020.06.03.17.07.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 17:07:56 -0700 (PDT)
Date: Wed, 3 Jun 2020 17:07:54 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_easrc: Fix "Function parameter not
 described" warnings
Message-ID: <20200604000753.GC17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Wed, Jun 03, 2020 at 11:39:41AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'easrc' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'infilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'outfilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'shift' not described in 'fsl_easrc_normalize_filter'
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
