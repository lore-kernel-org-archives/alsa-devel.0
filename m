Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82AC2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:12:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5FB2073C
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 05:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="B7tiAjiG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i7D2bxT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5FB2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 105481657;
	Wed, 12 Feb 2020 06:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 105481657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581484365;
	bh=pKRS8qVj9AAR32ffCBy7/SBKIr+9apJs/+7iwyuFZzY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7tiAjiGovneLc67m8DhimmFfT1bYpOU1XAlH82wH2Etdjl49nTnMeAeyXFuDsJBE
	 odq7JcF+TxuS0n5iO+fArjw9gveMmt1p6NjUchWiBMXYyynUFE4h8gj9YkSpudd1Yb
	 FEL1LsWcsq+cyV0s0LoTqKbinWjVvWFn330AimAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41477F8014F;
	Wed, 12 Feb 2020 06:11:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52B84F80157; Wed, 12 Feb 2020 06:11:52 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 185B8F800E7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 06:11:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 185B8F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="i7D2bxT6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=OTFD/SNJffQD3DOz5VRTovqxb+aXKeZm5TMlIiwyLbY=; b=i7D2bxT62GMcsQBA/OG+IFzNG6
 lmiouuAQCXjnQ5VxYf05qkah31TKIuACoAxAW/5IFUiktzYFxUYyxLUwOa5cDZQaEZLyZ4anQLGOA
 6J2hKd+ITQCBXqX3V7JmOEaILq2ppan2KDM3uBu1yRtWB1n6Vyl9lWTuUPaoW8IoHfPYotYNcOszQ
 oF4zMTRyLmKiVzrlXh4SPmFZuxY0nzcKrrsJr2cQ5aEBf9ag8H74ZyJwekTQn1J2syYa5aWHk5Lmq
 9UmNgg0EF5Hv3xwppCVqhUZjBcXSW/WcBBUEnbKhPaqYR0rx537FQfxsrDeO/gD8sFJFKg15P6ZlS
 bVAWmY6A==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1kJ5-0007Y5-TA; Wed, 12 Feb 2020 05:11:27 +0000
To: Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 broonie@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
 devicetree@vger.kernel.org
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ab5cc65-026a-10fd-1216-b0d83baf37a6@infradead.org>
Date: Tue, 11 Feb 2020 21:11:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
Content-Language: en-US
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 0/3] Add new module driver for new ASRC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2/11/20 8:30 PM, Shengjiu Wang wrote:
> Add new module driver for new ASRC in i.MX815/865
> 
> Shengjiu Wang (3):
>   ASoC: fsl_asrc: Move common definition to fsl_asrc_common
>   ASoC: dt-bindings: fsl_easrc: Add document for EASRC
>   ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and platform drivers
> 
>  .../devicetree/bindings/sound/fsl,easrc.txt   |   57 +
>  sound/soc/fsl/fsl_asrc.h                      |   11 +-
>  sound/soc/fsl/fsl_asrc_common.h               |   22 +
>  sound/soc/fsl/fsl_easrc.c                     | 2265 +++++++++++++++++
>  sound/soc/fsl/fsl_easrc.h                     |  668 +++++
>  sound/soc/fsl/fsl_easrc_dma.c                 |  440 ++++
>  6 files changed, 3453 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>  create mode 100644 sound/soc/fsl/fsl_asrc_common.h
>  create mode 100644 sound/soc/fsl/fsl_easrc.c
>  create mode 100644 sound/soc/fsl/fsl_easrc.h
>  create mode 100644 sound/soc/fsl/fsl_easrc_dma.c
> 

Hi,

Is this patch series missing Kconfig, Makefile, and possibly
MAINTAINERS patches?

thanks.
-- 
~Randy

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
