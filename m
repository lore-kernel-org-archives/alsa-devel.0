Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD1C38A29
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA9320936
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 14:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mbGeFlDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B00F1693;
	Tue, 14 Apr 2020 16:45:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B00F1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586875580;
	bh=CFyx2jlgch7SVqn9pfr9H+vVrWh9pK1WZvkRuAqAD4U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mbGeFlDzuAo81kSDiAFs8cb/sUMbs+8jqFYhNzULQTNXf75CcVEsyfVftNfKR8sD0
	 Vi8mUHsZ53QpmOeZEJYxX9BYFMR8p9jHkqK16pQ9YJpsO/f/kB1fkKa5a/JuTdITO/
	 bKorP/ZKMo9cu3zg39hqY75S00nJkFk+jmaWfwXY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AE1CF80126;
	Tue, 14 Apr 2020 16:45:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D04C0F8013D; Tue, 14 Apr 2020 16:45:26 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D489F800F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 16:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D489F800F5
IronPort-SDR: Lj61EX4RbPCDfFZwncrjiarsSl4iPYy3GPMf5zQKCgs7WtUgiA/qvlzyK60aut93ATMm/KuPl1
 tpG90chuXO0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 07:45:19 -0700
IronPort-SDR: Lpqgqpuu8dkosUXnpShP+Se6gy09TW2I5uYsHkAFKYCyD2U13pjPC11BnEM3LP4Io2ww7omEDk
 ZE0E8zyZ7Sbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; d="scan'208";a="288236775"
Received: from bjkulkar-mobl.amr.corp.intel.com (HELO [10.212.152.71])
 ([10.212.152.71])
 by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 07:45:18 -0700
Subject: Re: Regression on Intel Atom/SST/Baytrail devices w/ v5.7-rc1
To: Hans de Goede <hdegoede@redhat.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>
References: <4d9d2c14-4db7-1a98-9b3d-e9193333e1b9@linux.intel.com>
 <c863319e-51bf-37e9-e550-5f1af1267408@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e75d7390-7375-a8b2-90f0-7041c8618bd3@linux.intel.com>
Date: Tue, 14 Apr 2020 09:45:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c863319e-51bf-37e9-e550-5f1af1267408@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, "Rojewski,
 Cezary" <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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


>>
>> Both 5.5 and 5.6 work though, as if we are missing a set of 
>> dependencies? I am running out of time this evening, but I'd be good 
>> to see if anyone else reproduces my findings.
> 
> I saw the same thing yesterday, also when testing UCM changes :)
> 
> I was planning to bisect this myself today. But given your findings I'm 
> not sure
> if that is useful.  I would count the intermediate errors as also being 
> bad I guess
> and try to find the first bad commit and see from there.
> 
> Can you send me your git bisect log ?

I didn't keep it but it pointed to v5.6-rc1 as the first bad commit - 
rather useless.

I'll try to spend more time on this later today.

The good thing is that it's not an isolated hardware problem, so we will 
likely reproduce this and converge to a solution faster. I only have 2 
devices that work reliably.

