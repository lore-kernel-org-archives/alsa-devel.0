Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73259C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:51:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CDC2086A
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 17:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Eb0NC8EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CDC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80AAD1657;
	Mon,  3 Aug 2020 19:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80AAD1657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596477109;
	bh=uoMvmX8A5GSV71fMeSt+Pi43BLuWQZGrdnxy4jmxMz4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eb0NC8ENdI9DCJga+B5WqLc8xwwlQO7IsUbJlmnhhLTYn0vDHYvg6Hlo25f5vDcxZ
	 qo0qZZRWrqS/mscXpED7Ezd1bkBcAfl9l0MkFQkJTkRiE3Dd6TbDulAeIQgjrARjmp
	 0cQH96lGN02c0O3Hiyg7TA1xjX6aOWxFhgiLpyOs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1222AF800BD;
	Mon,  3 Aug 2020 19:50:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27666F80218; Mon,  3 Aug 2020 19:50:58 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 670ABF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 19:50:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 670ABF800BD
IronPort-SDR: BseJ9xk8Av1ijATqw/fVVVMm6PNVUfSElyznKUyQaEiY6onodcbP1EQxki3LXhW9FRrHI4uH+W
 xMwS/XuPFszg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="149615248"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="149615248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 10:50:51 -0700
IronPort-SDR: hOdiJNidcPOOLZB0eOpfj5YDCPJczoyfoxkmQ9QJDOxdUHqqG2P5tttzc8QDdWR4Csmg3vBe80
 h09bg/p36dSQ==
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; d="scan'208";a="330152837"
Received: from dravoori-mobl.amr.corp.intel.com (HELO [10.212.46.95])
 ([10.212.46.95])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 10:50:51 -0700
Subject: Re: [PATCH] Revert "ALSA: hda: call runtime_allow() for all hda
 controllers"
To: Takashi Iwai <tiwai@suse.de>
References: <20200803064638.6139-1-hui.wang@canonical.com>
 <0db4f5fe-7895-2d00-8ce3-96f1245000ab@linux.intel.com>
 <s5hwo2f3cux.wl-tiwai@suse.de>
 <6f583ccc-2251-384d-bc20-aa17c83a45b4@linux.intel.com>
 <s5hk0yf39wj.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f6a66bc4-9f1a-0425-6f00-4ddce3a2b6cc@linux.intel.com>
Date: Mon, 3 Aug 2020 12:50:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hk0yf39wj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org
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


>>>> Do I get this right that this permanently disables pm_runtime on all
>>>> Intel HDaudio controllers?
>>>
>>> It just drops the unconditional enablement of runtime PM.
>>> It can be enabled via sysfs, and that's the old default (let admin
>>> enabling it via udev or whatever).
>>
>> Sorry I am confused now.
>> Kai seemed to suggest in the Bugzilla comments that this would be
>> temporary, until these problems with i915 and ALC662 get fixed?
> 
> Right, that's the plan.  This patch revert to the old state before the
> forced-all-enable call we've taken in 5.7.  On 5.7 and onwards, all
> HD-audio controllers are enforced to use the runtime PM.  Before that
> version, the runtime PM was enabled *as default* only for limited
> devices (typically the ones bound with GPU); for other devices, the
> runtime PM is manually enabled from user-space via sysfs (and many
> distros enable them in anyway).
> 
> The forced enablement was merged with a hope that now all HD-audio
> controllers behave nicely, but it turned out to cause a regression, so
> it was reverted.  Once when we find out the real cause, we can flip
> the flag again.

ok, sounds good. I was concerned mainly because on the SOF driver side 
we enable pm_runtime by default, so that's a difference in configuration 
we need to be aware of when dealing with 'my speaker is silent' support 
questions.
