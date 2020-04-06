Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA1C2BA17
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:08:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65A42492F
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 16:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ud48rDMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65A42492F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 241671665;
	Mon,  6 Apr 2020 18:07:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 241671665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586189296;
	bh=VL4AgVrjLIht3lFpRhnX/CIKqam1ZgF6f60IDw1w320=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ud48rDMGsbLQowPQzwN+eiP0kxs/nfwwZD2aaoGhxqINreCd+EUPwAerZdw68uqPM
	 +Oq59tzWiWErNjpHppLPNSUwy7MUllSsMzpZ2LWs2WT/zcbYiBykKtENIkcKHFCTiC
	 mvzl1Gfe5ddShISMDN06t5bQ/VlDfzmA9SgMIyQQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 448E5F80257;
	Mon,  6 Apr 2020 18:05:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83922F80142; Mon,  6 Apr 2020 18:05:43 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1214F80143
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 18:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1214F80143
IronPort-SDR: eJ2C5/daycYP2HnVtiJI7pZ4TGQOpEao5sc2p/KXAqVrIuYa/dSx6vNWuFWdz5ny+0ZbRBtw/Y
 Usdr7r6qTlOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 09:05:34 -0700
IronPort-SDR: ii0iwCRO86xvuYQ/vBQPO0Gljd4T3RPA0b7t3M9kU/+EYZyByZ84ARMkQgtnDAybJsTz7vE5SP
 fMiBBTuw7PmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,351,1580803200"; d="scan'208";a="361256324"
Received: from mmarathe-mobl1.amr.corp.intel.com (HELO [10.212.38.219])
 ([10.212.38.219])
 by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2020 09:05:33 -0700
Subject: Re: [PATCH] ASoC: rt5645: Add platform-data for Medion E1239T
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
References: <20200402185257.3355-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <61d0231e-4dfb-0ebe-e255-437f28648387@linux.intel.com>
Date: Mon, 6 Apr 2020 10:30:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402185257.3355-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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



On 4/2/20 1:52 PM, Hans de Goede wrote:
> The Medion E1239T uses the default jack-detect mode 3, but instead of
> using an analog microphone it is using a DMIC on dmic-data-pin 1,
> like other models following Intel's Brasswell's reference design.
> 
> This commit adds a DMI quirk pointing to the intel_braswell_platform_data
> for this model.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/codecs/rt5645.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 92d67010aeed..6ba1849a77b0 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3758,6 +3758,14 @@ static const struct dmi_system_id dmi_platform_data[] = {
>   		},
>   		.driver_data = (void *)&kahlee_platform_data,
>   	},
> +	{
> +		.ident = "Medion E1239T",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "E1239T MD60568"),
> +		},
> +		.driver_data = (void *)&intel_braswell_platform_data,
> +	},
>   	{ }
>   };
>   
> 
