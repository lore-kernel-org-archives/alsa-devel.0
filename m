Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36960C07E95
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 15:58:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991A2610D0
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 15:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991A2610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AEDB1654;
	Mon, 19 Jul 2021 17:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AEDB1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626710304;
	bh=TE5WU0vjSmqKcXSpP/TWG5MJRfjtJ14KJBn9uPl2FYI=;
	h=Subject:From:To:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZ0qI9TiDMcW+OeAXJksjdnywwq9xTt8E3bYbl45dk+gaOm7+2d3/b5ULHhoynUDy
	 VEXPMo2xHkMHi6S5ZzYRy5VCm/gWhxd6bThLoOBiU3sz9uQT6mYgmUebPSZxx5Lhsh
	 XD2WcTokkoKTlQh31Ix8b9AE2pUNbfqYtKU6/Tvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 912B6F80218;
	Mon, 19 Jul 2021 17:57:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9B08F80227; Mon, 19 Jul 2021 17:57:32 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95FB2F800C5
 for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2021 17:57:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95FB2F800C5
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="296642820"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; d="scan'208";a="296642820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 08:57:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; d="scan'208";a="414382608"
Received: from rraymond-mobl1.amr.corp.intel.com (HELO [10.209.130.70])
 ([10.209.130.70])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 08:57:26 -0700
Subject: Re: 5.14 regression, Intel SST (BYT) audio no longer works
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <6ebbcf0f-3a4b-0b28-1f17-8e1108f040c0@redhat.com>
 <f5dbc1c8-0118-17f7-1f6c-4dc8366b8dd0@linux.intel.com>
Message-ID: <808f4c7f-4460-40b7-aa91-68bebc639db2@linux.intel.com>
Date: Mon, 19 Jul 2021 10:57:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f5dbc1c8-0118-17f7-1f6c-4dc8366b8dd0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


>> I just noticed and I won't have time to dig any deeper for approx. the
>> coming 10 days. Still I wanted to report this in case anyone has any
>> ideas. Or maybe you can reproduce and look for a fix ?
>>
>> After building + installing 5.14-rc1 on a HP Elitepad 1000 G2
>> (Bay Trail) with a RT5642 codec, I noticed that sound over the
>> speakers and over the docks line-out jack no longer works.
>>
>> Downgrading to 5.13 (without any other changes) fixes this, so this
>> seems to be a regression with 5.14.
>>
>> I've no been able to make time to test this on other BYT/CHT hardware,
>> but I suspect that other models will be affected too.
> 
> Thanks Hans for the report, will look into this. 
> I can't think of anything that might explain this regression.
> I need to update the series to remove device properties so if the baseline is broken I'll see it as well...

I don't see any issues seen on a headless CHT Zotac device with RT5640, both with v5.14-rc1 or broonie/for-next.
Maybe something else happening with e.g. ACPI or GPIOs?
