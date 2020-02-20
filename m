Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F9C34031
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:52:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E8420801
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RReXjMAb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+HrHOjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E8420801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88F2516AE;
	Thu, 20 Feb 2020 07:51:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88F2516AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582181551;
	bh=JNIG22jzoEIx8uaMG8XcpUOQ63HTDWM8Hi0KB9xaKaA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RReXjMAbIR/YwnL6x1tkAeSfnZJhD4nmxZsZkhUZIkYqlKXmi/LiBf6k4AgA3tgzX
	 +M9mWghJO7FgFmSxtfIaUACv2Gb6bQuk3dcrlUQMEikjY6qgSdSaNA/QNWjYBjduJm
	 x2lgZGico9GIo1MyVTkc79kG0mh8G8cqOj+kqOvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC58DF80145;
	Thu, 20 Feb 2020 07:51:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EEC8FF80148; Thu, 20 Feb 2020 07:51:38 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11B4AF80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 07:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11B4AF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="F+HrHOjU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=jelPZvcI0SMKCQvboR9PRb2B3llQjVk2Qq23LoJ8biY=; b=F+HrHOjUCIxHpOXQo/A4PnzUNO
 ck95dBhA9n6qID7EQYBVJReKljWkMg+TsLGoM6xFCRPFNmAOwyel7zCcHuZx739mXMTmDRtNJPBgk
 vJ8OObp516GIva4SkX1KV5lVIEYS2hlxgr+INQ+lSPdMD9441IRf5mdONNXoH7uIiqtwzlPu4QBwJ
 aE7Ftz8pTG8uYXB3cPFgh5k3oliRzbsNaMV7YlaeYY9F53nqhhLmNSpYKs8+xr2o1tFtQCVmXOK17
 nEIqFyr0esho84GI3lPb9QrCB50x835DJLpGwsaUDPm/GKcicSWTwyiXY3idRAa5ud6Gpmgn6yNRh
 k58dl0RA==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4ffz-0006pl-Ul; Thu, 20 Feb 2020 06:51:11 +0000
Subject: Re: [PATCH v3 05/10] ASoC: tegra: add Tegra210 based AHUB driver
To: Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
 robh+dt@kernel.org
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-6-git-send-email-spujar@nvidia.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2d655f98-33ed-1dcf-f346-e1f1b267f0cd@infradead.org>
Date: Wed, 19 Feb 2020 22:51:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-6-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 jonathanh@nvidia.com, viswanathl@nvidia.com, sharadg@nvidia.com,
 broonie@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 digetx@gmail.com, rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

On 2/19/20 10:34 PM, Sameer Pujar wrote:
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index 157fa7a..0c07f63 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -62,6 +62,16 @@ config SND_SOC_TEGRA30_I2S
>  	  Tegra30 I2S interface. You will also need to select the individual
>  	  machine drivers to support below.
>  
> +config SND_SOC_TEGRA210_AHUB
> +        tristate "Tegra210 AHUB module"
> +        depends on SND_SOC_TEGRA
> +        help
> +	  Config to enable Audio Hub (AHUB) module, which comprises of a
> +	  switch called Audio Crossbar (AXBAR) used to configure or modify
> +	  the audio routing path between various HW accelerators present in
> +	  AHUB.
> +          Say Y or M if you want to add support for Tegra210 AHUB module.
> +
>  config SND_SOC_TEGRA210_DMIC
>          tristate "Tegra210 DMIC module"
>          depends on SND_SOC_TEGRA

Please fix above according to Documentation/process/coding-style.rst:

10) Kconfig configuration files
-------------------------------

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


-- 
~Randy

