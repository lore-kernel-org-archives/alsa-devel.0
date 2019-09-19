Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A81C3A5A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:50:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0388D21907
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PWm0uPzl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNWSnXv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0388D21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A04011666;
	Fri, 20 Sep 2019 01:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A04011666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568937048;
	bh=5B4YXG7eATAAzT/B7uSy9yreaHrX31Ob7E5EkWA4cY8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWm0uPzlHv5HDAAJhVAYqEJKPDU1fMOUyMJpqIVX2aCgOdw4zt//WsYxL/zex60Br
	 Y4Sz40RObgah43xD+RcFDrGAjmCOquaj9CYqaUobD5xBQTX6d7HHrNeNz/vmiVdXO8
	 Lc3oGxp1THa7kR4hSPVPCIvYBYdEdzqoJJWfdIxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2235FF80307;
	Fri, 20 Sep 2019 01:49:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CB4EF80361; Fri, 20 Sep 2019 01:49:56 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71F3EF80096
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 01:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71F3EF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kNWSnXv4"
Received: by mail-pf1-x442.google.com with SMTP id b128so3320859pfa.1
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
 b=kNWSnXv4Q9H2UbWOSwbkFDyDYqrw5V5FmU8EqdV7tUgMVaqW5UnRoGaPbLRxAC+hEd
 3daoRlbwjVz6K32Az6qna8OmyjDaxJuCA2WvshtxpT7DkMnbifHYEJ0BsKiMtLFSyUv3
 xDtTO+b/VsYw08fNK30ntWhKO+BaL7AAi/8AlX1aHtOMrqbJ8T1WEIQpq9f5s4SWLwhz
 bMbeKs2DUZAbkByeqfxDZXfHVfm4ozWqy8uoRaFUJ9B0hw9MOXly7hJRc2nommYb7OBW
 jiKWP5+nLvTY4Ez/l9sDmXVwjP0y2WNKAAcZZMFAx8o/6PkqGygW6BcO7SHlaOPWr9Vk
 I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
 b=WGOYqAX8o0brOybBxBORovF1SxFvL4kbvVPRLWzzR2xvqjZI/oiPauDFVat7O6a6EG
 /91iEqKg0BimwYoXMmyn9ZzE6wwPBBnP/FiJqC8BJrFglij102c08iiqT+FhECJbEIsA
 Ga2v5vZYNsmXvnl023BToKALkY5HDQZ69qoDAA8/DdELQpIWbs6zbFxYZsYfdZi+uX0r
 R13IiS5EFzn5Hu4oUEhZiJnol974DWJAh3cy+ITrQ+mOI+GTZn8G6JXX7V7IZ1sJ7i26
 JyFbmpXNDLk+kKN6pRsAmzxcgJf4KtAj44WjtfiDkakG5AQP8UivR6LOOI//BKfdZMGj
 Xx/w==
X-Gm-Message-State: APjAAAUVL+5/BdwYFEVs0nBVWtQMEyponPeu7M3Re5UAy/MlPM4MmPJd
 ajrX2W0/TCK3OtOSVERmVX8=
X-Google-Smtp-Source: APXvYqxicFF4tS7Mcj+VMjT1qOkc2frSVMWmjKYUyhpoVLCZd7f7tLUEHubAzMDOxlG+EHV+svcZtA==
X-Received: by 2002:a62:1c16:: with SMTP id c22mr13829974pfc.10.1568936990878; 
 Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e21sm30169pgr.43.2019.09.19.16.49.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Date: Thu, 19 Sep 2019 16:48:58 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20190919234857.GA14287@Asurada-Nvidia.nvidia.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
 <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH V3 2/4] ASoC: fsl_asrc: update supported
	sample format
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

On Thu, Sep 19, 2019 at 08:11:40PM +0800, Shengjiu Wang wrote:
> The ASRC support 24bit/16bit/8bit input width, which is
> data width, not slot width.
> 
> For the S20_3LE format, the data with is 20bit, slot width
> is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
> is the volume is lower than expected, it likes 24bit data
> right shift 4 bits
> 
> So replace S20_3LE with S24_3LE in supported list and add S8
> format in TX supported list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 4d3804a1ea55..584badf956d2 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  
>  #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
>  				 SNDRV_PCM_FMTBIT_S16_LE | \
> -				 SNDRV_PCM_FMTBIT_S20_3LE)
> +				 SNDRV_PCM_FMTBIT_S24_3LE)
>  
>  static struct snd_soc_dai_driver fsl_asrc_dai = {
>  	.probe = fsl_asrc_dai_probe,
> @@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
>  		.rate_min = 5512,
>  		.rate_max = 192000,
>  		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_ASRC_FORMATS,
> +		.formats = FSL_ASRC_FORMATS |
> +			   SNDRV_PCM_FMTBIT_S8,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
> -- 
> 2.21.0
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
