Return-Path: <SRS0=rxKz=KH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81851C43617
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 16:27:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E1E613AF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 May 2021 16:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E1E613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D6F1833;
	Wed, 12 May 2021 18:26:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D6F1833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620836824;
	bh=yuvJEq06mN6effKnqHexkj2oma2V4bNN3FO8AkjlCAo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJlVp83/w7uclKVXJpiEIHKOZ4svmD+HOh+d/sI8mwxAGOF/8nres2HNUaEMAEP07
	 V8zTBkEPtukqzy4QHsk0bGSBDFH6AT6RD6UdcXn6gq+Qcx4ccrAU3nH0cHczUOGJJs
	 NNJf28Q1dh2Z+V2hZy0wcfc5bX/3ObZ+iU1MTvIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4C13F8012E;
	Wed, 12 May 2021 18:26:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07ECEF80240; Wed, 12 May 2021 18:26:13 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F213F8013A
 for <alsa-devel@alsa-project.org>; Wed, 12 May 2021 18:26:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F213F8013A
IronPort-SDR: 3eDbmKyQjz2oXmmagmovDWsGlDndXMNhQtGmdDZRe3cjI684/VN48L+QtK9MtlLj7Ljo6QFhxi
 AWp+Suyfv+Ew==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="197773843"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="197773843"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 09:25:59 -0700
IronPort-SDR: dHfPVdrBuQvyobdL3A9WvlZuIsDR0OwBTAZWGxKLKH/0nZHrk0K2RmOiIZ11T4dXanxRqC3bLb
 vR0taFWc/cfg==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="455671473"
Received: from tzehanch-mobl2.amr.corp.intel.com (HELO [10.213.186.26])
 ([10.213.186.26])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 09:25:56 -0700
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
To: Mark Brown <broonie@kernel.org>
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
 <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
 <20210512155318.GA54562@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b2873226-4505-5a7b-74ce-95e8d4dd72b5@linux.intel.com>
Date: Wed, 12 May 2021 11:25:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512155318.GA54562@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ranjani.sridharan@linux.intel.com, liam.r.girdwood@linux.intel.com,
 cezary.rojewski@intel.com, dharageswari.r@intel.com,
 kuninori.morimoto.gx@renesas.com, kai.vehmanen@linux.intel.com,
 yang.jie@linux.intel.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 fred.oh@linux.intel.com, tzungbi@google.com, sathyanarayana.nujella@intel.com,
 Zou Wei <zou_wei@huawei.com>, alsa-devel@alsa-project.org, brent.lu@intel.com,
 yong.zhi@intel.com
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



>> I wonder if this MODULE_DEVICE_TABLE generates the alias automatically,
>> which would make the existing ones added manually at the end of the files
>> unnecessary? If that was the case, then we should remove those MODULE_ALIAS
>> as well, no?
> 
> Yes, you shouldn't need the MODULE_ALIAS stuff there.

ok, if that's alright with everyone I'll send a larger patchset that 
correct this for all machine drivers, and add the following two tags to 
give proper credits to the reporters.

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Zou Wei <zou_wei@huawei.com>

