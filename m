Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BDC5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:45:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD36D206A3
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M3JpHJDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD36D206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21FDE166A;
	Fri,  8 Nov 2019 18:45:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21FDE166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573235150;
	bh=2gRHoSbnyHeM1LYejiijJH7pgGIYwa0Te7XFdZY2eG8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3JpHJDH3Ren6HFwY+0Va1AsJuqFbrB6EdD35FaYQBIpF5rbkssXVP6NeWnQsLckG
	 2WTK/xuK9JiQdG2vHBXvoct6NGt9Yh3/szG7qqaiYldnnX6EiI73b3xaTIw/znGqBS
	 UMoZ12dV+57obPt0/OKeWVtheYw3bVf1c7cV4r9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A452AF80111;
	Fri,  8 Nov 2019 18:44:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7C10F80321; Fri,  8 Nov 2019 18:44:58 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69EEEF800F3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 18:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69EEEF800F3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Nov 2019 09:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,282,1569308400"; d="scan'208";a="201415307"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.9.134])
 ([10.252.9.134])
 by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2019 09:44:46 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20191101173045.27099-1-pierre-louis.bossart@linux.intel.com>
 <20191101173045.27099-4-pierre-louis.bossart@linux.intel.com>
 <123e11ae-d22c-a54e-283f-a3b4e002c0c7@intel.com>
 <5930ecb1-5651-abd7-d031-a010f788100e@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a03b1823-c390-3480-c45b-793ee3dab453@intel.com>
Date: Fri, 8 Nov 2019 18:44:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5930ecb1-5651-abd7-d031-a010f788100e@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH 03/11] ASoC: Intel: add mutual exclusion
 between SOF and legacy Baytrail driver
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

On 2019-11-04 22:52, Pierre-Louis Bossart wrote:
> 
> 
> On 11/4/19 2:18 PM, Cezary Rojewski wrote:
>> On 2019-11-01 18:30, Pierre-Louis Bossart wrote:
>>> This legacy driver is already deprecated, let's make sure there is no
>>> conflict with SOF.
>>>
>>> Signed-off-by: Pierre-Louis Bossart 
>>> <pierre-louis.bossart@linux.intel.com>
>>
>> Pierre, with SOF replacing /atom and /baytrail for BYT platforms, is 
>> /baytrail (legacy) used on any of the setups officially? While @ IGK 
>> I'm playing with anything from HSW up to TGL and above, /baytrail gets 
>> skipped entirely, even here.
> 
> The legacy Baytrail driver is still used by Baytrail Chromebooks, and 
> that choice is not something we control. If Google transition to SOF for 
> Baytrail, then we can remove this driver altogether.
> The Atom Baytrail driver is enabled by default (default ACPI). Only when 
> we have support for Baytrail-CR can we deprecate Baytrail/Atom.
> Does this answer to your question?
> -Pierre

Thanks for explanation, Pierre. Indeed it does.
I hoped Baytrails are getting updated together with Cherrytrails, oh well.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
