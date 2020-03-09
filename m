Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836FC10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:58:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34E20848
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iLIhLv4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B71E1661;
	Mon,  9 Mar 2020 14:57:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B71E1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583762315;
	bh=Ir7nV4N8C2Xqief96JvdbwZ6qERxOHC4sJgaLoUfoeg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iLIhLv4ADt10rhc9tbPU0dnSuroNVZaubAc2Ffu10IISbjo50sJcD0yRywQ/jNxVh
	 kayyMzBIGWbwvuEJoB4Yic1XckOfg9MQNoOKjG6bqsSffjm0vY3WcWfDr+DNyC9Ugv
	 RHbKt0zD/5S/8wS/opNthkstxESrq7kxojkXWQIc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF491F801A3;
	Mon,  9 Mar 2020 14:57:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9186FF801EB; Mon,  9 Mar 2020 14:57:42 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00E5CF80123
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 14:57:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00E5CF80123
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 06:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; d="scan'208";a="234019120"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 06:57:34 -0700
Subject: Re: [PATCH 1/7] ASoC: Intel: Skylake: Remove superfluous chip
 initialization
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-2-cezary.rojewski@intel.com>
 <ec7c8c11-80aa-d252-26e8-bf5d1ff95fb7@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <8dc83af4-c4af-1bdd-5d59-f13598037f96@intel.com>
Date: Mon, 9 Mar 2020 14:57:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ec7c8c11-80aa-d252-26e8-bf5d1ff95fb7@linux.intel.com>
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

On 2020-03-06 21:52, Pierre-Louis Bossart wrote:
> On 3/5/20 8:53 AM, Cezary Rojewski wrote:
>> Skylake driver does the controller init operation twice:
>> - first during probe (only to stop it just before scheduling probe_work)
>> - and during said probe_work where the actual correct sequence is
>> executed
>>
>> To properly complete boot sequence when iDisp codec is present, bus
>> initialization has to be called only after _i915_init() finishes.
>> With additional _reset_list preceding _i915_init(), iDisp codec never
>> gets the chance to enumerate on the link. Remove the superfluous
>> initialization to address the issue.
> 
> Have you tested with with DRM built-in and as a module? that was enough 
> to trigger race conditions in the past on Dell XPS9350.
> 

DRM is quite a tree, you got to be more specific. Tested with i915=m and 
DRM=m. I hope we mean the same thing when mentioning 'race'. There is an 
obvious initialization race between hda bus drv and i915 which requires 
one to follow a tight operation order in order to not lose i915 codec on 
hda link and thus be able to enumerate it properly.

On top of that, as you mentioned (by the link) this series addresses 
missing DMIC configuration in conjunction with HDA +/- iDisp AND shields 
against no-NHLT configuration. On Dell XPS 9350 lack on of NHLT was the 
biggest problem - that's why I'd like that issue not to be forgotten about.

Czarek
