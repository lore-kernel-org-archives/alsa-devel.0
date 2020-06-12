Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BFC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:11:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A807A207F7
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H8aHFFmR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK69Co/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A807A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F6211607;
	Fri, 12 Jun 2020 10:10:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F6211607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591949471;
	bh=3BgWSSoiNfY5Ufap52YpPa0b+w/AY+oosqXMs4+Y7dA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8aHFFmRUarI3Vt7qGoSK9zPEcPRDZN8BqtO2D5+SDz5zzO+77c5YwXJvxoKuegB+
	 XSddVBCrAFu8se1O8uGJ4d8EAbvFYCIyPmUrqgkxe2/f9SqTRWy6aME+apdS9FnnLs
	 1kPkH+gLmR2OaU/DW8kCljt+fq7tWuiQiaO4SVhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD767F801F7;
	Fri, 12 Jun 2020 10:10:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12D9EF8021E; Fri, 12 Jun 2020 10:10:19 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07AB7F800C7
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 10:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07AB7F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZK69Co/l"
Received: by mail-pl1-x644.google.com with SMTP id d8so3437490plo.12
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FrBOISxwKyWg3yFgNawz44Si/Jo/mcOoYEJcWJFfVoU=;
 b=ZK69Co/lXBcRsFD7SUsxis7MvrrcFiGb9wXzfn7QAfqobBYK9JDAVVUXXpRpFHMLg0
 bvEppJLtKU+QvKbxuYgo0rxwsXP9WiA9uF0rGQy43dpzucJAnjc2IyzVcZ1ElnYntB7l
 ATrDNsHmMMemgc2y/R9TU7A9JQ3Ve8RNKb8SnaShfdenzGbXzILlFzjWK9lvsREaci4G
 VYteP+8a1FKn/dMhPPSzX5EuZSXt2zkupMCmExVRxk+qmMa3SQ8qmPp74Y8Ln/IZJW5M
 g+BVoCzM2yWQoUraZtQxS5HGxkw+Jgl24vvTzDytIgPnaEyNS+OHC2lqEYxJlor1u0zK
 Q1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FrBOISxwKyWg3yFgNawz44Si/Jo/mcOoYEJcWJFfVoU=;
 b=Yi8YFt1ykkJfJmWqbeCFuAClMcE09dcQSlNgc7SSOa4oxMN3BneOta8xRrjfcxD75H
 Y/oWbrD0IFxI3Pl25H1Ktt9sCsHx44ag8xWCOk69YXoay845b0GCrtMT7xt+LSvMaBz9
 tOa2DE+NB5iByJM9WqIU1Wjt+zPOVU+mN6rD6vSmcG08j2kbE6WQ6IIamkfpCHBYJD7z
 ebP8uI0RBt7UQD11PywRL9gi19j69bsOpRo3Rj29EpJAEJK1jm/S7EO8YzpZmmCLjdtk
 +Pw3ehFvPypIBcSogZbiM+/G8tdNpvxZP9famihXUm4POaTkwk/rgxR0GcndcXpX9w/3
 oMBw==
X-Gm-Message-State: AOAM531Oevu51OEqXZiFnKrp9+t+4T0s/QfMeRXrox5kgBXfL6v4OBhW
 YDoAgkT17/fwsQL0poUlMR4=
X-Google-Smtp-Source: ABdhPJyS8XQ1B9/rurFHEaifuL86DzzigqQvEbE5slis0FR6ePbWM33oVYWhL/dvgVit13H7C4fJKw==
X-Received: by 2002:a17:902:bd09:: with SMTP id
 p9mr10817945pls.214.1591949409605; 
 Fri, 12 Jun 2020 01:10:09 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 191sm4484589pfz.30.2020.06.12.01.10.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jun 2020 01:10:09 -0700 (PDT)
Date: Fri, 12 Jun 2020 01:10:00 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH v3 4/4] ASoC: fsl_asrc_dma: Fix data copying speed
 issue with EDMA
Message-ID: <20200612081000.GD22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <424ed6c249bafcbe30791c9de0352821c5ea67e2.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424ed6c249bafcbe30791c9de0352821c5ea67e2.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, festevam@gmail.com
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

On Fri, Jun 12, 2020 at 03:37:51PM +0800, Shengjiu Wang wrote:
> With EDMA, there is two dma channels can be used for dev_to_dev,
> one is from ASRC, one is from another peripheral (ESAI or SAI).
> 
> If we select the dma channel of ASRC, there is an issue for ideal
> ratio case, the speed of copy data is faster than sample
> frequency, because ASRC output data is very fast in ideal ratio
> mode.
> 
> So it is reasonable to use the dma channel of Back-End peripheral.
> then copying speed of DMA is controlled by data consumption
> speed in the peripheral FIFO,
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
