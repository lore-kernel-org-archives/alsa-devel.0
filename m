Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E8C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2706205CB
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fhZpTimd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2706205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F9E816BF;
	Mon, 17 Aug 2020 17:14:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F9E816BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597677339;
	bh=RCBinT/kubf/g/Wzy9UmKUPUOShGuelwUKDZbKEIzQQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fhZpTimdYqwqPCUtIMCBd+jUXB3mJcQXtMiPbthquae2VRyRwd1pNHMFEdc8skwzK
	 53PUZAULPMmm+/XSpnFsuuY96xNfQKY8qHEh8TfxmaisvltklMnkZGAeUwlbtWSuQl
	 eW52a/EvvgUbxQvJX9Ife9+9JKdwGL6HaMUGeWP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AD92F80216;
	Mon, 17 Aug 2020 17:14:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79F75F80218; Mon, 17 Aug 2020 17:14:46 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42DA9F800D3
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 17:14:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42DA9F800D3
IronPort-SDR: +bZtyd1FAxlG28O0EzRlcZdyLujwmdN7gXYjv3K9lLduOjdqYTMRq4FJdwEEVTMcZ7lzueF7Ji
 fRhy8VbCA5Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="152366653"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="152366653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 08:14:33 -0700
IronPort-SDR: M4lPcSqU1VGRY+xlpUR0D5GOIZi7NVdcxGRGA+jje3kW1lS9sGTjNmwWqdLPOO0NgbHR43uGp4
 IxaBfgbmEaOQ==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="310124183"
Received: from jhor-mobl.gar.corp.intel.com (HELO [10.209.166.196])
 ([10.209.166.196])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 08:14:31 -0700
Subject: Re: [PATCH v2] soundwire: SDCA: add helper macro to access controls
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
 <20200817121411.GR2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
Date: Mon, 17 Aug 2020 10:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817121411.GR2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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


>> The upcoming SDCA (SoundWire Device Class Audio) specification defines
>> a hiearchical encoding to interface with Class-defined capabilities,
> 
> typo hiearchical

ok

>> based on which audio function, entity, control and channel being used.
> 
> Can you please elaborate on what do these terms refer to?
> 
> Also can we have some documentation for this and how Linux is going to
> use it..

These are concepts in the SDCA draft spec, and that should be the 
reference. We worked with MIPI so that this spec will be available with 
a click-through agreement when ratified, for now it's only available to 
contributors per MIPI bylaws.

If you do not have access to this specification, then that's a real 
problem. Maybe you need to let Bard take care of this part as a 
co-maintainer?

The goal with this macro is to enable a first set of codecs drivers 
using these concepts to be released upstream. All you need to know at 
this point is that controls are defined in a hierarchical way and 
accessed with a read/write transaction from/to the address created with 
the following macro.

>> +/* v1.2 device - SDCA address mapping */
>> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
>> +						 (((fun) & 0x7) << 22) |	\
>> +						 (((ent) & 0x40) << 15) |	\
>> +						 (((ent) & 0x3f) << 7) |	\
>> +						 (((ctl) & 0x30) << 15) |	\
>> +						 (((ctl) & 0x0f) << 3) |	\
>> +						 (((ch) & 0x38) << 12) |	\
>> +						 ((ch) & 0x07))
>> +
> 
> how about adding an underscore to the arguments here:
> 
> #define SDW_SDCA_CTL(_fun, _ent, _ctl, _ch)
> and so on..

I checked the SoundWire defines and the vast majority of the macros 
don't use underscores, and when they do there's no consistency between 1 
or 2 underscores.

