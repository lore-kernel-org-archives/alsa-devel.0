Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF9C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 17:10:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26A661151
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 17:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B26A661151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76BAF184D;
	Fri, 15 Oct 2021 19:09:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76BAF184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634317817;
	bh=1jzp94ZkjpUkuWx6tVRwqIk44Ve+SbMxZLlxOtbjHj8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=juyiF/sdxrNTxsRJy4DnagdyaLj2BIZIT2RbSQlAadvH/duFlyZo+ISvoF92ZgruT
	 aNH0hSk8IjdpXAJmpBEpNytr20FuUmPS2vsR0Gy6wFri1xedtK/7ksTu+I1FZtfF7B
	 HoN/0YCW+/c58epP3He2GDzzf+sS+mmh66eZnRaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10DEFF8025B;
	Fri, 15 Oct 2021 19:09:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6FBB0F80269; Fri, 15 Oct 2021 19:09:25 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6596BF8016C
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 19:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6596BF8016C
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="291435159"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="291435159"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 10:08:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="492640732"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213])
 ([10.212.23.213])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 10:08:51 -0700
Subject: Re: [RFC PATCH v3 05/13] ASoC: soc-pcm: align BE 'atomicity' with
 that of the FE
To: Takashi Iwai <tiwai@suse.de>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-6-pierre-louis.bossart@linux.intel.com>
 <2847a6d1-d97f-4161-c8b6-03672cf6645c@nvidia.com>
 <s5hmtnavisi.wl-tiwai@suse.de>
 <e2a79095-b8ce-9dd4-3e6d-00f8dda99f30@linux.intel.com>
 <s5h1r4muwlj.wl-tiwai@suse.de>
 <8aa4fa07-2b55-3927-f482-c2fd2b01a22e@linux.intel.com>
 <s5hmtnateeo.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c0803288-efb1-aaeb-218f-e1a6ba87abd7@linux.intel.com>
Date: Fri, 15 Oct 2021 12:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hmtnateeo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>,
 vkoul@kernel.org, broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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


>> I have not been able to figure out when you need
>> a) the pcm_mutex only
>> b) the fe stream lock only
>> c) both pcm_mutex and fe stream lock
> 
> The pcm_mutex is needed for every sleepable function that treat DPCM
> FE link, but the mutex is taken only at the upper level, i.e. the
> top-most caller like PCM ops FE itself or the DAPM calls.
> 
> That said, pcm_mutex is the top-most protection of BE links in FE.
> But, there is a code path where a mutex can't be used, and that's the
> FE and BE trigger.  For protecting against this, the FE stream lock is
> taken only at the placing both adding and deleting a BE *in addition*.
> At those places, both pcm_mutex and FE stream lock are taken.
> 
> BE stream lock is taken in addition below the above mutex and FE
> locks.

Thanks Takashi, now I get the idea. Makes sense indeed. I'll make sure
to add this explanation to the commit message/cover so that it's not lost.

I added your three patches to my tests, so far so good, code is that
https://github.com/thesofproject/linux/pull/3215

Thanks and have a nice week-end.
-Pierre
