Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3883C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 21:16:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D4964F13
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 21:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4964F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DA991686;
	Fri, 26 Feb 2021 22:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DA991686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614374178;
	bh=/d/WFU1kWMWeqjGNPNtSRboPAE8dPZOprGlz9rFxzu0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jUSbdy9PWi2AWKft8uQQZXT4sZCaDCuCGQD3FUf+83EVlknqNFzY1lJwvRsoHlHoS
	 o1I/AVLch/AKPsBkGUdcdJStCMgCX4S9AF6Mk2z8iNnqZsicJLXJKUnWgxleiEOzWa
	 dz+ZrS/lo5P9X1wlkuxqs5A/5hDWCdltV62Mv9ZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1FA5F80159;
	Fri, 26 Feb 2021 22:15:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0E0FF8016C; Fri, 26 Feb 2021 22:15:25 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C0C6F80154
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 22:15:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C0C6F80154
IronPort-SDR: ATr4mIrw43H5pzjtB1jE5O1Bl44YDisUgH2B789Sdc37RctvCx3HV1T/KAoHQWevZL4dZ68YIT
 1P2AKybHkNqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="165214595"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="165214595"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 13:15:13 -0800
IronPort-SDR: XHJF39AQuMxzrmE/rm6sKjMb9x2aD/1wN7vm+ZhZBKi0T1G5BOSr3p95PH592uHBEKcd9qx6/8
 wtOYyx754PjA==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="432910738"
Received: from esnyder-desk.amr.corp.intel.com (HELO [10.255.230.205])
 ([10.255.230.205])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 13:15:11 -0800
Subject: Re: [PATCH] ASoC: Intel: boards: sof-wm8804: add check for PLL setting
To: Colin King <colin.king@canonical.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
References: <20210226185653.1071321-1-colin.king@canonical.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <644f14f9-52b5-235d-76fa-ec35668542cd@linux.intel.com>
Date: Fri, 26 Feb 2021 14:54:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226185653.1071321-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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



On 2/26/21 12:56 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return from snd_soc_dai_set_pll is not checking for
> failure, this is the only driver in the kernel that ignores this,
> so it probably should be added for sake of completeness.  Fix this
> by adding an error return check.
> 
> Addresses-Coverity: ("Unchecked return value")
> Fixes: f139546fb7d4 ("ASoC: Intel: boards: sof-wm8804: support for Hifiberry Digiplus boards")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/sof_wm8804.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
> index a46ba13e8eb0..6a181e45143d 100644
> --- a/sound/soc/intel/boards/sof_wm8804.c
> +++ b/sound/soc/intel/boards/sof_wm8804.c
> @@ -124,7 +124,11 @@ static int sof_wm8804_hw_params(struct snd_pcm_substream *substream,
>   	}
>   
>   	snd_soc_dai_set_clkdiv(codec_dai, WM8804_MCLK_DIV, mclk_div);
> -	snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
> +	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, sysclk, mclk_freq);
> +	if (ret < 0) {
> +		dev_err(rtd->card->dev, "Failed to set WM8804 PLL\n");
> +		return ret;
> +	}
>   
>   	ret = snd_soc_dai_set_sysclk(codec_dai, WM8804_TX_CLKSRC_PLL,
>   				     sysclk, SND_SOC_CLOCK_OUT);
> 
