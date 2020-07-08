Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD97C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F63207DA
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z+Vy1gzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F63207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 192D4166C;
	Wed,  8 Jul 2020 18:59:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 192D4166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594227623;
	bh=nbkABA7xjzZEqrtvcCaEOd9lZJXaldjUeFJcnLjs9QQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+Vy1gznNeqm9zYIXVamVCL3R1zuTjslmHBQjSzCW3EK2elOa6U7KbdWISCmlZ0hh
	 vFwvNdTq5E3nWvAQ3XuuccbPY2GzwiEe4ckaZV5869HRWbbciSOTH76cMsnWB6bXdj
	 5lutGKaKzRCPgocDclHVIwlD5xBWys8wMKIkquHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C665F8015D;
	Wed,  8 Jul 2020 18:59:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92C25F80161; Wed,  8 Jul 2020 18:59:18 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28091F8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 18:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28091F8011F
IronPort-SDR: 6bwGbftZtzE3wq5g5LxEzI74D01x5P6M5jVFWEo69CnHRPPbtQ23u6ESyPN5XYYI9twDSPd/Hl
 1o3B2O6xnwcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212788415"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; d="scan'208";a="212788415"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 09:59:07 -0700
IronPort-SDR: kFxAkyRZGP2s9lj6bOziRFXiFM+MAvLo2tFBLf34lH7tCYQJ9/JigrBIL2ez0zWI667l1PP8Wm
 v6lJIG+KEZ5w==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; d="scan'208";a="358162602"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246])
 ([10.251.7.246])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2020 09:59:07 -0700
Subject: Re: [PATCH 0/3] ASoC: more fixes for dpcm checks
To: Mark Brown <broonie@kernel.org>
References: <20200707210439.115300-1-pierre-louis.bossart@linux.intel.com>
 <20200708115349.GK4655@sirena.org.uk>
 <4290a302-e8a7-9b9b-7625-91f81a19aaf1@linux.intel.com>
 <20200708155321.GU4655@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d43a2721-5d21-1ed4-2ec0-b807e90dd312@linux.intel.com>
Date: Wed, 8 Jul 2020 11:59:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708155321.GU4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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



On 7/8/20 10:53 AM, Mark Brown wrote:
> On Wed, Jul 08, 2020 at 07:49:58AM -0500, Pierre-Louis Bossart wrote:
> 
>> I wasn't sure which branch to use to be honest. It's late in the cycle for
>> 5.8, the addition of the helper is new. I am happy to resubmit for 5.8 if
>> you prefer it this way.
> 
> They applied fine as-is so it's fine.

Great, thanks!
