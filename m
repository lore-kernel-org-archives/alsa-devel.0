Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90858C4727E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:21:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4715020848
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sTmKc2c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4715020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDE2E1913;
	Thu,  1 Oct 2020 18:20:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDE2E1913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601569301;
	bh=icGAbLnhtUGG4FZHt4vn473IU2Lqxbrh4SJ9A1pKxHI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTmKc2c+S6gHJifYDik9BEh3Eoc+txVtD78Sa04dEU6YwYON5NnUgGWlv+3xavQTQ
	 IIW6NhWzFTsThLzQgcZmEWiuPNUEQ9EqI9c/+zCn/PuJDy60OYStvXAM9hzmDU8Kaz
	 BYbJA3twjMEbQtq+sJV7FnpraEk7bnh3qvlE70uk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54DC8F801DB;
	Thu,  1 Oct 2020 18:20:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB8EAF801F5; Thu,  1 Oct 2020 18:20:50 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D105F801D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 18:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D105F801D8
IronPort-SDR: QOqjNe9mBnRLnBUbxwe3cQL1e3UUCNjUuj5VkYz/h3C4uOUVAWHsGfMC6do8IM/OE2SC8oLH6T
 4DN3C1enuUsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163626087"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="163626087"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 09:20:40 -0700
IronPort-SDR: C2dn6wV9epBDg1xpFQ0gkbQf+Am12SWE1MugG+wEhkyPikpWSCebMIh76RKfhu+ZdCrlIPechY
 EO3Wpy91WP+g==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; d="scan'208";a="416120368"
Received: from myounan-mobl1.amr.corp.intel.com (HELO [10.251.131.17])
 ([10.251.131.17])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 09:20:40 -0700
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
To: Mark Brown <broonie@kernel.org>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001125038.GC6715@sirena.org.uk>
 <ddb019b8-4370-eca8-911f-38adf0531076@linux.intel.com>
 <20201001152450.GK6715@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ba29c19-205b-6d0a-3a28-f9d5cc32adfe@linux.intel.com>
Date: Thu, 1 Oct 2020 11:20:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001152450.GK6715@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@intel.com, parav@nvidia.com, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>
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



On 10/1/20 10:24 AM, Mark Brown wrote:
> On Thu, Oct 01, 2020 at 09:07:19AM -0500, Pierre-Louis Bossart wrote:
> 
>>>> are controlled by DT/ACPI. The same argument applies for not using MFD
>>>> in this scenario as it relies on individual function devices being
>>>> physical devices that are DT enumerated.
> 
>>> MFD has no reliance on devices being DT enumerated, it works on systems
>>> that don't have DT and in many cases it's not clear that the split you'd
> 
> ...
> 
>> To the best of my knowledge, the part of 'individual function devices being
>> physical devices' is correct though. MFDs typically expose different
>> functions on a single physical bus, and the functions are separated out by
>> register maps. In the case where there's no physical bus/device and no
>> register map it's unclear how MFDs would help?
> 
> MFD doesn't care.  All MFD is doing is instantiating platform devices
> and providing mechanisms to pass resources through from the parent
> device to the child devices.  It doesn't really matter to it which if
> any combination of resources are being provided to the children or what
> the devices represent.

I have nothing against MFD, but if this boils down to platform devices 
we are back to the initial open "are platform devices suitable as 
children of PCI devices"? I've heard Greg say no for the last year and a 
half - and he just re-stated this earlier in this thread.
