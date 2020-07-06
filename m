Return-Path: <SRS0=aG7p=AR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D99C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:17:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F1820715
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eWfBfxTC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d6OFUJ0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F1820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EEEED1654;
	Mon,  6 Jul 2020 17:16:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EEEED1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594048655;
	bh=QNWUBlpL7U3ZSiH1XRVBpy6VXJLUfJfXU4dpyjhRj1c=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWfBfxTCt56j8uKSI05xvwwc8nTztIKCmdEEQvJwnOG4s7nbidLS1e3E2p3uOtZqV
	 rc8ci3F2zDUUw88qfncYEAHFOa9dP+RO46ABwiOb3t8ZVtcdqnOMircEs797RsE2dF
	 vEYHGimuSbC3fziTNlLcnbeG0NNB9KKkwBl4uUtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 832CAF80150;
	Mon,  6 Jul 2020 17:16:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5CCEF8015A; Mon,  6 Jul 2020 17:16:42 +0200 (CEST)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62051F80125
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2020 17:16:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62051F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="d6OFUJ0p"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f033fe70000>; Mon, 06 Jul 2020 08:14:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 06 Jul 2020 08:16:32 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 06 Jul 2020 08:16:32 -0700
Received: from [10.26.72.33] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 15:16:20 +0000
Subject: Re: [PATCH 7/8] ASoC: tegra: tegra20_das: remove always-true
 comparison
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 <alsa-devel@alsa-project.org>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
 <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1a7c7025-7689-54a0-dbc0-00b5c1fcd0f1@nvidia.com>
Date: Mon, 6 Jul 2020 16:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1594048487; bh=S3qOsW4jy3ZymnO+RQ9II2XOQKKoroUl5+GuXsnukfU=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=d6OFUJ0pQtg6JQNVFCgkn/XX5QvOjZQA7YGkzOh5jeFI1EEr9d+9uXjmZBMHygc7i
 +fMiz5QaZP2St9MCr/wjAiDsGA3nMwV9kXM12bX28umi38ousxAkAwYFukFs2+qr9m
 DCXLZZuViVo6JARF8034PM2zUKb1ihpLn+de3tmDU2jrBRyOr0vEwRg86NdPauItf4
 lMLsoErnsyCo6EWjSVqqgECpya2Upq1awjOuxQRTSbpVVcDhRZ3bb7a3UXdcX1futz
 EbIQZhihEllFEKDsBgXLOX++Y4glQJTFP9jMsvK+dVkDw0Ou1BJJiDy1U19xd9q99L
 6MUUXS/P0jwUQ==
Cc: tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 YueHaibing <yuehaibing@huawei.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
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


On 02/07/2020 17:59, Pierre-Louis Bossart wrote:
> Fix W=1 warning:
> 
> sound/soc//tegra/tegra20_das.c:101:11: warning:
> comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>   101 |  if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
>       |           ^~
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/tegra/tegra20_das.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
> index 1070b2710d5e..79dba878d854 100644
> --- a/sound/soc/tegra/tegra20_das.c
> +++ b/sound/soc/tegra/tegra20_das.c
> @@ -98,8 +98,7 @@ EXPORT_SYMBOL_GPL(tegra20_das_connect_dac_to_dap);
>  
>  static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
>  {
> -	if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
> -	    (reg <= LAST_REG(DAP_CTRL_SEL)))
> +	if (reg <= LAST_REG(DAP_CTRL_SEL))
>  		return true;
>  	if ((reg >= TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL) &&
>  	    (reg <= LAST_REG(DAC_INPUT_DATA_CLK_SEL)))
> 

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
