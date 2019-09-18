Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB91C4CEC9
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:17:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68A021920
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c/rFWypu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XCvHH66n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A021920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0A0D166D;
	Wed, 18 Sep 2019 11:16:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0A0D166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568798249;
	bh=ve838rTBjSIpwcnCzufQUMh19kIfLBiiSpvgPMqYz9c=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/rFWypuMCaNoJ7A8usrl9/MFEUxJPJSBPD+DzCnJarx39lttcW0qoAEapbjzYpyf
	 2J/OAAGzqYjw/xKvVCTNJhonxwLwTgwZkoyESwXN+nQztFJttIi+8CGTCdJYZJS7P/
	 cEkeBeE7vNmcklJnhavgXc4mQ5DUQC2Lozxi7np8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56BC0F80292;
	Wed, 18 Sep 2019 11:16:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2332F80506; Wed, 18 Sep 2019 11:16:36 +0200 (CEST)
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0309BF80292
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 11:16:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0309BF80292
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="XCvHH66n"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d81f5f50000>; Wed, 18 Sep 2019 02:16:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 18 Sep 2019 02:16:31 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 18 Sep 2019 02:16:31 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 09:16:31 +0000
Received: from [10.21.132.148] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 09:16:28 +0000
To: Ben Dooks <ben.dooks@codethink.co.uk>, <linux-tegra@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
References: <20190917181233.534-1-ben.dooks@codethink.co.uk>
 <20190917181233.534-9-ben.dooks@codethink.co.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <09346757-7643-f014-f054-35d981daad63@nvidia.com>
Date: Wed, 18 Sep 2019 10:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917181233.534-9-ben.dooks@codethink.co.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1568798197; bh=ZaqK1iPTgbOLy5vV3Bn+ADYCAYXMDznm8F2ReMgHtXs=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=XCvHH66nUpDFpn4VvtUEmy/7k/WlL254a9ciqCU6ThlevYrTsIZCY97HOThNpCAbu
 AcmKZCF5ceMXFEoklS77jE1xpbCm+hr02PzbjgLa0ZWNwgLpPNcOhMs4zgy6HANcbM
 56YL4f9TiWzd3fEZOmDkdQNJ6kKr+uLIwAlNhYz6EaL9h1q7G4GgwFtJvqVxZuxjk3
 NakvnYFL1ZqmExkS2/mB6XxTfr7159ueiWfb/nlbZTt/Kh+6JzQ/aQDINbytat8EfF
 Rrj7KNeBGzlyCGhOLuqPjgH/ox6Q+cMulSbSxuT746vW+pXKWw3iZMfqd9VctVWl+w
 sgo1hSpf/2Gnw==
Cc: linux-kernel@lists.codethink.co.uk, Sameer Pujar <spujar@nvidia.com>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: tegra: take packing settings
 from the audio cif_config
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
> If the CIF is not configured as 16 or 8 bit, then the
> packing for 8/16 bits should not be enabled as the
> hardware only supports 8 or 16 bit packing.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_ahub.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
> index 58e05ceb86da..c2f2e29dd32e 100644
> --- a/sound/soc/tegra/tegra30_ahub.c
> +++ b/sound/soc/tegra/tegra30_ahub.c
> @@ -96,10 +96,17 @@ int tegra30_ahub_setup_rx_fifo(enum tegra30_ahub_rxcif rxcif,
>  	      (channel * TEGRA30_AHUB_CHANNEL_CTRL_STRIDE);
>  	val = tegra30_apbif_read(reg);
>  	val &= ~(TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_MASK |
> -		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK);
> -	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT) |
> -	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN |
> -	       TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
> +		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_MASK |
> +		 TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN);
> +	val |= (7 << TEGRA30_AHUB_CHANNEL_CTRL_RX_THRESHOLD_SHIFT);
> +	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16 ||
> +	    cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
> +		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_EN;
> +	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_16)
> +		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_16;
> +	if (cif_conf->audio_bits == TEGRA30_AUDIOCIF_BITS_8)
> +		val |= TEGRA30_AHUB_CHANNEL_CTRL_RX_PACK_8_4;
> +
Ah maybe this is what I am missing from the previous patch. So the last
patch was a preparatory patch for this one.

Sameer, how is this handled in the case of Tegra210?

Cheers
Jon

-- 
nvpublic
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
