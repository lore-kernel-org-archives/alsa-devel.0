Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B768C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:42:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D579520674
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o8OFfdM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D579520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEE6083A;
	Mon, 11 Nov 2019 17:41:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEE6083A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573490536;
	bh=9p5pPv5froAd+5DRx61+/3QiaTqWEKx3O1DHVx9Eh88=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8OFfdM1JBnaHmNGY4rhycy1595YXM/J/S2II36pbGspLVH/brvB2Uc1dWh8+AzIv
	 yc844qDjXrY9fHOXyhE37eJAJHX06cUKgUuFcAFPjAHxO5vuo/79aQzM/d8jUHrq6n
	 V0RitSS6GoVN7B7I1xLRT8iu8T1qlC5nE/GMF5DI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FD98F80506;
	Mon, 11 Nov 2019 17:41:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D99AF80275; Mon, 11 Nov 2019 17:41:24 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B026F80275
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 17:41:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B026F80275
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 08:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; d="scan'208";a="193986437"
Received: from magalleg-mobl3.amr.corp.intel.com (HELO [10.251.146.103])
 ([10.251.146.103])
 by orsmga007.jf.intel.com with ESMTP; 11 Nov 2019 08:41:16 -0800
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
References: <20190923162940.199580-1-yuhsuan@chromium.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba9f2c6a-42e8-1195-dbb7-cf5867915aa6@linux.intel.com>
Date: Mon, 11 Nov 2019 09:36:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20190923162940.199580-1-yuhsuan@chromium.org>
Content-Language: en-US
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel:
 kbl_rt5663_rt5514_max98927: Add dmic format constraint
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 9/23/19 11:29 AM, Yu-Hsuan Hsu wrote:
> On KBL platform, the microphone is attached to external codec(rt5514)
> instead of PCH. However, TDM slot between PCH and codec is 16 bits only.
> In order to avoid setting wrong format, we should add a constraint to
> force to use 16 bits format forever.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
> I have updated the commit message. Please see whether it is clear
> enough. Thanks.

Sorry, I missed this patch. Looks ok, though the 'right' approach would 
be to have topology and/or copiers deal with format changes.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


>   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 74dda8784f1a01..67b276a65a8d2d 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
>   	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
>   			dmic_constraints);
>   
> +	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
> +
>   	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>   			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
>   }
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
