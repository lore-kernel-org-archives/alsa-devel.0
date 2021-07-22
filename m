Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC80C6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:30:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DA56100C
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DA56100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88CDC1661;
	Thu, 22 Jul 2021 16:29:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88CDC1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626964248;
	bh=YQ4Eqtal9qqe8RND+8CQmsLz+r3wGdTRMNCxDLg3Ppg=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dkf5mJPU0i3c4XGzbJmzL7oc6m/h7aSHCcT6xuCbJ6fYYVef4ySxSFis3L6oXZoAE
	 9zoC7FBetI/86GV4RXuhk3RYsMAwSwvAw1Pmz49bO8LEd9gikJzzXu52v0rdOiW/JB
	 x/NcbXhycn2aAc7pMOJ7Xonjs7Uto1fvbQDHsncE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6729FF80218;
	Thu, 22 Jul 2021 16:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3508CF80227; Thu, 22 Jul 2021 16:29:32 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E27E1F80114
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 16:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E27E1F80114
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="191245044"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; d="scan'208";a="191245044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2021 07:29:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; d="scan'208";a="577313896"
Received: from kkho1-mobl1.amr.corp.intel.com (HELO [10.212.20.95])
 ([10.212.20.95])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2021 07:29:19 -0700
Subject: Re: [PATCH 1/2] soundwire: dmi-quirks: add quirk for Intel 'Bishop
 County' NUC M15
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
References: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
 <20210719233248.557923-2-pierre-louis.bossart@linux.intel.com>
 <YPl6Z+jqR9gnTw05@matsya>
 <c86efd0f-b941-f3ff-885d-f1d0d7d46d30@linux.intel.com>
Message-ID: <fc9494a5-3729-500c-b4c9-76c023aaedd6@linux.intel.com>
Date: Thu, 22 Jul 2021 09:29:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c86efd0f-b941-f3ff-885d-f1d0d7d46d30@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org, Rander Wang <rander.wang@intel.com>,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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



On 7/22/21 9:25 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 7/22/21 9:02 AM, Vinod Koul wrote:
>> On 19-07-21, 18:32, Pierre-Louis Bossart wrote:
>>> The same quirk is used for LAPBC510 and LAPBC710 skews who use the
>>> same audio design.
>>>
>>> These devices have the same BIOS issues inherited from the Intel
>>> reference, add the same _ADR remap previously used on HP devices.
>>
>> This fails to apply on rc1, pls rebase or if there are any dependencies,
>> do spell them out
> 
> it likely depends on
> 
> [PATCH] soundwire: dmi-quirks: add ull suffix for SoundWire _ADR values
> 
> which was sent by Bard when the merge window opened.

And you've just applied that dependency, do you mind retrying Vinod?

