Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D53C83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E87620730
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t+cghVK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B67D91686;
	Tue, 28 Apr 2020 23:43:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B67D91686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588110254;
	bh=QrWD8+fzUqfXNEcQoO+MiHOSY3IS7FeQVoT9gJYsEKs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+cghVK4fePzgRTD+DGJE9CP07yis09PqIatOxuonFOPNK1d+TuVHQwOZSlZrgV0o
	 VZWS2rtaZWm6LlM2Hsf/Q663dqn3sWOpUxOvy8WbUaeZrelmdMNO4+lwQTYP9xievt
	 UYi/9n1lmi7uoAfh7ZcrUqQxKlnrDJ42Rqr2DyW8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C94FF801F7;
	Tue, 28 Apr 2020 23:43:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A839F801DB; Tue, 28 Apr 2020 23:43:20 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AF21F800B8;
 Tue, 28 Apr 2020 23:43:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AF21F800B8
IronPort-SDR: /tOmdxv1Kkmi0aUeDRDOQ4K2sD4qd1+hUW9Xz09Clea1QQ3FYMOO69xmuo0phGLpuTynBXS8Ze
 5edGwVLwWzJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 14:43:07 -0700
IronPort-SDR: zK/pOH0bB0NT5PPv86h4FZnum68iEaTsGInoqhARg7hctD54dmmM1+W6iUI50j6u6vBwxrQD+7
 Cq0xOkcDVr8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="249285767"
Received: from asehgal-mobl.amr.corp.intel.com (HELO [10.254.29.183])
 ([10.254.29.183])
 by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 14:43:04 -0700
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>
References: <20200428212752.2901778-1-arnd@arndb.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
Date: Tue, 28 Apr 2020 16:43:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428212752.2901778-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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



On 4/28/20 4:27 PM, Arnd Bergmann wrote:
> The imx8 config keeps causing issues:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SOF_IMX8M
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && IMX_DSP [=n]
>    Selected by [m]:
>    - SND_SOC_SOF_IMX_OF [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_IMX_TOPLEVEL [=y] && SND_SOC_SOF_IMX8M_SUPPORT [=y]
> 
> This is complicated by two drivers having dependencies on both
> platform specific drivers and the SND_SOC_SOF_OF framework code,
> and using an somewhat obscure method to build them the same way
> as the SOC_SOF_OF symbol (built-in or modular).
> 
> My solution now ensures that the two drivers can only be enabled
> when the dependencies are met:
> 
> - When the platform specific drivers are built-in, everything is
>    fine, as SOC_SOF_OF is either =y or =m
> 
> - When both are loadable modules, it also works, both for Kconfig
>    and at runtime
> 
> - When the hardware drivers are loadable modules or disabled, and
>    SOC_SOF_OF=y, prevent the IMX_SOF_OF drivers from being turned on,
>    as this would be broken.
> 
> It seems that this is just an elaborate way to describe two tristate
> symbols that have straight dependencies, but maybe I'm missing some
> subtle point. It seems to always build for me now.

Thanks Arnd, do you mind sharing your config? We noticed last week that 
there's a depend/select confusion might be simpler to fix, see 
https://github.com/thesofproject/linux/pull/2047/commits

If I look at the first line I see a IMX_DSP=n which looks exactly like 
what we wanted to fix.

> 
> Fixes: fe57a92c8858 ("ASoC: SOF: Add missing dependency on IMX_SCU")
> Fixes: afb93d716533 ("ASoC: SOF: imx: Add i.MX8M HW support")
> Fixes: cb0312f61c3e ("ASoC: SOF: imx: fix undefined reference issue")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/imx/Kconfig | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index f76660e91382..66684d7590f4 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -21,7 +21,8 @@ config SND_SOC_SOF_IMX_OF
>   
>   config SND_SOC_SOF_IMX8_SUPPORT
>   	bool "SOF support for i.MX8"
> -	depends on IMX_SCU
> +	depends on IMX_SCU=y || IMX_SCU=SND_SOC_SOF_IMX_OF
> +	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_IMX_OF
>   	help
>   	  This adds support for Sound Open Firmware for NXP i.MX8 platforms
>   	  Say Y if you have such a device.
> @@ -29,14 +30,13 @@ config SND_SOC_SOF_IMX8_SUPPORT
>   
>   config SND_SOC_SOF_IMX8
>   	tristate
> -	depends on IMX_SCU
> -	select IMX_DSP
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
>   
>   config SND_SOC_SOF_IMX8M_SUPPORT
>   	bool "SOF support for i.MX8M"
> +	depends on IMX_DSP=y || IMX_DSP=SND_SOC_SOF_OF
>   	help
>   	  This adds support for Sound Open Firmware for NXP i.MX8M platforms
>   	  Say Y if you have such a device.
> @@ -44,7 +44,6 @@ config SND_SOC_SOF_IMX8M_SUPPORT
>   
>   config SND_SOC_SOF_IMX8M
>   	tristate
> -	depends on IMX_DSP
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
> 
