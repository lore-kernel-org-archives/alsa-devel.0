Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23F7C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 12:20:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37660F9D
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 12:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E37660F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E650E17E1;
	Wed, 28 Jul 2021 14:19:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E650E17E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627474805;
	bh=06wNulovqo1rm8yegP14/KheK4nPT4qoNpGmYwqfd+Q=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9491O63+zVfD33suT+otSieFPZCrjttByZ8i1abZ75rw9CdPY7V7uRqvL+C8yK0w
	 UfdcGNgzv7jcs8qAh7M920lfbHAvFDRDOLlC+U+WRviw3fdSxtwExaWYUbfmVN/0dx
	 WjxD61Ru0vQqODE0B6BHONuPsP93gDp6Lh8fFKAo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 773A5F80253;
	Wed, 28 Jul 2021 14:19:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFBBAF8025A; Wed, 28 Jul 2021 14:19:12 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F465F8020D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 14:19:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5F465F8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="209540294"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; d="scan'208";a="209540294"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2021 05:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; d="scan'208";a="506438470"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.23.4])
 ([10.213.23.4])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2021 05:18:54 -0700
Subject: Re: [PATCH] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
To: Colin King <colin.king@canonical.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
References: <20210728103602.171817-1-colin.king@canonical.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <f95103b4-2527-b469-cd77-3afe4973abae@intel.com>
Date: Wed, 28 Jul 2021 14:18:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728103602.171817-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On 2021-07-28 12:36 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 

Thank you for the fix.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
