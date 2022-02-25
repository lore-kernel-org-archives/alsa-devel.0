Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB2C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 20:56:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A63341F97;
	Fri, 25 Feb 2022 21:55:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A63341F97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645822609;
	bh=3PzlM4i/PlatffevIAJ1wc69sAg6KVbt0uQtb0/BoaA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rK24ewUHy4Kwg1sfELyHGmjL9hyhSW9twQdO/rLureeyJhgJxM4GuQIzKWgAZLDUs
	 WnJhRhbLWlsQ7M6GtLi0mDlvBJYfsTfUzyBt5PHqKfJP41/ySOohCKusqvNx6rdZ8R
	 0H2b5n6Epi0FrkHl9lujZ8Hhf4aQRsCIawcZHmlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4A7FF8054A;
	Fri, 25 Feb 2022 21:53:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 030CCF80534; Fri, 25 Feb 2022 21:52:47 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D10DF80517
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 21:52:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D10DF80517
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="UWiFWMOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645822364; x=1677358364;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3PzlM4i/PlatffevIAJ1wc69sAg6KVbt0uQtb0/BoaA=;
 b=UWiFWMOWwEIqnJqMdrsgUm/h2K0x5xvUAf8SzWSxL/b0d/jBtC4te12t
 E3GLYdZJTpdgvLPF2vR4iRuPMu5rcC4VsMPh2gCjSvCNUFXsxvU1Ln9LD
 CFfO36L3W+q/0X/vkiTW3QClcubeTYlYo29pcvYGgMCvySaVhy5xYxNm1
 wCWsjNz95Yy0otU4bx+QYqMVLQUl/QrAihy7CuQ2o/3TXldulI5JhNnK3
 yYKVC3WqkOZIVmxrRsfELb1PxCu0ly24Sl1t+iMoGAvIEZDOr8J91e/C7
 F5mHuwjZlVqfrb9kq+AluwL3otf5YfkmeR7LjnntuyLpMULXNsiuJ7lqd Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="313296143"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="313296143"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; d="scan'208";a="777520593"
Received: from nnwogbe-mobl1.amr.corp.intel.com (HELO [10.212.101.231])
 ([10.212.101.231])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 12:52:41 -0800
Message-ID: <429b8685-1db0-1b5e-011f-9b5b355ddd85@linux.intel.com>
Date: Fri, 25 Feb 2022 14:23:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 03/17] ASoC: Intel: Introduce AVS driver
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <20220207122108.3780926-4-cezary.rojewski@intel.com>
 <bde92ad1-0eda-d70a-4435-4963aa617cb4@linux.intel.com>
 <f1b0144e-94bd-deff-67e3-97bb310b0860@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <f1b0144e-94bd-deff-67e3-97bb310b0860@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: upstream@semihalf.com, harshapriya.n@intel.com, rad@semihalf.com,
 tiwai@suse.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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


>>> +int avs_dsp_core_disable(struct avs_dev *adev, u32 core_mask)
>>> +{
>>> +    /* Be permissive to allow for full DSP shutdown in disable path. */
>>
>> that comment isn't very clear, what is permissive here?
> 
> 
> There is no error checking below.
> 
>>> +    avs_dsp_op(adev, stall, core_mask, true);
>>> +    avs_dsp_op(adev, reset, core_mask, true);
>>> +
>>> +    return avs_dsp_op(adev, power, core_mask, false);

consider adding a comment then, along the lines of 'we don't prevent
suspend or shutdown with error checks' or something. 'permissive' was
rather unclear to me.
