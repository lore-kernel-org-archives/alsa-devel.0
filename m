Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA6EC433E8
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:34:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2A72074F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R4iQ8f+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2A72074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13E7E16AC;
	Mon, 27 Jul 2020 17:33:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13E7E16AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595864044;
	bh=zJaN4dzDuQ1YPgG7eYtO/6FgjylZoqLWE0wfT3/gX3I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R4iQ8f+UBqdTDx4DttJBoHhOmQDDl+PuUcKEjdrULuAV60kOI3JPOqJCSFUM+aL1P
	 LkXmkjKDgmX6DPG6/tfnLdWkHokFqciv0dmaU9tGjyXyMdBBnfya7C8oh36P+e4Kcb
	 VQgi3boSVY/OoQTd7S1nzNlTG6ICSLaQp4ScdaTo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69456F80246;
	Mon, 27 Jul 2020 17:32:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69C51F801EB; Mon, 27 Jul 2020 17:32:14 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E524F800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 17:32:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E524F800DE
IronPort-SDR: 5H2Z1+VkPJdrlUzYKXWKVspGYjNFCZmGmhT6RlVna+86fzTXg8GiFbQo9ibUWtILFxsd/wxv1G
 cP97BbLvlS7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="169154643"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; d="scan'208";a="169154643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 08:32:01 -0700
IronPort-SDR: N9v2zia3/Nh5wPi/k4sgQ299PY/D0/PAYHd5js99/HLd3x2F3G9xVpxpuOil8Eb7h2XndIHwf7
 YrBmjrbjwadw==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; d="scan'208";a="464099696"
Received: from pdewan-mobl1.amr.corp.intel.com (HELO [10.255.228.220])
 ([10.255.228.220])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 08:32:00 -0700
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
Date: Mon, 27 Jul 2020 10:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>, YueHaibing <yuehaibing@huawei.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Alexander.Deucher@amd.com, Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>
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



On 7/27/20 9:58 AM, Ravulapati Vishnu vardhan rao wrote:
> changing SND_SOC_RT5682_I2C to SND_SOC_RT5682 because,
> This flag which was previously set as SND_SOC_RT5682
> used to build rt5682 codec driver but by changing into
> SND_SOC_RT5682_I2C is preventing to build rt5682 codec
> driver and machine driver fails to probe.So Reverting the changes.

The split between I2C and SoundWire means you have to choose the I2C or 
SDW mode. Selecting the common part looks very strange.

see Intel machine drviers:

Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_I2C
Kconfig:	select SND_SOC_RT5682_SDW

> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index e37cf72f2bab..77ffdb41bee5 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -29,7 +29,7 @@ config SND_SOC_AMD_ACP3x
>   
>   config SND_SOC_AMD_RV_RT5682_MACH
>   	tristate "AMD RV support for RT5682"
> -	select SND_SOC_RT5682_I2C
> +	select SND_SOC_RT5682
>   	select SND_SOC_MAX98357A
>   	select SND_SOC_CROS_EC_CODEC
>   	select I2C_CROS_EC_TUNNEL
> 
