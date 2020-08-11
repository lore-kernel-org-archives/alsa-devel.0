Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856E7C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:31:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B19020781
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="msiFGN8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B19020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7951315F9;
	Tue, 11 Aug 2020 09:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7951315F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597131098;
	bh=gg4BK8MIbEobdX5yRb50MyBRHrKGJ6t41M8LmSlWdDk=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=msiFGN8jJnsvp+FPRSqC9gXXy89PoqxZ9Hhie/gvPWAgjh+91wSok5SgRtevqfZ30
	 2GYCJKCReyV126KJEdaJb9eHK3pBRdusycIFCQy1DvNw0IwoInrPCP3F3cmlvkxgui
	 iL8CdgEzJpduX3thbMjbWu0lHMFuCFg7WedoWYPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DC15F8014C;
	Tue, 11 Aug 2020 09:30:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B3CBF8015B; Tue, 11 Aug 2020 09:30:46 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73491F800D3
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 09:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73491F800D3
IronPort-SDR: 9e0buFu1vtb3S0x098pri/KXslhR+TfB6oxbix++8sZBpsglOYP5G7gbc3N125aiRwkOIOIqJ+
 96IsFiq7qwxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151359723"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; d="scan'208";a="151359723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 00:30:27 -0700
IronPort-SDR: ULYzAC9OOyivaB4WrLTMqpYT6YbtjqsveKrIHy//fZL+st7qVc/Y8s3OPEQEPbT/xYUko1p1pP
 JeH3/yRY/WFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; d="scan'208";a="317631427"
Received: from tpawlows-mobl.ger.corp.intel.com (HELO [10.213.31.191])
 ([10.213.31.191])
 by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 00:30:21 -0700
Subject: Re: [PATCH 07/13] ASoC: Intel: catpt: Event tracing
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: Mark Brown <broonie@kernel.org>
References: <20200807110649.17114-1-cezary.rojewski@intel.com>
 <20200807110649.17114-8-cezary.rojewski@intel.com>
 <20200807150908.GN5435@sirena.org.uk>
 <2e964389-9917-91a4-5f41-7031e54f83a5@intel.com>
Message-ID: <b7b1d286-0920-2c49-b227-1c49840d20b8@intel.com>
Date: Tue, 11 Aug 2020 09:30:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2e964389-9917-91a4-5f41-7031e54f83a5@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 andriy.shevchenko@intel.com, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, marcin.barlik@intel.com, zwisler@google.com,
 lgirdwood@gmail.com, tiwai@suse.com, filip.proborszcz@intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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

On 2020-08-10 9:16 AM, Cezary Rojewski wrote:
> On 2020-08-07 5:09 PM, Mark Brown wrote:
>> On Fri, Aug 07, 2020 at 01:06:43PM +0200, Cezary Rojewski wrote:
>>> Define tracing macros for easy catpt debug. These are divided into
>>> memory, registry and ipc event categories.
>>>
>>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>>> ---
>>>   sound/soc/intel/catpt/trace.h | 169 ++++++++++++++++++++++++++++++++++
>>
>> Usually events go into include/trace/events/
>>
> 
> Thought TRACE_INCLUDE_FILE/ _PATH are designed specifically to remove 
> the need for trace.h to go into mentioned folder. Based my decision on 
> fact that sound/hda and sound/core have their traces defined locally.
> 
> What's the preferred way?
> 

In regard to preferences, one more question Mark, if I may:
	snd_soc_catpt vs snd_soc_intel_catpt

while developers usually prefer the shorter ones, I understand there 
might be some subsystem level preferences and currently chosen name 
could have easily slipped reviewers given the length of patchset.

Czarek
