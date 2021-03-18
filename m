Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC28C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:30:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8714164F4D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 12:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8714164F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13FCA1666;
	Thu, 18 Mar 2021 13:29:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13FCA1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616070606;
	bh=NQfLo/Q4k0Vg1tIqdQBezC3bjP/I+vORhyvcLOAVD90=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mInlT/J58UVtxhRPIEZP6ltIHHWkzEOvrEWRtYBrt3NkMDGmDSwyfUJduzc0ZAepY
	 NHrSQiqe7l3FTgjxb8PSKeeBN5gnaIeeRbVA6KsXloZqtZSnN/RdrjndK/zIWuCa9G
	 OBlrY00ajrhshyRbi1Gfa3WBjLadPVAKWiDcz2As=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E0EAF80124;
	Thu, 18 Mar 2021 13:29:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57E0FF80171; Thu, 18 Mar 2021 13:29:04 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C5B1F800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 13:28:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C5B1F800C8
IronPort-SDR: enX587ZGKJLq018vyXceXc4MAMjgQ/VOzC/563grVVG0m1cMzH7bHM8fe50oozefIxhPYIiTY8
 TOp9Jr0WiDNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="186311911"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="186311911"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 05:28:50 -0700
IronPort-SDR: JsvFnuHaxxVG8o7XfFxBcOLaZTyrONyCDU0I8r9X39KY7L0RnNTyUvGGlGa7Q0dKGlT3IjY06V
 o5Tyzp6M3XZA==
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="406343619"
Received: from hapte-mobl.amr.corp.intel.com (HELO [10.212.219.204])
 ([10.212.219.204])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 05:28:47 -0700
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
To: Jack Yu <jack.yu@realtek.com>, Brent Lu <brent.lu@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 =?UTF-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>
References: <20210317110824.20814-1-brent.lu@intel.com>
 <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
 <7f91482a93aa4d429ee574d730eeca6a@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73f439e8-8553-30bd-f72c-e7d86fe59447@linux.intel.com>
Date: Thu, 18 Mar 2021 05:57:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7f91482a93aa4d429ee574d730eeca6a@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Dharageswari R <dharageswari.r@intel.com>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Fred Oh <fred.oh@linux.intel.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Libin Yang <libin.yang@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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



On 3/17/21 8:21 PM, Jack Yu wrote:
>>> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
>>> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
>>> platform.
>>>
>>> This driver also supports ALC1015Q-CG if running in auto-mode.
>>> Following table shows the audio interface support of the two
>>> amplifiers.
>>>
>>>             | ALC1015Q-CG | ALC1015Q-VB
>>> =====================================
>>> I2C       | Yes         | No
>>> Auto-mode | 48K, 64fs   | 16k, 32fs
>>>                           | 48k, 32fs
>>>                           | 48k, 64fs
>>>
>>> Signed-off-by: Brent Lu <brent.lu@intel.com>
>>
>> The code is looks fine, but Jack Yu added a separate patch that makes
>> RTL1019 equivalent to RTL1015, so should this patch also handle the
>> RTL1019 case?
>>
> For rt1019 non-i2c mode (auto mode), it uses the sdb pin to enable amp, the same as rt1015 non-i2c mode,
> therefore we propose rt1019(auto mode) to use rt1015p instead of adding a new driver for it.

ok, that's fine.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
