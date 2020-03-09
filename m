Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540CC10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF38215A4
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pp3CsYLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF38215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9887A1687;
	Mon,  9 Mar 2020 18:21:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9887A1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583774559;
	bh=ghHJmuvrR4Xo8Xa0Poql8hvYdFrp217x4XUiSJiwMx8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pp3CsYLMLx5Y9KvbtEkcJNPeR2ww+sp6wSjg1tpYCIci5D0Djsf7fqdlPlT1MLljA
	 gRn6ugbMPgBmkYf8hyuJzHE70JBT2slbzqj4EFXQHkGRWSAwOWFL9Vdp3LHLnOsCBr
	 3aFg6tCiF/YP/WKscPNat1JdPwaQQ5yTIp6qtqGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7761F8021D;
	Mon,  9 Mar 2020 18:21:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBD88F801A3; Mon,  9 Mar 2020 18:21:46 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB5A9F800DA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 18:21:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB5A9F800DA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 10:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="231003451"
Received: from jdbostic-mobl1.amr.corp.intel.com (HELO [10.251.152.35])
 ([10.251.152.35])
 by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 10:21:40 -0700
Subject: Re: [PATCH 1/7] ASoC: Intel: Skylake: Remove superfluous chip
 initialization
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-2-cezary.rojewski@intel.com>
 <ec7c8c11-80aa-d252-26e8-bf5d1ff95fb7@linux.intel.com>
 <8dc83af4-c4af-1bdd-5d59-f13598037f96@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cd43e35c-bd32-37d0-7379-1113912d0fd5@linux.intel.com>
Date: Mon, 9 Mar 2020 11:48:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8dc83af4-c4af-1bdd-5d59-f13598037f96@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 3/9/20 8:57 AM, Cezary Rojewski wrote:
> On 2020-03-06 21:52, Pierre-Louis Bossart wrote:
>> On 3/5/20 8:53 AM, Cezary Rojewski wrote:
>>> Skylake driver does the controller init operation twice:
>>> - first during probe (only to stop it just before scheduling probe_work)
>>> - and during said probe_work where the actual correct sequence is
>>> executed
>>>
>>> To properly complete boot sequence when iDisp codec is present, bus
>>> initialization has to be called only after _i915_init() finishes.
>>> With additional _reset_list preceding _i915_init(), iDisp codec never
>>> gets the chance to enumerate on the link. Remove the superfluous
>>> initialization to address the issue.
>>
>> Have you tested with with DRM built-in and as a module? that was 
>> enough to trigger race conditions in the past on Dell XPS9350.
>>
> 
> DRM is quite a tree, you got to be more specific. Tested with i915=m and 
> DRM=m. I hope we mean the same thing when mentioning 'race'. There is an 
> obvious initialization race between hda bus drv and i915 which requires 
> one to follow a tight operation order in order to not lose i915 codec on 
> hda link and thus be able to enumerate it properly.

I meant CONFIG_DRM=m, yes, thanks for the clarification.

With the DRM as module, it took more time to establish the 
communication. That's probably changed if we do all the inits in a 
workqueue now.

> 
> On top of that, as you mentioned (by the link) this series addresses 
> missing DMIC configuration in conjunction with HDA +/- iDisp AND shields 
> against no-NHLT configuration. On Dell XPS 9350 lack on of NHLT was the 
> biggest problem - that's why I'd like that issue not to be forgotten about.

yes, but we don't want the driver to be auto-selected on SKL w/o DMICs, 
since it'd break existing devices who don't have a topology file installed.
