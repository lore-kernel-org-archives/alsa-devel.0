Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B7C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:04:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E667206D7
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L3tjkJp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E667206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB0391666;
	Wed, 18 Dec 2019 19:03:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB0391666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576692289;
	bh=CHo7MRUqQYK/8m2K4zS/mVZ4tlxhaWbyDWz+Zw5av1o=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L3tjkJp5rOh0mtS72I5i3E/NuwtkYYC4uvlkoKwCBK/kDxpM4gby8RDRlUUciJor/
	 5RWQgb2KRl4JZfP9aVSEFMGUPbK2V0Zvn/RFCtnmyllaPX7wNOfP9wToRzsFQuN5Gi
	 UYUdRkr6b0QIz5gZlHw6y4yFlkZ50CDgh77YIO3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53F81F80268;
	Wed, 18 Dec 2019 19:02:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A85BF80266; Wed, 18 Dec 2019 19:02:18 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EC4AF80247
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 19:02:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EC4AF80247
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 10:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="415912297"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO [10.251.3.243])
 ([10.251.3.243])
 by fmsmga005.fm.intel.com with ESMTP; 18 Dec 2019 10:02:09 -0800
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191218143937.122665-1-cujomalainey@chromium.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <295df05e-e3c6-fed8-50fa-4b2ad87b3057@linux.intel.com>
Date: Wed, 18 Dec 2019 11:57:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218143937.122665-1-cujomalainey@chromium.org>
Content-Language: en-US
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Bard Liao <bardliao@realtek.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Naveen Manohar <naveen.m@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jon Flatley <jflat@chromium.org>, Bard liao <yung-chuan.liao@linux.intel.com>,
 Allison Randal <allison@lohutok.net>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: intel: Add Broadwell rt5650
 machine driver
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



On 12/18/19 8:39 AM, Curtis Malainey wrote:
> From: Ben Zhang <benzh@chromium.org>
> 
> Add machine driver for Broadwell + rt5650.
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Ben Zhang <benzh@chromium.org>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> Signed-off-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Note that SOF support will require a fix for the back-end definition 
below but that should be done on all Broadwell drivers when the on-going 
GitHub thread [1] reaches a conclusion

[1] https://github.com/thesofproject/linux/pull/1484

> +	/* Back End DAI links */
> +	{
> +		/* SSP0 - Codec */
> +		.name = "Codec",
> +		.id = 0,
> +		.no_pcm = 1,
> +		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		.ignore_suspend = 1,
> +		.ignore_pmdown_time = 1,
> +		.be_hw_params_fixup = broadwell_ssp0_fixup,
> +		.ops = &bdw_rt5650_ops,
> +		.dpcm_playback = 1,
> +		.dpcm_capture = 1,
> +		.init = bdw_rt5650_init,
> +		SND_SOC_DAILINK_REG(dummy, be, dummy),
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
