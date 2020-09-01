Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E483C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AA320E65
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cA1Vcgrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AA320E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B61F17D5;
	Tue,  1 Sep 2020 17:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B61F17D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598974695;
	bh=kpR3soOpQVHwZACZV/GtiBJ21aCs55EZ9DeSPzwLzxs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cA1Vcgrq2ElKggOAGNWOE3gxcSKJguj0otSIU9MKh64Y4+I8GIKQZJd/6aQl2vj34
	 o4rZc6GVcRPA1fPaSnuZyusQ7gjSn5qyWHDV0cKNBG/raHtDXPFqaA6F7Mn8a+Oins
	 +HoI41D8XIv22WqXHT05MpX7Ba3azJdXOkskZsyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C044AF8020D;
	Tue,  1 Sep 2020 17:37:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98A5FF80217; Tue,  1 Sep 2020 17:37:22 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24AA4F801EB
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 17:37:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24AA4F801EB
IronPort-SDR: TqPpX7t1N09/Ds4IafB4ynNu1aS6Qc3n+zwab8UGcYf6HVFBspGtwiLXhlKyPwiIx7AhhpReeD
 LT/DBiYR+E1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175240222"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="175240222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 08:37:09 -0700
IronPort-SDR: QFmWOthbCgCPCOuPF6J/D0KQaB/9de8Q/oNAjW3c6L+Q3IFGJN8bvrp1UEO8KdQx1ABNOklzUK
 x0S3JfEgLiEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; d="scan'208";a="297348824"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.145.54])
 ([10.249.145.54])
 by orsmga003.jf.intel.com with ESMTP; 01 Sep 2020 08:37:07 -0700
Subject: Re: [bug report] 'ASoC: Intel: haswell: Power transition refactor'
 and PulseAudio
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <9bc5b3ac-87a0-4d7c-abfd-2407db90d310@www.fastmail.com>
 <28ee99bc-fe27-9111-893b-1cb000067a7c@intel.com>
 <026aa0fd558b8b91a67a868a25eb84d8749101b7.camel@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c93c0522-d8b7-e4c4-b11b-80646cfd0432@intel.com>
Date: Tue, 1 Sep 2020 17:37:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <026aa0fd558b8b91a67a868a25eb84d8749101b7.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Christian Bundy <christianbundy@fraction.io>,
 yang.jie@linux.intel.com, zwisler@google.com,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org
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

On 2020-09-01 5:23 PM, Liam Girdwood wrote:
> On Tue, 2020-09-01 at 13:33 +0200, Cezary Rojewski wrote:

...

>>
>> Hello Christian,
>>
>> Thank you for report! Issue is a known one to us and has already
>> been
>> addressed by:
>>
>> 	[PATCH v4 00/13] ASoC: Intel: Catpt - Lynx and Wildcat point
>> 	https://www.spinics.net/lists/alsa-devel/msg113762.html
>>
>> waiting for final dependency to be merged (Andy's resource-API
>> changes,
>> as Mark already added the SPI ones) so v5 with review changes can be
>> provided. Shouldn't be long before this gets merged. As consequence,
>> /haswell/ ceases to exist.
>>
> 
> Please also don't forget that the new BDW HW register programming flows
> need to be shared as common code with the SOF BDW driver.
> 
> Thanks
> 
> Liam
> 

I don't believe this is related to Christian's report.

Anyway, revert-patch for sound/soc/intel/haswell/ solution has been 
provided so it can be later propagated to v5.8 and v5.9 -stable with 
matching upstream commit's sha-id.

Czarek
