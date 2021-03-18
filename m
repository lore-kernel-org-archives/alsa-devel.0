Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A8C4332D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:27:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEDC64F18
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEDC64F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E625F169D;
	Thu, 18 Mar 2021 16:26:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E625F169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616081232;
	bh=s8EXhFCVMQRFOV7h8LDIA2m2qU28nS6EQ+hNQl1kVQ0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqfFUkcCqZGhd2ZvVJB0xLZorpfzfbCLuxSrUY305CXOlzPydolm6tZZsN/iynrIC
	 rHrcaRY4LQaXPewVp3H6ag+tZ3YTl5Qb2pFW/ToSCzBrB2NF54CtxV/+U/g/c2NKKk
	 jP8Hg4k7FNN2ovNArOUjA3QH/rk7XONi0Z/oNbDc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80107F80165;
	Thu, 18 Mar 2021 16:26:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB7D1F80165; Thu, 18 Mar 2021 16:26:20 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86CA4F80218
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 16:26:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86CA4F80218
IronPort-SDR: QF8AGvGaiHI06wRfK8jQwmWjszf6ZwjUBKvm+dyL9qwSMdgiH9VmdLYYkgnLnGmZocVUcXuEe3
 gDVNscLXXDDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="187343201"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="187343201"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 08:26:09 -0700
IronPort-SDR: hAoQDzBt9odF8H7TrcnW4zc4J4H3GjMnf1f5iF0S75m4uAA4IvA0J8y2+W5/UWUy+tR44iefxT
 oF/rKRsktMRg==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="406403029"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.1.197])
 ([10.213.1.197])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 08:26:04 -0700
Subject: Re: [PATCH 0/3] Fix SND_HDA_PREALLOC issue
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
References: <20210318151122.2493096-1-amadeuszx.slawinski@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <ddc72cdd-2112-b7b1-1687-b7e699bafae5@intel.com>
Date: Thu, 18 Mar 2021 16:26:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210318151122.2493096-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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


On 2021-03-18 4:11 PM, Amadeusz Sławiński wrote:
> For context it started with user reporting failures when running arecord
> without any error or warning in dmesg (after fixing some configuration
> problems thet they had).
> https://bugzilla.kernel.org/show_bug.cgi?id=201251#c279
> 
> After spending time investigating the issue it was narrowed to quite big
> setting of CONFIG_SND_HDA_PREALLOC_SIZE (4096).
> When looking at code
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/pcm_memory.c?id=6417f03132a6952cd17ddd8eaddbac92b61b17e0#n30
> there is a limit of memory per card:
> max_alloc_per_card = 32UL * 1024UL * 1024UL
> 
> When SND_HDA_PREALLOC_SIZE is set to 4096 it only has memory to alloc
> for 8 frontends, while Skylake HDA card has 10 of them (6 playback and 4
> capture), so preallocated memory is exhausted while probing. In
> consequence 2 of FEs end without allocated memory.
> 
> It can be workarounded on user side with setting SND_HDA_PREALLOC_SIZE
> to lower value, other is changing memory limit per card.
> 
> However in order to not waste user memory, change maximum allocation
> size on HDA controller to 4MB and force automatical memory allocation
> insted of preallocated one.
> 
> First patch adds prints, so similar issues can be easily identified in
> the future.
> Second changes maximum size of hda buffer to reasonable value of 4MB.
> And last one reverts patch which allowed setting prealloc size on X86
> platforms.
> 
> Amadeusz Sławiński (3):
>    ALSA: pcm: Add debug print on memory allocation failure
>    ALSA: hda: Change AZX_MAX_BUF_SIZE from 1GB to 4MB
>    ALSA: hda: Revert "ALSA: hda: Allow setting preallocation again for
>      x86"
> 
>   include/sound/hda_register.h | 4 ++--
>   sound/core/pcm_memory.c      | 8 ++++++++
>   sound/hda/Kconfig            | 7 +++----
>   3 files changed, 13 insertions(+), 6 deletions(-)
> 

For the series:
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Nice work Amadeo.

Regards,
Czarek
