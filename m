Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F05C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:04:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A057620828
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OjqW6JtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A057620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 091A1851;
	Mon,  9 Mar 2020 14:04:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 091A1851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583759092;
	bh=wSwTF3Ppd2GE2nZvIElwwkjvr8ryBFjF/f+kal5Dw0s=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjqW6JtBZiE/ytokiWgtSGgESI+XtgM0Sa5+qswETuchRC+Y+SEVr/cqRxp8HtsL/
	 6Enc1wAw8tp/BTNEfYjnMkPcKjvC/2bNooZX9cJax12UqW+4leuDco8iUFQFhW2BzN
	 w6kHxGfilgyhFym+D3ZaqZQbYr7WmcyvpJJFzUhU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D48FF80123;
	Mon,  9 Mar 2020 14:04:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2717F801EB; Mon,  9 Mar 2020 14:03:59 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8F3DF80123
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 14:03:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8F3DF80123
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 06:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; d="scan'208";a="234007862"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 06:03:51 -0700
Subject: Re: [PATCH 4/7] ASoC: Intel: Skylake: Shield against no-NHLT
 configurations
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-5-cezary.rojewski@intel.com>
 <7f74b049-4659-9656-4396-3c1b42d2e32c@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <2a380994-a723-ea25-7feb-6a650a3889e3@intel.com>
Date: Mon, 9 Mar 2020 14:03:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7f74b049-4659-9656-4396-3c1b42d2e32c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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

On 2020-03-06 22:03, Pierre-Louis Bossart wrote:
> 
> 
>> -    intel_nhlt_free(skl->nhlt);
>> +    if (skl->nhlt)
>> +        intel_nhlt_free(skl->nhlt);
> 
> we could alternatively move the test in intel_nhlt_free, which seems 
> like a more robust thing to do?

Depends. In general kernel-internal API trusts its caller and appending 
'ifs' everywhere would unnecessarily slow entire kernel down. While 
intel_nhlt_free is called rarely, I'd still argue caller should be sane 
about its invocation.

'if' in skl_probe could be avoided had the function's structure been 
better. 'if' in skl_remove is just fine, though.

Let's leave it as is.

Czarek
