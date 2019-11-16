Return-Path: <SRS0=Of65=ZI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DEFC432C3
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Nov 2019 00:20:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1782073C
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Nov 2019 00:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YhrQ6L2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1782073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73B7C1682;
	Sat, 16 Nov 2019 01:19:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73B7C1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573863625;
	bh=xlz5JVQ/2ws8liWSLrHBAuiA0rjrGN+OOTlln80eKI0=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YhrQ6L2GEl262kVaoQ1/GScXtTnIfWZ7GfKJoyN2B1n73pYw1yKsxQwk658Cf6vql
	 J18mMW+yecnInwBquBp1hdFiQ8O6DDNL8BGXCshYuYm0TC8S+HAj2s0aVOFyqMntwI
	 kM9U0qP9X7Ma6VnDt8faG9QopH5SttnU8Bbm0i9U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4354F80103;
	Sat, 16 Nov 2019 01:19:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D0A0F80104; Sat, 16 Nov 2019 01:19:33 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 505C6F800CC
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2019 01:19:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 505C6F800CC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Nov 2019 16:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,310,1569308400"; d="scan'208";a="405508476"
Received: from sjing-mobl.amr.corp.intel.com (HELO [10.251.158.74])
 ([10.251.158.74])
 by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2019 16:19:25 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <87ftj23jph.wl-kuninori.morimoto.gx@renesas.com>
 <877e4e3jni.wl-kuninori.morimoto.gx@renesas.com>
 <8ed58ca1-0f9d-63e8-ba5d-28ee5209aee5@linux.intel.com>
 <87pnhx8xjl.wl-kuninori.morimoto.gx@renesas.com>
 <87o8xh8wyz.wl-kuninori.morimoto.gx@renesas.com>
 <87mud18ukk.wl-kuninori.morimoto.gx@renesas.com>
 <73feb970-bca5-b736-ce44-d44dacab02d1@linux.intel.com>
 <20191112190326.GJ5195@sirena.co.uk>
 <ce011d55-b1b2-7bd9-9de3-48fb616703f0@linux.intel.com>
 <87lfsk4cit.wl-kuninori.morimoto.gx@renesas.com>
 <3e4b8289-8e59-d8fe-635b-d55d2b20de5d@linux.intel.com>
 <87a78zia3n.wl-kuninori.morimoto.gx@renesas.com>
 <878soji808.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <28d2c726-2a6c-08c2-3393-21c88dcfb03e@linux.intel.com>
Date: Fri, 15 Nov 2019 18:19:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <878soji808.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH v3 06/19] ASoC: soc-core: add
 soc_unbind_dai_link()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> But, these are just my guess.
> It works for me, but I can't re-produce the issue.
> 
> Below is the patch for "testing".

Morimoto-san, I haven't fully tested the logic and all the long 
description, but the patch suggested seems to work on all the platforms 
I tested on - and actually improves things on Baytrail/Cherrytrail.

I haven't seen any oopses in several hours now and no regression 
reported by Intel CI https://github.com/thesofproject/linux/pull/1504

Let's see what others think or tested.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
