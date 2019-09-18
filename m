Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB09C4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:15:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A49218AE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gputajIT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VBFCdTjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A49218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BC84166F;
	Wed, 18 Sep 2019 11:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BC84166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568798112;
	bh=Bs6duGjYc24TVTfRdlhfbDj8IAW5St3ZwNaiyl2pzgs=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gputajITn/zycs3HFstXiXurgPAzwL95eOks/jH71pFyCsPFqisq6hGOKuJq9cSeO
	 fjr1U85qezaHBVyzWiqcJjPulJ9ilgy/bEyRs/2Dz65xEYzwS/rFqUegUifddolLzH
	 kdvqjILLd5SKY/SGQtij8SY2QmykzenqpK7D8OY8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0243DF80292;
	Wed, 18 Sep 2019 11:14:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63864F80506; Wed, 18 Sep 2019 11:14:19 +0200 (CEST)
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A76D1F800C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 11:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A76D1F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="VBFCdTjt"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d81f56b0001>; Wed, 18 Sep 2019 02:14:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 18 Sep 2019 02:14:14 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 18 Sep 2019 02:14:14 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 09:14:13 +0000
Received: from [10.21.132.148] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 09:14:11 +0000
To: Ben Dooks <ben.dooks@codethink.co.uk>, <linux-tegra@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <20190917181233.534-1-ben.dooks@codethink.co.uk>
 <20190917181233.534-8-ben.dooks@codethink.co.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1956fa67-c654-f719-5c7c-5e4b40d01e3a@nvidia.com>
Date: Wed, 18 Sep 2019 10:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917181233.534-8-ben.dooks@codethink.co.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1568798060; bh=/LlTe+oxxZpC4IvRHBKrnvBPwarRus8FwhUHq+oVQmw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=VBFCdTjtCTKaw5rKPPDpAefNimfwpu6V3lrNPpifw2QCRQX326KlsO0AygYTk7V5R
 nGGYdnEJWaDP3Lp9uIEhKTFa8UOwfpdNXHlsl4c6RAR2rrE2nFlRQMfAu3Frv8wj3r
 7ojuduuLzLBjVKQOIRpU6SLvJMvYPmrLNodKjxmXlIWChBTmByFqx13nleJvzhBWZd
 TCwZXqcfjEYi0Qt1mCPFyFnmEm6gRYvDrMqOUC+BF/nJ9nxp1wMcQAQmoE3B3uAAwm
 wq8/8QspyZUvguxpgpQ72zvto4CCPUaYAa1g7kryx7W3NfsUafNRtoW8IFWA30pruJ
 eHY0mp0zmq+Qg==
Cc: linux-kernel@lists.codethink.co.uk, Sameer Pujar <spujar@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 7/8] ASoC: tegra: config fifos on hw_param
	changes
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



On 17/09/2019 19:12, Ben Dooks wrote:
> If the hw_params uses a different bit or channel count, then we
> need to change both the I2S unit's CIF configuration as well as
> the APBIF one.
> 
> To allow changing the APBIF, add a call to reconfigure the RX or
> TX FIFO without changing the DMA or allocation, and get the I2S
> driver to call it once the hw params have been calculate.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_ahub.c | 114 ++++++++++++++++++---------------
>  sound/soc/tegra/tegra30_ahub.h |   5 ++
>  sound/soc/tegra/tegra30_i2s.c  |   2 +
>  3 files changed, 69 insertions(+), 52 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
> index 952381260dc3..58e05ceb86da 100644
> --- a/sound/soc/tegra/tegra30_ahub.c
> +++ b/sound/soc/tegra/tegra30_ahub.c
> @@ -84,12 +84,40 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +int tegra30_ahub_setup_rx_fifo(enum tegra30_ahub_rxcif rxcif,
> +			       struct tegra30_ahub_cif_conf *cif_conf)
> +{
> +	int channel = rxcif - TEGRA30_AHUB_RXCIF_APBIF_RX0;
> +	u32 reg, val;
> +
> +	pm_runtime_get_sync(ahub->dev);
> +
> +	reg = TEGRA30_AHUB_CHANNEL_CTRL +
> +	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
> +	val = tegra30_apbif_read(reg);
> +	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK |
> +		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK);
> +	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT) |
> +	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN |
> +	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
> +	tegra30_apbif_write(reg, val);

Aren't you just programming the same value to the APBIF here that was
previously programmed by the allocate function? I don't see the point in
moving this? What am I missing here?

Cheers
Jon

-- 
nvpublic
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
