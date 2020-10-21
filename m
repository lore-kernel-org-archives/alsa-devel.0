Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C97C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:58:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B592177B
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MjqaaJB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B592177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E715517E3;
	Wed, 21 Oct 2020 15:57:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E715517E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603288683;
	bh=gbdy0uc5afNQ3mRjWJyIJa4X45o7tj5f2xbf1c9xA+s=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjqaaJB4Y2yBnkKvqe1cOi0N/vP6C+TEdkSZlkc0KUgQIpFGa+SytXKFa/HIuqVGW
	 90KVpZ6RFhW8/BChMZIwsG/s0bf0ul2FxCZr2Lc0IfJrJu2Awy26EWHuezNzONQZ05
	 acllRqBrnhu2YVdEn3WOb67+f14q/ADmEIzX69G8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D520F80253;
	Wed, 21 Oct 2020 15:57:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFC26F80111; Wed, 21 Oct 2020 15:57:10 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 772EEF80111
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 15:57:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 772EEF80111
IronPort-SDR: 22RyB8GFXRJD9jqOCBtnk3CBRDPb2bFkjfbAHE4D5H0KK4kCJYmHZIXya0O4lEqXQtH3LhiqBc
 OVsqzvI4txwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167459489"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="167459489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 06:57:01 -0700
IronPort-SDR: +z4CzkPOiPBawPgQkw9gwBfe67D38Br9kiPriXxcYZHhPvrv2ncEb0lSuSJyM3vXi7Klfs94VJ
 pGVl9K7BzyGQ==
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; d="scan'208";a="353681561"
Received: from gyelchur-mobl1.amr.corp.intel.com (HELO [10.252.136.114])
 ([10.252.136.114])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 06:56:59 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: update quirk for cml boards
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20201021072646.7980-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ae005e9-4cd9-31ef-56cb-504edc4cd503@linux.intel.com>
Date: Wed, 21 Oct 2020 08:56:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021072646.7980-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Dharageswari R <dharageswari.r@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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



On 10/21/20 2:26 AM, Brent Lu wrote:
> The default quirk data of sof_rt5682 is for tgl platform. For cml
> platforms to reuse this driver, the flag SOF_RT5682_MCLK_24MHZ is
> necessary to setup codec asrc correctly.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/sof_rt5682.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index ddbb9fe7cc06..fa2c226a444a 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -768,6 +768,11 @@ static int sof_audio_probe(struct platform_device *pdev)
>   		/* default number of HDMI DAI's */
>   		if (!hdmi_num)
>   			hdmi_num = 3;
> +
> +		if (soc_intel_is_cml()) {
> +			/* default quirk for sof_rt5682 is for tgl platform */
> +			sof_rt5682_quirk |= SOF_RT5682_MCLK_24MHZ;
> +		}

That setting is not wrong, but is it sufficient?

see e.g. what we set for existing platforms which need 24 Mhz in this 
driver:

DMI quirks:

	{
		.callback = sof_rt5682_quirk_cb,
		.matches = {
			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Hatch"),
		},
		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
					SOF_RT5682_MCLK_24MHZ |
					SOF_RT5682_SSP_CODEC(0) |
					SOF_SPEAKER_AMP_PRESENT |
					SOF_RT5682_SSP_AMP(1)),
	},

Board-id quirks:

	{
		.name = "jsl_rt5682_rt1015",
		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
					SOF_RT5682_MCLK_24MHZ |
					SOF_RT5682_SSP_CODEC(0) |
					SOF_SPEAKER_AMP_PRESENT |
					SOF_RT1015_SPEAKER_AMP_PRESENT |
					SOF_RT5682_SSP_AMP(1)),
	},

You probably need a board-id quirk dedicated to CML, rather than 
override the TGL one?
