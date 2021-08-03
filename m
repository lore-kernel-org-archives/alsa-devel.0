Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AACC4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 10:01:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1604760F58
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 10:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1604760F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C6081705;
	Tue,  3 Aug 2021 12:00:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C6081705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627984909;
	bh=DfsjgBIn6wVNq03jPO5VNJ8jSmzhpazyns8miIyoz0Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uBrwUtqgdY0aZn1RtKAU7AZopxmYbUhpdBVbl6L1T7XVNnHGoG6qXxOhkbOo3xNCd
	 apNinP58AdXlMbp3uMyjXN3r2Zp/yK2Ln5J2T3BvXyw4YAipSVyY82MQnGY+W+cPS0
	 DViKJTd0wsfIlAhV54rW/8AZg4eOxnP0Wggr4BDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E02E0F8016D;
	Tue,  3 Aug 2021 12:00:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C6D9F802E8; Tue,  3 Aug 2021 12:00:57 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AC72F8014D
 for <alsa-devel@alsa-project.org>; Tue,  3 Aug 2021 12:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AC72F8014D
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="210534097"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="210534097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 03:00:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; d="scan'208";a="479416899"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.13.248])
 ([10.213.13.248])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2021 03:00:46 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add max98390 echo reference
 support
To: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
 alsa-devel@alsa-project.org
References: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c002c16c-dc89-d9ca-dab2-c252c83c5b06@intel.com>
Date: Tue, 3 Aug 2021 12:00:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: lance.hou@intel.com, mark_hsieh@wistron.com, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, yang.jie@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 mac.chiang@intel.com, broonie@kernel.org, brent.lu@intel.com,
 bard.liao@intel.com
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

On 2021-08-03 11:20 AM, Mark Hsieh wrote:
> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
> ---

Hello,

Any commit message is better than none. Please provide one.

Regards,
Czarek
