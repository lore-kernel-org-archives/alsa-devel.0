Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E8CA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:14:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A2E2166E
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dUf6c6j+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fz0xIPtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D48C616E9;
	Thu, 24 Oct 2019 18:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D48C616E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571933641;
	bh=rmDaSrj8O87j9Z9HISg7J8NjOe/DV93BVT5chKDNoR8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUf6c6j+hF8WFjipxdXQ2d4seiiJr27d4SCmpeU4Sv2HQx4lgDcXlDwtOc+WTTYDX
	 O+94y1lJsJv464lX90ZKF+zaj3XHxYkJltMdl0JvjsU10wd4nIjFPC+CkccGuO99SA
	 2GJnvAYk88Gs4mb1OIxF4TnouBsE8tfrh5p2gq34=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4888DF80390;
	Thu, 24 Oct 2019 18:13:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 763CDF80367; Thu, 24 Oct 2019 18:13:06 +0200 (CEST)
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 816ADF80367
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 18:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 816ADF80367
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="fz0xIPtc"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5db1cd8e0000>; Thu, 24 Oct 2019 09:13:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Oct 2019 09:12:58 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Oct 2019 09:12:58 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Oct
 2019 16:12:57 +0000
Received: from [10.21.133.51] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Oct
 2019 16:12:55 +0000
To: Ben Dooks <ben.dooks@codethink.co.uk>, <linux-tegra@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
 <20191018154833.7560-5-ben.dooks@codethink.co.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d108c4e4-5e74-0f33-0665-e6b0f9910523@nvidia.com>
Date: Thu, 24 Oct 2019 17:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018154833.7560-5-ben.dooks@codethink.co.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1571933582; bh=LqS6cGXJzUpR23ri7UWuZkja6p0LGrhMjbD/GDLT470=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=fz0xIPtcnCnHvI5d87HGj02pQZenH3rjqDNM010AvNdLCJSYQXrARzO/0LWaIH3/Y
 TKsPuPmHl0dBjm1xnu8kQ/Dq8u+yW/chxxGDuukS3Y+ESXlT0Dka2A+LUoWqlstncS
 bExfEjvbOG3u7FuDMf8OAbbs1G8ylW9q46vZGmMn5yc1wmODfsOKPfgquCZT9/fl0T
 Vrg5BYb7DYE0omnrdDWsQMDZGAzhqjq6fuzLh2PpD8QKMc89SnbNutCK3x5ePp+7eI
 ilbY4jispC5tK17O/4Ypvm+Xz2StlDhblZ7tBt8dRUgvzBjait5Wa/NBl6AN1VB85k
 UjTG/x+2aNw7g==
Cc: linux-kernel@lists.codethink.co.uk
Subject: Re: [alsa-devel] [PATCH v5 4/7] ASoC: tegra: disable rx_fifo after
	disable stream
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


On 18/10/2019 16:48, Ben Dooks wrote:
> We see odd FIFO overruns with this, we assume the best thing to do is
> to disable the RX I2S frontend first, and then disable the FIFO that
> is using it.
> 
> This also fixes an issue where using multi-word frames (TDM) have
> partial samples stuck in the FIFO which then get read out when the
> next capture is started.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> index fc77e65a3646..3839e3d955a8 100644
> --- a/sound/soc/tegra/tegra30_i2s.c
> +++ b/sound/soc/tegra/tegra30_i2s.c
> @@ -236,9 +236,9 @@ static void tegra30_i2s_start_capture(struct tegra30_i2s *i2s)
>  
>  static void tegra30_i2s_stop_capture(struct tegra30_i2s *i2s)
>  {
> -	tegra30_ahub_disable_rx_fifo(i2s->capture_fifo_cif);
>  	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CTRL,
>  			   TEGRA30_I2S_CTRL_XFER_EN_RX, 0);
> +	tegra30_ahub_disable_rx_fifo(i2s->capture_fifo_cif);
>  }
>  
>  static int tegra30_i2s_trigger(struct snd_pcm_substream *substream, int cmd,

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
