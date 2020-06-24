Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119ECC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830CC20720
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cACIZKm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830CC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F5EA185A;
	Wed, 24 Jun 2020 17:48:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F5EA185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593013744;
	bh=+dJjNjbAFG5oreJ6jWgolF5zddh7mL9u3hY4kWcH1bI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cACIZKm+UC5dx1fH8w4TTE3/VcItGBpg9BKzp+PhYoFAbo45m8WuMrjf35rXErpA+
	 nY4K4lM1uCxOKp2A2haSP9qQ2mjs4a+nA7y+LlObjSkLKHjegz+der1td+BbyZkRaU
	 12VHanq08DY0AqrcVFJXDnz/ONaKzV3qvd7Ar4+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A16F9F8015A;
	Wed, 24 Jun 2020 17:48:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25652F800B2; Wed, 24 Jun 2020 17:48:12 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83457F800B2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 17:48:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83457F800B2
IronPort-SDR: T1y+D+lCa2eTDyKb/Tty6ApUoT62arHHAepsf3imv3jl89R6cR6qTFva5mqMDvJUJ+Y6BLGvqR
 BRTUj5roPRoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124773171"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="124773171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 08:48:04 -0700
IronPort-SDR: 1fOZxaumamDFEwr2EtI126XZfYPpl6EnkhnFagpBmQGlfjPIaer8ZHziy+gLU7hEdicHiz1YbL
 DnDMB7diiitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; d="scan'208";a="279509947"
Received: from bkorrapa-mobl1.amr.corp.intel.com (HELO [10.254.109.185])
 ([10.254.109.185])
 by orsmga006.jf.intel.com with ESMTP; 24 Jun 2020 08:48:03 -0700
Subject: Re: [PATCH] ALSA: hda/hdmi: Add Intel silent stream support
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 Harsha Priya <harshapriya.n@intel.com>
References: <1592954796-12449-1-git-send-email-harshapriya.n@intel.com>
 <s5hr1u4lxee.wl-tiwai@suse.de>
 <f2da25c0-c740-4d44-ab66-6017622f7dde@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7dd38f98-e74a-94c0-6888-523e6189c00b@linux.intel.com>
Date: Wed, 24 Jun 2020 10:33:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f2da25c0-c740-4d44-ab66-6017622f7dde@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@intel.com, Emmanuel Jillela <emmanuel.jillela@intel.com>,
 alsa-devel@alsa-project.org
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


>>> The silent stream is enabled with a Kconfig option, as well as a kernel
>>> parameter should there be a need to override the build time default.
>>
>> I'm not sure whether the module option is the best interface.
>> An alternative is a mixer element that controls dynamically.  Then
>> it'll be per card unlike the module option.
> 
> +1, kcontrol seems the appropriate way to control this.

It was my suggestion to use Kconfig+kernel parameter for 
simplicity/overrides.

The kcontrol is a nice idea, but in practice we typically only have one 
card dealing with HDMI. It also doesn't have a UCM representation so 
would force the use of amixer and manual configs, or the UCM file would 
always set the mode.

