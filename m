Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A935DC43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:04:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3402920716
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yqmi9vc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3402920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FB191660;
	Wed, 18 Dec 2019 19:03:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FB191660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576692241;
	bh=JgBW4qMZh23GrbxvZuaN/BL1cvRLC2nI8rNZB/zgetQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yqmi9vc+U7cPtkY7/liSKIGXWTSRpg3g+R/FIxpMRyVrjD5/sYIKzlTntSbB63nU8
	 PZ2JJoKXFZ2KOnwYbl/yRTnrj91v9PX7/fsgRjpdAbCX+1N4QwiQfQ3bvHqAJzboGu
	 b9+/Ha2CwUMJwMxYTCWQ0zlZhRqeHntV7ywq+i5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C062F80258;
	Wed, 18 Dec 2019 19:02:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02E08F80258; Wed, 18 Dec 2019 19:02:16 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D863AF8022C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 19:02:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D863AF8022C
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 10:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="415912271"
Received: from dshoemak-mobl.amr.corp.intel.com (HELO [10.251.3.243])
 ([10.251.3.243])
 by fmsmga005.fm.intel.com with ESMTP; 18 Dec 2019 10:02:08 -0800
To: Mark Brown <broonie@kernel.org>
References: <87r212jqt1.wl-kuninori.morimoto.gx@renesas.com>
 <87o8w6jqrk.wl-kuninori.morimoto.gx@renesas.com>
 <CAFQqKeWWdwCMEO9idW4sANYio3y1ye3Q3okbOEd=zwYrRXDSYg@mail.gmail.com>
 <87eex2jnck.wl-kuninori.morimoto.gx@renesas.com>
 <bc4cef12-0095-e2af-5c91-63b06d815b8c@linux.intel.com>
 <20191218171415.GJ3219@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <aa512532-908d-c1e4-6284-b550da05d3f2@linux.intel.com>
Date: Wed, 18 Dec 2019 11:48:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218171415.GJ3219@sirena.org.uk>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH v2 2/7] ASoC: soc-core: care
 .ignore_suspend for Component suspend
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



On 12/18/19 11:14 AM, Mark Brown wrote:
> On Wed, Dec 18, 2019 at 08:54:27AM -0600, Pierre-Louis Bossart wrote:
> 
>> Even for dai links, it's not clear to me what .ignore_suspend means.
> 
> It means exactly what it says, don't do anything on suspend.
> 
>> For Intel machine drivers, the .ignore_suspend flag is used for DMIC links
>> which may be used in S0ix/D0ix states. I don't believe this works if there
>> are multiple target states, e.g. you would probably want to leave the link
>> active in S0ix, but suspend it in S3?
> 
>> I think the current .ignore_suspend settings only work with the assumption
>> that applications will close all capture streams before going to S3.
> 
> These numbered suspend states are a platform specific concept, other
> systems will typically just suspend or not suspend.  It sounds like this
> feature does not map onto your systems.

Correct. What is not clear to me is how we can specify a behavior that 
would be dependent on the target states.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
