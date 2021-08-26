Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEAAC432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 19:25:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CFC61037
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 19:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63CFC61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 302E016BD;
	Thu, 26 Aug 2021 21:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 302E016BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630005924;
	bh=02BcOVNPw9nfhu4aiA3EUrz4RnTHIjePdXanbpmKlzg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cW9vyc0Bfl0Ivf1KMD7ZG8q6HzEzU006Kz8HOe99uikHKp0rXx85FfqJKugCAqxlQ
	 7YBBd1zQk6E/XYkjo+n6g3YqxrNqm1Dt5tFc3Fxm4UCTKTb95f6VGDHqSYT39fqvvs
	 GQnkaFqqDYWxVHgd6a4i0+w0owA+msQ7dVDgi+vE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD344F801D5;
	Thu, 26 Aug 2021 21:24:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E727F801D8; Thu, 26 Aug 2021 21:24:32 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E1D7F80054
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 21:24:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E1D7F80054
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="204959549"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; d="scan'208";a="204959549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2021 12:24:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; d="scan'208";a="474321237"
Received: from hjasuja-mobl.amr.corp.intel.com (HELO [10.251.134.37])
 ([10.251.134.37])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2021 12:24:22 -0700
Subject: Re: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes
 in trigger
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
 <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
 <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
Date: Thu, 26 Aug 2021 14:24:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Brown@sirena.org.uk, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 tiwai@suse.de, Takashi Iwai <tiwai@suse.com>,
 open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark@sirena.org.uk
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



On 8/26/21 1:30 PM, Mark Brown wrote:
> From: Mark Brown,,, <broonie@kernel.org>
> 
> On Tue, 17 Aug 2021 11:40:53 -0500, Pierre-Louis Bossart wrote:
>> When more than one FE is connected to a BE, e.g. in a mixing use case,
>> the BE can be triggered multiple times when the FE are opened/started
>> concurrently. This race condition is problematic in the case of
>> SoundWire BE dailinks, and this is not desirable in a general
>> case. The code carefully checks when the BE can be stopped or
>> hw_free'ed, but the trigger code does not use any mutual exclusion.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] ASoC: soc-pcm: protect BE dailink state changes in trigger
>       commit: 0c75fc7193387776c10f7c7b440d93496e3d5e21
> [2/2] ASoC: soc-pcm: test refcount before triggering
>       commit: 6479f7588651cbc9c91e61c20ff39119cbc8feba

Ah sorry, there were still some issues in this RFC, we did more testing
and came up with a lot of improvements. The intent of the RFC status was
also to make sure it wasn't applied before the merge window.

Can this be reverted in your branch Mark?
