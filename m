Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C383C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Mar 2023 18:49:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE40217B4;
	Fri, 10 Mar 2023 19:48:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE40217B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678474172;
	bh=r03cO5GqkX9M+5ozAIBTo8H/tw88jbZWUChm4xxL/4A=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=apLFyIxLczhqI/s4qADfz01NC+8/0Is4e4ArTcqnR4gSmDsP2SkH3GkpuWG9s5NmI
	 Gg1WhFPcKfVR4WCFq8QgyOmvQ6bO+cMkmLDo0oZN4ynXxtm9wiX0R74iW6kEbXMfxA
	 bn6X7i+2Tpq1k4z355YrUI5Mg59cVe60GWyYdWNc=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C5B0F8042F;
	Fri, 10 Mar 2023 19:48:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 58A35F8042F; Fri, 10 Mar 2023 19:48:17 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E189F80093
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2023 19:48:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E189F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Trg2ZR0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678474095; x=1710010095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r03cO5GqkX9M+5ozAIBTo8H/tw88jbZWUChm4xxL/4A=;
  b=Trg2ZR0Ew5ByHA8He7+9Fxb5Frk7yfrqFPc3w7xE+E9X74ivitKsW6Wg
   bBwpF6tsPS1EttjPl723+5or3Efs71J/nl0q59edXVPpmh/hqffSJum1p
   X5V3pctKovews/ALam44gOh5mqldXdE9U/jIdo+y0E680Hgt1T6gDalG/
   BdV3celgfDe7TJQAIdverxCc78gWLbSDnnXYFFQXlFAjl3sGFfyae3Cg7
   W/j8XZVkOkaOu9IKwfXFGMNF6QmDD2jdkJBv8yv6q/PQ5HU4mEfcoFSw+
   uhR0QlyQaTOT9yT6DlBba5N3ZAjMyZgQNxyjD7tM+O+IyFEnvjpVnQkSD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="317193853"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="317193853"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 10:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="671178486"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400";
   d="scan'208";a="671178486"
Received: from ikably-mobl.amr.corp.intel.com (HELO [10.255.33.96])
 ([10.255.33.96])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2023 10:48:10 -0800
Message-ID: <0456bd4e-cfee-b863-e02d-98084b5da0f6@linux.intel.com>
Date: Fri, 10 Mar 2023 12:48:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v1] ASoC: Intel: sof_rt5682: Enable Bluetooth offload on
 adl_rt1019_rt5682
Content-Language: en-US
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
References: 
 <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: 
 <20230310184201.1302232-1-ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ZLSE3QNMFXBAR2LR7XCYIBH6W3OQGJVY
X-Message-ID-Hash: ZLSE3QNMFXBAR2LR7XCYIBH6W3OQGJVY
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Mark Brown <broonie@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Brent Lu <brent.lu@intel.com>, Yong Zhi <yong.zhi@intel.com>,
 dharageswari.r@intel.com, Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
 ye xingchen <ye.xingchen@zte.com.cn>, alsa-devel@alsa-project.org,
 Mac Chiang <mac.chiang@intel.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZLSE3QNMFXBAR2LR7XCYIBH6W3OQGJVY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 3/10/23 12:42, Ajye Huang wrote:
> Enable Bluetooth audio offload for drv_name "adl_rt1019_rt5682" with
> following board configuration specifically:
> 
> SSP0 - rt5682 Headset
> SSP1 - alc1019p speaker amp
> SSP2 - Bluetooth audio
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 4fe448295a90..2eec32846078 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1109,7 +1109,9 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_SPEAKER_AMP_PRESENT |
>  					SOF_RT1019_SPEAKER_AMP_PRESENT |
>  					SOF_RT5682_SSP_AMP(1) |
> -					SOF_RT5682_NUM_HDMIDEV(4)),
> +					SOF_RT5682_NUM_HDMIDEV(4) |
> +					SOF_BT_OFFLOAD_SSP(2) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),

This sounds good, but if the intent is to have BT offload enabled across
all ADL skews there are still misses, e.g.

.name = "adl_mx98357_rt5682",

Can we please try to add this BT offload in a more consistent manner, or
add a comment when this is officially not planned/supported?
