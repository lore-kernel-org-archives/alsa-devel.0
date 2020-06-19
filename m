Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADACFC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:19:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4E820776
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Tn2xRqbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4E820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A28EF1615;
	Fri, 19 Jun 2020 03:18:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A28EF1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592529558;
	bh=R8hvhFGAf7U8zq8vweOpLnJWVfpaVd2r81hqv6S76/U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn2xRqbTPA0LRzrPmpgkLAbJRxuhpwtPkdUkUVQpTFHyMuJ32+v5HxtX6y69aGTE9
	 v2tLiSVA9uvfF00hST+mVWwdlQ3KsmuHub1QluW5z6EI6oZyLufJcxwwqvVpLq681j
	 KKU89Ld91dzEpzPYxWjQmW2V7xX6ye5Gw17SriX0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3435EF80116;
	Fri, 19 Jun 2020 03:18:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D480F80162; Fri, 19 Jun 2020 03:18:26 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B360F8010E
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 03:18:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B360F8010E
IronPort-SDR: rFnL0hG3zksKzXIWMv0x/a+1HzAlN7JEnaq/gRMiIWfOueWtXjJe5ZVm96p8Rqho8rGkceBIvO
 gpeqPVcmEDTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="227498309"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="227498309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 18:18:16 -0700
IronPort-SDR: ArDw095lF4zrNyC4Lm2qGoU0aP8mKvZQjaHPjf5u3vP6oBA3wHpRNiyiu5iEgnRjxpyKJ0q4t5
 +QLZNpbGYhGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="263102210"
Received: from lsedney-mobl2.amr.corp.intel.com (HELO [10.255.230.45])
 ([10.255.230.45])
 by orsmga007.jf.intel.com with ESMTP; 18 Jun 2020 18:18:14 -0700
Subject: Re: [PATCH] ASoC: Intel: haswell: Power transition refactor
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200330194520.13253-1-cezary.rojewski@intel.com>
 <293372ae-5270-a1d4-2577-04991c08e33f@intel.com>
 <ee6c0545-a325-8df4-9c26-d823582735af@linux.intel.com>
 <49a16c64-5951-f327-c12a-d3264353b74b@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <685b8be3-4ff8-5012-c900-8521c2772121@linux.intel.com>
Date: Thu, 18 Jun 2020 20:18:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <49a16c64-5951-f327-c12a-d3264353b74b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Ross Zwisler <zwisler@google.com>, lgirdwood@gmail.com,
 Dominik Brodowski <linux@dominikbrodowski.net>, tiwai@suse.com,
 vkoul@kernel.org, broonie@kernel.org
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


>>> Pierre, your thoughts on this? This has already been confirmed working.
>>
>> I don't have any specific knowledge on Broadwell to comment. I also 
>> haven't had time to test this patch, I was expecting Ross to provide 
>> his Tested-by tag?
> 
> Hello,
> 
> Ross has provided his Tested-by tag already. Patch has been tested by 
> Intel & Google side both. Given problem's impact, this fix is considered 
> a critical one. I think we are good-to-go for quite a while now?
> 
> Czarek

I just tested speaker playback on Dell XPS13 and Samus Chromebook to 
double-check my UCM2 changes for SOF were indeed backwards compatible 
with the SST driver case. Well, my changes are fine but the kernel not 
so much.

With a 5.8-rc1 kernel w/ the SST driver, sounds played through 
pulseaudio are rendered too slowly with clicky artefacts. Using the alsa 
hw device works fine. In some cases, the sound rendered by PulseAudio 
become clear again after a while. Restarting the UI and testing degrades 
the audio again.

Reverting this patch - identified with git bisect - solves the issue on 
both devices, pulseaudio works fine again without any transient 
behavior. I spent 15mn monkey-testing and the audio quality was always 
good when this patch is reverted.

I have no idea what the fixes were, but going from a somewhat random D3 
exit problem to a 100% reproducible issue is problematic. I trust both 
Cezary and Ross did test this patch, but could it be that pulseaudio 
tests were skipped?

8ec7d6043263ecf250b9b7c0dd8ade899487538a is the first bad commit
commit 8ec7d6043263ecf250b9b7c0dd8ade899487538a
Author: Cezary Rojewski <cezary.rojewski@intel.com>
Date:   Mon Mar 30 21:45:20 2020 +0200

     ASoC: Intel: haswell: Power transition refactor

