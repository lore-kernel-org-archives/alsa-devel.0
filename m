Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E5ECE587
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:47:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432D2133F
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mTg0JxyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BE8F1680;
	Mon, 14 Oct 2019 17:46:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BE8F1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571068050;
	bh=r2HADENyTkWRTYmAa1dMi6mx9m7/Hbg95j7bhNbOxU8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTg0JxyXt5CoINbw7Fpp/iitagvsonmUCKYpygmyt0uYf3WibGB3HM8rak1sMAJJN
	 FPai+AHuWMTIyLFjSNMPlVhJdvuIyxUJqkqLFJPoIcss+RolyEikyRwvTdoaalUduK
	 yUd+1eE5/yTesY/M1havbVpMSQhe5xgpOhlAwLoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64A31F804AB;
	Mon, 14 Oct 2019 17:45:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A72E8F8049B; Mon, 14 Oct 2019 17:45:33 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B57AF8049B
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 17:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B57AF8049B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 08:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; d="scan'208";a="199434997"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135])
 ([10.251.134.135])
 by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 08:45:26 -0700
To: "Lu, Brent" <brent.lu@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <1569919250-24472-1-git-send-email-brent.lu@intel.com>
 <1569991858-24293-1-git-send-email-brent.lu@intel.com>
 <CF33C36214C39B4496568E5578BE70C740314038@PGSMSX108.gar.corp.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5cb82600-71a2-53c8-21b6-a1171cae41ad@linux.intel.com>
Date: Mon, 14 Oct 2019 10:38:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C740314038@PGSMSX108.gar.corp.intel.com>
Content-Language: en-US
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>, "N,
 Harshapriya" <harshapriya.n@intel.com>,
 "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
 "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Chiang,
 Mac" <mac.chiang@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "M,
 Naveen" <naveen.m@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: eve: Enable mclk and ssp sclk
 early
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



On 10/14/19 2:31 AM, Lu, Brent wrote:
>> Subject: [PATCH] ASoC: Intel: eve: Enable mclk and ssp sclk early
>>
>> From: Naveen M <naveen.m@intel.com>
>>
>> rt5663 and rt5514 needs mclk/sclk early to synchronize its internal clocks.
>>
>> Signed-off-by: Naveen M <naveen.m@intel.com>
>> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>> Signed-off-by: Brent Lu <brent.lu@intel.com>
>> ---
>>   sound/soc/intel/boards/Kconfig                     |  1 +
>>   .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 94
>> ++++++++++++++++++++++
>>   2 files changed, 95 insertions(+)
>>
> 
> Hi Pierre-Louis
> 
> This is the v2 patch based on your previous comment to remove unnecessary
> function calls. The order in Kconfig is also rearranged. Please let me know if
> this patch is ok. Thanks.

I don't see a v2?
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
