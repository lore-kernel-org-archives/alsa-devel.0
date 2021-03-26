Return-Path: <SRS0=Z4e1=IY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD2C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 16:26:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4631761A0D
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Mar 2021 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4631761A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1611165E;
	Fri, 26 Mar 2021 17:25:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1611165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616775958;
	bh=FF7/BB++tI2amDIlM5ItEdiF9ZWA+H/8ySMG0+YQvwo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHvldb5fdW80qaI/A4sCXqGMdwosU3UtaE7tikjb3u/0l9jtbc4s/SwAOgdFh2+OG
	 5Uvbax1fk68FlCMb6Bh4yCbzi3YUQ6p58KTQmmtk6zHIqPURy5rNbT1vnXkED9z9j8
	 tzVX2nxSoLmgOD/99/RZmDGoo9FV51K07jR0AUBo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15AC2F80156;
	Fri, 26 Mar 2021 17:25:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AE58F8016B; Fri, 26 Mar 2021 17:25:05 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B86DBF80104
 for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2021 17:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B86DBF80104
IronPort-SDR: dYU3SzO6asOALBSCHXs4SLDw8YqSAsWcDJ0oiunymLKUfXdUyKAZwNBEHwiPnG0krUUPDV5fSV
 dslUJYnDTtew==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="252530473"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="252530473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 09:24:51 -0700
IronPort-SDR: ccSVrBGzoKh5mP8SxuOFXDz87BSeqVxPwOM342JchlsoMfb1rq2jgWzAXHLQ+y1eNEN/f/64kH
 xB6W47jCc+xA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; d="scan'208";a="443869822"
Received: from ttle1-mobl.amr.corp.intel.com (HELO [10.212.227.242])
 ([10.212.227.242])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2021 09:24:50 -0700
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
 <YFo0WW8hOsHesSFC@kroah.com>
 <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
 <YFsG00+iDV/A4i3y@kroah.com>
 <357d9576-f79a-0ea6-eee4-292e27597565@linux.intel.com>
 <YFtchhxHDjfbyY46@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e76719e4-57aa-2a19-c9e4-469bab4ef1ca@linux.intel.com>
Date: Fri, 26 Mar 2021 11:24:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFtchhxHDjfbyY46@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, vinod.koul@linaro.org,
 linux-kernel@vger.kernel.org, hui.wang@canonical.com, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
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



On 3/24/21 10:36 AM, Greg KH wrote:
> On Wed, Mar 24, 2021 at 09:55:01AM -0500, Pierre-Louis Bossart wrote:
>> Note at this point it would mean an API change and impact the existing
>> Nvidia/Mellanox code, we are using the same sequence as them
> 
> THere is no "stable api" in the kernel, so if something has to change,
> that's fine, we can change the users at the same time, not an issue.

What I meant is that this requires consensus to make a change, and so 
far I haven't seen any burning desire from the contributors to revisit 
the 2-step sequence.

I will however modify the code in this patch to implement a SoundWire 
'linkdev' register/unregister function, it'll be much easier to review 
and maintain, and will follow the same pattern as the mlx5 code (all 
errors and domain-specific initializations handled in the same 
function). Draft code being tested is at 
https://github.com/thesofproject/linux/pull/2809
