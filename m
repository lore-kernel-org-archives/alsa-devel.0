Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80BAC10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:23:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FAF215A4
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m8hZVV99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FAF215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7301168F;
	Mon,  9 Mar 2020 18:22:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7301168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583774613;
	bh=1Gsi5u0fNug/Uqq1APjw/CbhNzIdMonY6RrSOPddVhY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m8hZVV99sCHuyNJYBaqhXxMuSE4/bkOFlFzqgfJvCi2ib8GheHANLYjGfSZl7wStV
	 Pk9M+Rg1VzqfdaBzNeb8IROSV2OwZYzggsz/zKpk/Iiv/cstDkHDg7l4LFEd83erNR
	 rLGERqIcLAu92RAO+GXIVaw6j0WyvoaMpO3d6yOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 222BCF80227;
	Mon,  9 Mar 2020 18:21:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14464F80260; Mon,  9 Mar 2020 18:21:49 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0FE9F801EB
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 18:21:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0FE9F801EB
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 10:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="231003475"
Received: from jdbostic-mobl1.amr.corp.intel.com (HELO [10.251.152.35])
 ([10.251.152.35])
 by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 10:21:42 -0700
Subject: Re: [PATCH 4/7] ASoC: Intel: Skylake: Shield against no-NHLT
 configurations
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-5-cezary.rojewski@intel.com>
 <7f74b049-4659-9656-4396-3c1b42d2e32c@linux.intel.com>
 <2a380994-a723-ea25-7feb-6a650a3889e3@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d38dbb00-734f-7de9-ce0c-2ee06cec11d6@linux.intel.com>
Date: Mon, 9 Mar 2020 12:01:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2a380994-a723-ea25-7feb-6a650a3889e3@intel.com>
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



On 3/9/20 8:03 AM, Cezary Rojewski wrote:
> On 2020-03-06 22:03, Pierre-Louis Bossart wrote:
>>
>>
>>> -    intel_nhlt_free(skl->nhlt);
>>> +    if (skl->nhlt)
>>> +        intel_nhlt_free(skl->nhlt);
>>
>> we could alternatively move the test in intel_nhlt_free, which seems 
>> like a more robust thing to do?
> 
> Depends. In general kernel-internal API trusts its caller and appending 
> 'ifs' everywhere would unnecessarily slow entire kernel down. While 
> intel_nhlt_free is called rarely, I'd still argue caller should be sane 
> about its invocation.
> 
> 'if' in skl_probe could be avoided had the function's structure been 
> better. 'if' in skl_remove is just fine, though.
> 
> Let's leave it as is.

it's also used in SOF:

sound/soc/sof/intel/hda.c:              intel_nhlt_free(nhlt);

that's why I suggested to factor the test so that both users don't need 
to add the if.
