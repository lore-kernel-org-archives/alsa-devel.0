Return-Path: <SRS0=k5Qg=4P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B078DC4BA06
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:42:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C862467A
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p3luD0tu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmPw2xDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C862467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C2DD1671;
	Thu, 27 Feb 2020 04:41:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C2DD1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582774941;
	bh=9z/4986ETSWAnyDSy9DTKAEdu9nejKrloDXWaU3ZZ3w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3luD0tuw1hkS1SJ4FiFMV4+fxep329JWJME26574IYPsJa7It76EIw3TDbyNe3/p
	 xSZrFZvFJCABr6y7k2s4rymug5WkjGBxWGxbL+1c3hwiv+HX8qZ0EsePhF6xweEKHl
	 R7OS4mVCn1YcO3COpM0AA0SBLP4m8dldeFAm/ZWk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B42BF8013E;
	Thu, 27 Feb 2020 04:41:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F22EF80142; Thu, 27 Feb 2020 04:41:29 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41B14F80125
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2020 04:41:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41B14F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="gmPw2xDs"
Received: by mail-pl1-x641.google.com with SMTP id t14so551164plr.8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 19:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VUxAWoyzRwTi4XcElESOl4e7XyRqkwqcDDvJbUZpLIg=;
 b=gmPw2xDsx9eKdgHlZEL2xC7Li/8YBXlNbCA+spXw9KKfoPRWYY0KhEEeVo4KC2o1UN
 YrNfxZD2lybH9mVLDj+vW/MJcIbegJHj1PeRAO04tnf28Bv/GJDG5lEc0zPKDTubtW6+
 N7IuMJPmP3mVcy8XVAlTdaqT1E2JxhEK5v/xdHjeyy807augrdOuYwNg+xDbcKfjDq9v
 jHAcRGuwNzIN3Yw/yuXMpKSZYqA5MZXi+2ZxZzj23cJPP3h3/A246g+LJnfnF+zURjDt
 uuHLQb7zdWVZ7jWWWGre5ezDmXMZasplcYWQ8/KYy346t8KZDjAG1MAvSBaQZYpcfvF7
 BXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VUxAWoyzRwTi4XcElESOl4e7XyRqkwqcDDvJbUZpLIg=;
 b=hJ68k3sqrswiZtfuedn2cFAtTnzoRAu+r3nRmDscy5WaQBO4ucz1cetJ/9hxBkKR9T
 OuoFvd8yL2QFy5EUgzK5DIvlTO++8o0q72pGNahPOte1j00IqAf0+SYrkkW8LwTLmO5/
 hZ106OdtIoqhTLFTe8LPKEQ93VMo7tv503EJWlKCk5GlYw0XdDVxgZRAJ7aM9h0Y1JYp
 1NmbfcI6W6ZexQrIiUUe6G2BretM1RL1KGM4gvN3bCvixyQv0n3lGVlzunJ5LWSZq3Dd
 hAU6ZvayEE4KlU4dY1IoQ5cFRvieRfjBZBmqv0zQCh81iw7TGzyUTpdTC3Dy7EO8d6a9
 YSvQ==
X-Gm-Message-State: APjAAAXRZf49j8/TY3ih+jHHVJo5SNGOIC9DAdVThyG7CLcxRZLC5BYG
 WHRPpWotQulZvvQ7pUzR410=
X-Google-Smtp-Source: APXvYqwu67NFja14RMtsEQ5nHb9nwgFD7snOj2gBrL1Jp1A8X2Zh72CwRRaPQ6P9a1KCWadgsyQGaQ==
X-Received: by 2002:a17:902:7b94:: with SMTP id
 w20mr2521900pll.257.1582774883581; 
 Wed, 26 Feb 2020 19:41:23 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e1sm4658282pff.188.2020.02.26.19.41.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 19:41:23 -0800 (PST)
Date: Wed, 26 Feb 2020 19:41:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_asrc: Change asrc_width to asrc_format
Message-ID: <20200227034121.GA20540@Asurada-Nvidia.nvidia.com>
References: <cover.1582770784.git.shengjiu.wang@nxp.com>
 <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd5ff2fd0e8ad03a97f6a640630cff767d73fa7.1582770784.git.shengjiu.wang@nxp.com>
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

On Thu, Feb 27, 2020 at 10:41:55AM +0800, Shengjiu Wang wrote:
> asrc_format is more inteligent variable, which is align
> with the alsa definition snd_pcm_format_t.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     | 23 +++++++++++------------
>  sound/soc/fsl/fsl_asrc.h     |  4 ++--
>  sound/soc/fsl/fsl_asrc_dma.c |  2 +-
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 0dcebc24c312..2b6a1643573c 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c

> @@ -600,11 +599,6 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
>  
>  	pair->config = &config;
>  
> -	if (asrc_priv->asrc_width == 16)
> -		format = SNDRV_PCM_FORMAT_S16_LE;
> -	else
> -		format = SNDRV_PCM_FORMAT_S24_LE;

It feels better to me that we have format settings in hw_params().

Why not let fsl_easrc align with this? Any reason that I'm missing?
