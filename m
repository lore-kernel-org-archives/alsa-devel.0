Return-Path: <SRS0=n4Uk=5Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC893C2D0EA
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:21:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CD420787
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 14:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SAZYZjo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CD420787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674BD16C0;
	Wed,  8 Apr 2020 16:20:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674BD16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586355696;
	bh=8Ch0bYxr10QemZMgrr7shqCQ3nmfBF9onOc/c1+lT+M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SAZYZjo9BJlyv0+hknwlN7gtq7XRqRtAuzxfQb57YzIzv355bpDjzraEuwH7ExsQX
	 vt+LpBy0qkxgewo3yDiMnId7fje1SGo7JemcGxislCvhIt503yvDfK2kkSrTnCe7U3
	 5SoYHT1RuIs8IqStkZs5wAuIWdDRqMVzPi0iMXpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2125F80142;
	Wed,  8 Apr 2020 16:20:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B95BF80143; Wed,  8 Apr 2020 16:20:44 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79AADF80105
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2020 16:20:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79AADF80105
IronPort-SDR: ZsL2UN3yX3xV0noUF/Rt39BvpVxHPieTmgHyjs4alOYfe00tNmwUkLbYc7ZvBRmrfCeWgelGJT
 b/jUF6J+hCjw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2020 07:20:35 -0700
IronPort-SDR: sEVShWP1qj6EanVD4hrbk+VQWd7ikDlSk6wnLTzV47Y6Zw6Bq0LKMDw363DwL3uy9HPcYvuC8u
 cHSHC1Km/3yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,358,1580803200"; d="scan'208";a="330548345"
Received: from asalter-mobl.amr.corp.intel.com (HELO [10.134.96.70])
 ([10.134.96.70])
 by orsmga001.jf.intel.com with ESMTP; 08 Apr 2020 07:20:35 -0700
Subject: Re: [PATCH v2 0/6] ASoC: topology: Propagate error appropriately
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20200327204729.397-1-amadeuszx.slawinski@linux.intel.com>
 <e345ffe1-1593-49c0-32bd-4637bc1764da@linux.intel.com>
 <a7b5e659-01c9-f966-2d26-cac8d10b96bb@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f924fe56-0395-11af-244f-7074b7a704e5@linux.intel.com>
Date: Wed, 8 Apr 2020 09:20:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a7b5e659-01c9-f966-2d26-cac8d10b96bb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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


>> Looks good to me
>>
>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> We probably want Ranjani to double-check this series though.
>>
> 
> Hi Ranjani, can you take another look, I would like for this to get 
> merged before I forget about it ;)

Ranjani provided her Reviewed-by tag on March 30 - likely our emails 
crossed.
