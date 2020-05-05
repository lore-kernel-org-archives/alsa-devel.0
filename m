Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6BDC47254
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 15:58:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5833B2073B
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 15:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N1iM3gSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5833B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87B3F173C;
	Tue,  5 May 2020 17:57:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87B3F173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588694321;
	bh=sAjlnlyVHMPiWzQxcu/amnGDyttOJuDSGhLeDCfAYSk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N1iM3gSEWOtBJjvQCS9Q3JUcXbu33/RCY0Xd/MRorgJTs4czIY5XihSSx5pvRNa5c
	 dFv8b5/9vppwM4WIpnuKATkPZtCFoPEXM76hRu5//cNkkKII8nvJASxTD0zkwesWB5
	 KeMmMq+8zxPqZVppGVbLUyHoAkf0TXjUBsIJHcXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD801F8015B;
	Tue,  5 May 2020 17:57:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9ECD2F8015F; Tue,  5 May 2020 17:57:48 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2E42F800DE
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2020 17:57:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2E42F800DE
IronPort-SDR: ANlUiQs/AYlWt5T2QyumfxhINNKs3OyGtC0JUtAhW3HVYn/rVeE06d1e2lQopjrnhltSBSPTAp
 9LXqsel0B2NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 08:57:40 -0700
IronPort-SDR: alrkhE+2C4qXPTodsAh59qKNIdgUTi4My5rtciJamlWkLe/Gs6yVOlSzDYbd6Bd6u+HzoFRuZW
 MicWtTkTw92Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; d="scan'208";a="249494130"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.151.151])
 ([10.249.151.151])
 by fmsmga007.fm.intel.com with ESMTP; 05 May 2020 08:57:33 -0700
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To: =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>
References: <20200501193141.30293-1-rad@semihalf.com>
 <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
 <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <efca85c3-7078-efaa-88b5-536c8debea3d@intel.com>
Date: Tue, 5 May 2020 17:57:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
 Todd Broch <tbroch@google.com>, Marcin Wojtas <mw@semihalf.com>,
 Harshapriya <harshapriya.n@intel.com>, John Hsu <KCHSU0@nuvoton.com>,
 Alex Levin <levinale@google.com>, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, "Sienkiewicz,
 Michal" <michal.sienkiewicz@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Vamshi Krishna <vamshi.krishna.gopal@intel.com>, linux-kernel@vger.kernel.org,
 Yong Zhi <yong.zhi@intel.com>
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

>>>
>>> 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
>>>      hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
>>>      patch reduces pop by letting nau8825 keep using its internal VCO clock
>>>      during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
>>>      MCLK/FS is available. Once device resumes, the system will only enable
>>>      power sequence for playback without doing hardware parameter, audio
>>>      format, and PLL configure. In the mean time, the jack detecion sequence
>>>      has changed PLL parameters and switched to internal clock. Thus, the
>>>      playback signal distorted without correct PLL parameters.  That is why
>>>      we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.
>>
>> IIRC the FS can be controlled with the clk_ api with the Skylake driver,
>> as done for some KBL platforms. Or is this not supported by the firmware
>> used by this machine?
> 
> According to Ben, SKL had limitations in FW for managing the clk's
> back in the days.
> Can you point to the other driver you mention so we can cross check?
> 

Skylake driver is found within:
	/sound/soc/intel/skylake
directory.

"SKL had limitations in FW" - that's misleading. This is neither FW 
issue nor HW 'limitation'. SKL is an older platform and its goals and 
design was different than say APL+. Basically, your needs do not align 
with what's present on SKL hw.

Czarek
