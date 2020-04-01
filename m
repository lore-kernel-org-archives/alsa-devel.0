Return-Path: <SRS0=1DJj=5R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E87C43331
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:01:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20602077D
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i6/uSPUb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjmeoWUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20602077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF6C5167D;
	Wed,  1 Apr 2020 11:01:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF6C5167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585731714;
	bh=2XSfLBqas9z+sMUdBGDRPexmn10LpoGrzY/iRbQIyjA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i6/uSPUbhO9cK/4f2XmvVgxIKjS+hOE0UcB0vYRTaWooLWAKxW7GM450k0jIjaXcM
	 bEymcAR3GbXUD//z1hnGRAUVa1n5ag+y9O96HRoRi9lE+93uoDCBsuM4VDyQNjgwDT
	 a86XwFWO5mvj1CSJ9BAZrlFkxJwMSlSHS4Lad9CE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77742F8014A;
	Wed,  1 Apr 2020 11:01:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB674F8014B; Wed,  1 Apr 2020 11:01:02 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 946CCF8010D
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2020 11:00:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 946CCF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="sjmeoWUL"
Received: by mail-pj1-x1044.google.com with SMTP id kx8so2412360pjb.5
 for <alsa-devel@alsa-project.org>; Wed, 01 Apr 2020 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G5w9RBvrR3WV0wIE+sZQB1JGP6d9WKUVbo/9PkL3ClU=;
 b=sjmeoWULrkH1tiyyfW9jHoKfBl3e7nyRSF1aUIblVFaUN/mu296kgU21YgdIGWfn+h
 zdURn18aS4+snbifdkA1s8BDLF2XTBAIZiLLvnZzpJ7Z/R/5ZPGja9hFa9g/lFBdu6u1
 h+D5feCaKVjJtUQWO+hmHyqgbmlwfb9+PWujHtTL1phLMdPyxe8xvOpLGayNk8KKHKBt
 zynsSQExMsahWUIXTBddC8Zele2NgjqgiirumN9kWYEoaDFCrwjOSdab1kDdwjlN3qop
 vnG8sC7/w9Lu5S3owEeowz43YC4rYgr6lpvyvSUakiOEb0XDaDVBwV/EFKJbOTucUzRu
 Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G5w9RBvrR3WV0wIE+sZQB1JGP6d9WKUVbo/9PkL3ClU=;
 b=DR+2k9gAEd+jOHVpeSZTMOgJRmR9F43ADN4XG7oQl1pCax6fO8/cROJq5buX2kVXfB
 58A9nS3aaSzGXkyfDJdbLHst4gTiVKnVXC+HEqtD0WVhQz3Cck/achtwb6eZRBoczrNi
 PqM/6TdooFT8ezd6lV7u+2RloUJxrtSQE/Xldhme8TL6YkiZgPJHAX6/WDSWM35r/bpC
 d7wf6VmvFb3yvbNNMP81Z43hU4jdv0v37et93+emy7L/Rz4S0BdI2EyQNRuMb4+I69nW
 Z5Q6dkQ3udDth0epkDlp3KY1w8e9vLYJ3X7ozNgIXPNViMd9u8c1M2WzrGFjDg/3Fekn
 lVhA==
X-Gm-Message-State: AGi0PuaoFfT6XL8rdIcUUoLtiMhcSIR8wkKrdL0Kj2e7nzOI+3NkuGTN
 eBleXrAp5pyLPu2cjrMo8PM=
X-Google-Smtp-Source: APiQypIG0HKQpeV9kSQbddQPBmsyGFCl3XNlZOs5/znCA1arlAiyTU9vFRvbsaVa5Utw0gmcOea2XA==
X-Received: by 2002:a17:90a:e64e:: with SMTP id
 ep14mr3684476pjb.149.1585731654177; 
 Wed, 01 Apr 2020 02:00:54 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g11sm1064804pjs.17.2020.04.01.02.00.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 01 Apr 2020 02:00:54 -0700 (PDT)
Date: Wed, 1 Apr 2020 02:00:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 1/7] ASoC: fsl_asrc: rename asrc_priv to asrc
Message-ID: <20200401090050.GA7202@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <4a808f376c297f91da0caff9d0f73efb6f152e72.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a808f376c297f91da0caff9d0f73efb6f152e72.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, broonie@kernel.org, festevam@gmail.com,
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

On Wed, Apr 01, 2020 at 04:45:34PM +0800, Shengjiu Wang wrote:
> In order to move common structure to fsl_asrc_common.h
> we change the name of asrc_priv to asrc, the asrc_priv
> will be used by new struct fsl_asrc_priv.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
