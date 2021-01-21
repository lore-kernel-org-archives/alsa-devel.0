Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8ACC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 15:09:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5509E238E3
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 15:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5509E238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FE271783;
	Thu, 21 Jan 2021 16:08:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FE271783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611241784;
	bh=LRY5OUVqKzXd+ZwX9/0wcvJ6YRu7NnVfsVws0xCa8Uw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Viyn/cwPSty1yZcDVu2azG+J7jkGFUZyRQ1Y96lTkzafkBW37vgLF59qGje1ROV+U
	 SQeDRvOfTiowDz4aXjfFy0QNfPJm7Lr9ezeQuiVKITYX5WPWzeSttCiEqsspCi4r8U
	 34Ri+pOV+k4I/72hJFF5SRj1fhsQ0Dt4Ozxx98oY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C25EF80255;
	Thu, 21 Jan 2021 16:08:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17FA9F80257; Thu, 21 Jan 2021 16:08:52 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11A83F80125
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 16:08:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11A83F80125
IronPort-SDR: tL4uUWcTnH4dzCGDEhn3MtRPCwIZLC2rJaupDEUDyoJX15fRjbdbjKKswars2ww3pT+mQeOVMi
 lZQ35X5RcZsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179365824"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; d="scan'208";a="179365824"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 07:08:41 -0800
IronPort-SDR: XgvKLvQh85KLzKPRB4BEaFaUQ4oDo7qpYxmTW1APPwol1OVNzfvY8F9ymW0GvEN+YXatsBhOro
 Q/EPNz+4HMDg==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; d="scan'208";a="427388017"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.249.156.85])
 ([10.249.156.85])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 07:08:38 -0800
Subject: Re: [PATCH 2/5] Revert "ASoC: soc-devres: add
 devm_snd_soc_register_dai()"
To: Mark Brown <broonie@kernel.org>
References: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
 <20210120152846.1703655-3-amadeuszx.slawinski@linux.intel.com>
 <20210120172948.GE6794@sirena.org.uk>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <809fa3da-6153-53aa-4227-b556f903d3de@linux.intel.com>
Date: Thu, 21 Jan 2021 16:08:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210120172948.GE6794@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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

On 1/20/2021 6:29 PM, Mark Brown wrote:
> On Wed, Jan 20, 2021 at 04:28:43PM +0100, Amadeusz Sławiński wrote:
>> As described in preceding patch, waiting with DAI removal until device
>> is being unregistered can lead to working on freed memory, hence having
> 
> There is a potential for misuse with essentially all devm functions -
> why is this one so special?

Hm... right, I blinded myself thinking too much about specific use case 
where it was used in topology. As topology is used with drivers split 
into multiple modules where it caused problem. It should work fine if 
someone writes monolithic module and needs to register DAI. I guess we 
can skip this patch then.

> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 
>> DAIs managed by resource managed memory is a bad idea, revert commit
>> creating devm_ API for this, so no one makes a mistake of using it.
>>
>> This reverts commit 0fae253af563cf5d1f5dc651d520c3eafd74f183.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
> 

