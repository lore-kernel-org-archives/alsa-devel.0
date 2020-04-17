Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0CC2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C19820857
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FO7fd5+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C19820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E0541672;
	Fri, 17 Apr 2020 17:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E0541672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587138612;
	bh=ZkUqKOLdWSU5KtJY2CX3GQeH7HX+zO3ThyjF84Hqltg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FO7fd5+HrgosKvdHPXIEalplRJ4sEuGqp9Y+XzFx2hrpozfhE0AHvoNtM2utPPKbr
	 bcXW5S9AJ/SuLVkiv9SZw1KmxcHUWUd7scbRRYm6RrQON66K7HwSN8V896b6fncfaK
	 0Oe1knmRlyPa+E9yAOY6By5ZolgHpVaynAsx8kyQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4129AF8012E;
	Fri, 17 Apr 2020 17:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 716D0F8028F; Fri, 17 Apr 2020 17:48:33 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8EEAF8012E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 17:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8EEAF8012E
IronPort-SDR: hngQofWnKgbDi6801B34WEtgAqERPNACRvTbDbRTVP0BQEbeyOlHhq9hEr6IY0sWS/ybZgxoKZ
 McxhfNHvjatw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 08:48:25 -0700
IronPort-SDR: T0+ME0f6DRaD4prFFV2qOkrVRiMqkfv8fMtQhp6AmwSlhLcYQi4BASsGb0uLXrJu3sxCuV3hpS
 RMiw+WQeqtMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; d="scan'208";a="278417854"
Received: from dsbrown-mobl.amr.corp.intel.com (HELO [10.251.128.242])
 ([10.251.128.242])
 by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2020 08:48:24 -0700
Subject: Re: next/master bisection: baseline.dmesg.alert on meson-sm1-sei610
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Stephan Gerhold <stephan@gerhold.net>
References: <5e997ca0.1c69fb81.f69a1.620e@mx.google.com>
 <20200417122732.GC5315@sirena.org.uk>
 <1j7dyeb6pt.fsf@starbuckisacylon.baylibre.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <931552e3-f0f7-b577-9b5d-5c7eb678fee6@linux.intel.com>
Date: Fri, 17 Apr 2020 08:52:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1j7dyeb6pt.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 tomeu.vizoso@collabora.com, khilman@baylibre.com, mgalka@collabora.com,
 guillaume.tucker@collabora.com, enric.balletbo@collabora.com
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


>>> Summary:
>>>    Start:      a3ca59b9af21e Add linux-next specific files for 20200416
>>>    Plain log:  https://storage.kernelci.org//next/master/next-20200416/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-meson-sm1-sei610.txt
>>>    HTML log:   https://storage.kernelci.org//next/master/next-20200416/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-meson-sm1-sei610.html
>>>    Result:     9b5db059366ae ASoC: soc-pcm: dpcm: Only allow playback/capture if supported
>>
>> This change to check the playback and capture constraints is also
>> causing issues on at least Meson - I'm a bit worried that this is also
>> causing oopses here, not just audio problems so copying in Morimoto-san
>> too.  We should fix the things that are broken by this change since it's
>> a thing we should be able to rely on and do enforce for non-DPCm links
>> but I'm wondering if we should revert for 5.7 and reapply for 5.8.
>>
>> Including complete report so people have it.
>>
> 
> I have the device with me. I'll check an report back

The fix for Intel Baytrail/Broadwell platforms was to add a 
.min_channels field for all DAIs:

https://github.com/thesofproject/linux/pull/2018/commits/4fa10638dca8aad7a320e85cc3e00b179b8de410

I think this new check is a good one, but by setting the bar higher it 
will break any platform which didn't initialize these fields, so we are 
likely to see such reports trickle one after the other.
