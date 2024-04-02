Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE92CD1288
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Apr 2024 12:52:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B9922CF9;
	Wed,  3 Apr 2024 14:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B9922CF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712148727;
	bh=Yd/6Gbpag1vTI2OOLqRqO6ZI0sVmA5/QE1SmwNXPKsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VHZ0CIJDcq7/w9IKTcOmu7ZsFE920MZNTIjanUAh5Wyx4UrZtV06e5CedYymlSCeT
	 oeDZtPaO4jUP9My3Z4tlfeZ/CqsUHiln3Ik577daBGnSE2KTQsU4VoWwn20IHpWZcx
	 pxlnyApaFvcDAXFapfpHdBKlLox21JQuYHU/cdg8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5552BF80622; Wed,  3 Apr 2024 14:50:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E306F80622;
	Wed,  3 Apr 2024 14:50:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25FECF805B1; Wed,  3 Apr 2024 14:50:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 22C62F80236
	for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2024 14:50:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22C62F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eQMTcRvp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712148632; x=1743684632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yd/6Gbpag1vTI2OOLqRqO6ZI0sVmA5/QE1SmwNXPKsI=;
  b=eQMTcRvpNBjMqt2CVpGc5su+zcGvx99RUA7PwZljqY/uekjQHw0WeTV7
   4/Lg6Qi0Hj3sBNyCSt1MIrpuZjDZoNpuRQbPTHjUorjynzNO8zyVIlU6V
   dRNnV1HZTUepDpIohxrHWmQ/ihQP1V0rEeryuRLnMXzcZf1rRcPIpfKym
   jsmt1EbqU1L3JOwU2iT3DNXEfgaFJTiqVNIFSqzoEJpSgV+Mihl+aT169
   umIS1eYWqWztfF+o7jvALD//bEGXygkWHkauXZfhuZip3zybO3d0GwUYh
   jBCll42h5r3X+OeG08uEQsqWqHxnxD77wUNhJOEohisoJKw9foxG4Tw4i
   A==;
X-CSE-ConnectionGUID: 2os2YyklSRSguPG8BfDIKA==
X-CSE-MsgGUID: 3Hp9pGoQRHmgQ1so+Eq16g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7539359"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000";
   d="scan'208";a="7539359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 05:50:31 -0700
X-CSE-ConnectionGUID: A39AzG6RQqGoBfvyRqzbOA==
X-CSE-MsgGUID: tuUeZuvUTk29WVSEVJrlRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000";
   d="scan'208";a="18343252"
Received: from makulkar-mobl1.amr.corp.intel.com (HELO [10.212.52.18])
 ([10.212.52.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 05:50:28 -0700
Message-ID: <4c40b4bc-f2bd-45b7-8b14-456ddf1be94b@linux.intel.com>
Date: Tue, 2 Apr 2024 09:13:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] ASoC: remove snd_soc_dai_link_set_capabilities()
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Brent Lu <brent.lu@intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 Maso Huang <maso.huang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Takashi Iwai <tiwai@suse.com>,
 Trevor Wu <trevor.wu@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 imx@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <87zfuesz8y.wl-kuninori.morimoto.gx@renesas.com>
 <87h6gludmj.wl-kuninori.morimoto.gx@renesas.com>
 <54ace545-8cdc-49aa-8214-5f07bee0e2f6@linux.intel.com>
 <87y19w7gjq.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <87y19w7gjq.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: WMTAO327KF6U4J34523HO3KJFYRLJJVM
X-Message-ID-Hash: WMTAO327KF6U4J34523HO3KJFYRLJJVM
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WMTAO327KF6U4J34523HO3KJFYRLJJVM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 4/1/24 19:29, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>> snd_soc_dai_link_set_capabilities() checks all CPU/Codec DAI (Y)(Z)
>>> for Playback/Capture (X) and checks its validation (A), and setup
>>> dpcm_playback/capture flags (a).
>>>
>>> 	void snd_soc_dai_link_set_capabilities(...)
>>> 	{
>>> 		...
>>> (X)		for_each_pcm_streams(direction) {
>>> 			...
>>> (Y)			for_each_link_cpus(dai_link, i, cpu) {
>>> 				...
>>> (A)				if (... snd_soc_dai_stream_valid(...)) {
>>> 					...
>>> 				}
>>> 			}
>>> (Z)			for_each_link_codecs(dai_link, i, codec) {
>>> 				...
>>> (A)				if (... snd_soc_dai_stream_valid(...)) {
>>> 					...
>>> 				}
>>> 			}
>>> 			...
>>> 		}
>>>
>>> (a)		dai_link->dpcm_playback = supported[...];
>>> (a)		dai_link->dpcm_capture  = supported[...];
>>> 	}
>>>
>>> This validation check will be automatically done on new
>>> soc_get_playback_capture(). snd_soc_dai_link_set_capabilities() is no
>>> longer needed. Let's remove it.
>>
>> Humm, this is really hard to review.
>>
>> soc_get_playback_capture() used to do a verification of the match
>> between dailink and dais, and now it doesn't have it any longer and this
>> patch removes the checks?
> 
> Hmm..., Maybe I'm misunderstanding ?
> I think this patch is very clear to remove, because it is 100% duplicate
> code. Maybe this mutual misunderstanding is based [01/15] review ?
> I think we need to dig it first.

I agree this looks like duplicate code, but why can't we remove it first
*before* any code modification?

It's very hard to review because it comes as the 13th patch of a series
and you've already removed similar code earlier which precisely checked
the consistency between dailink and dais.

In this function, it's a similar case btw where the settings provided by
the machine drivers are overridden by the framework, so that's another
case of collision between machine driver and framework. Which of the two
should be trusted?

