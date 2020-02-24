Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC88C11D2F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:06:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC572080D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sX8XbB7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC572080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E440E1672;
	Mon, 24 Feb 2020 18:05:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E440E1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582564010;
	bh=EkBLuLn9r0JV3bvo2spu25mGYzNHZ4unn6+SegXFZbQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sX8XbB7XbWuFf0OydpIhzy7wPVQYoAeE70FG5L63h6iPoiYl9jm4soHLXVCVhW6Kj
	 kavMGvFFoY66vXD+STI8wn01ltggBOUZ4sxW1lNSrmJr9CcNtqIb3FtVPdqQDUCaVZ
	 Ojq/qgO4rLCD7SDrk5WVelBU9rcpqj/wV3fRRmOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FF2BF8016F;
	Mon, 24 Feb 2020 18:05:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19A44F8014D; Mon, 24 Feb 2020 18:05:58 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F72DF8014D
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 18:05:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F72DF8014D
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 09:05:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="230713367"
Received: from rjgardn2-mobl1.amr.corp.intel.com (HELO [10.254.182.151])
 ([10.254.182.151])
 by orsmga008.jf.intel.com with ESMTP; 24 Feb 2020 09:05:49 -0800
Subject: Re: [PATCH] ASoC: Intel: Skylake: Fix available clock counter
 incrementation
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
References: <20200224125202.13784-1-amadeuszx.slawinski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ff5ef8e-8a95-14a3-b050-3dc974ffe22c@linux.intel.com>
Date: Mon, 24 Feb 2020 10:18:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224125202.13784-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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



On 2/24/20 6:52 AM, Amadeusz Sławiński wrote:
> Incrementation of avail_clk_cnt was incorrectly moved to error path. Put
> it back to success path.
> 
> Fixes: 6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev')
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
>   sound/soc/intel/skylake/skl-ssp-clk.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> index 1c0e5226cb5b..bd43885f3805 100644
> --- a/sound/soc/intel/skylake/skl-ssp-clk.c
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -384,9 +384,11 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
>   				&clks[i], clk_pdata, i);
>   
>   		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
> -			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
> +			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);

Are you sure?

If you start with avail_clk_cnt set to zero, the error handling will 
decrement and access offset -1

static void unregister_src_clk(struct skl_clk_data *dclk)
{
      while (dclk->avail_clk_cnt--)
          clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup); <<< oob 
access with offset -1
}

>   			goto err_unreg_skl_clk;
>   		}
> +
> +		data->avail_clk_cnt++;
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> 
