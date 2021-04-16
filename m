Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E18FC433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:21:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005EC6137D
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 18:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005EC6137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC08016D5;
	Fri, 16 Apr 2021 20:20:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC08016D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618597309;
	bh=Pxo0SV+UUf2GwO86bCCjw8IDhjIuTrZtAacApZYdYB8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SESGoKVPIVO4EITD6ZNJdyBWNGqh3FkKoQsfoJ1/aH8+pm2boUjzD6s8cRXHn6gM+
	 4MacK2c9xOy2cu9oh33K2iXre4wmt2Skqzu9QlPsbdHMr0I0uqpKThMU7FnGyzuHyQ
	 ejy+3FX9wb0eyIh8WYWHnmWBf2T0vdFoZtcZ/BCk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C912F80254;
	Fri, 16 Apr 2021 20:20:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5C5FF8025B; Fri, 16 Apr 2021 20:20:56 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFBB1F800FF
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 20:20:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFBB1F800FF
IronPort-SDR: JEDIisc27Fy+yDCvv0NknOyL2lktt1cDPcJUZMUS6MyD9osAEnD0WkCo27g9Bz7sqJctfGMdCQ
 OtYis+hoV9kw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195195001"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="195195001"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 11:20:35 -0700
IronPort-SDR: 8JH/wrhdnfF+kjURjC6Ozss1arp1ZZz7rh2Q11JZjMVqzDrTb+lwYiQIdzxSaJy37svU/9R9dp
 ZImzXwfK/v0Q==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="616026100"
Received: from jaolanlo-mobl.amr.corp.intel.com (HELO [10.212.2.231])
 ([10.212.2.231])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 11:20:33 -0700
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To: Mark Brown <broonie@kernel.org>, Codrin.Ciubotariu@microchip.com
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
 <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
 <20210415161743.GH5514@sirena.org.uk>
 <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
 <20210415172554.GI5514@sirena.org.uk>
 <ad5d556b-601f-c6f6-347e-86a235237c02@microchip.com>
 <20210416163131.GI5560@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <79161044-26b2-729a-b831-b79cc238e239@linux.intel.com>
Date: Fri, 16 Apr 2021 11:47:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416163131.GI5560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, gustavoars@kernel.org, tiwai@suse.com,
 mirq-linux@rere.qmqm.pl
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



On 4/16/21 11:31 AM, Mark Brown wrote:
> On Fri, Apr 16, 2021 at 04:03:05PM +0000, Codrin.Ciubotariu@microchip.com wrote:
> 
>> Thank you for the links! So basically the machine driver disappears and
>> all the components will be visible in user-space.
> 
> Not entirely - you still need something to say how they're wired
> together but it'll be a *lot* simpler for anything that currently used
> DPCM.
> 
>> If there is a list with the 'steps' or tasks to achieve this? I can try
>> to pitch in.
> 
> Not really written down that I can think of.  I think the next steps
> that I can think of right now are unfortunately bigger and harder ones,
> mainly working out a way to represent digital configuration as a graph
> that can be attached to/run in parallel with DAPM other people might
> have some better ideas though.  Sorry, I appreciate that this isn't
> super helpful :/

I see a need for this in our future SoundWire/SDCA work. So far I was 
planning to model the entities as 'widgets' and lets DAPM propagate 
activation information for power management, however there are also bits 
of information in 'Clusters' (number of channels and spatial 
relationships) that could change dynamically and would be interesting to 
propagate across entities, so that when we get a stream of data on the 
bus we know what it is.

when we discussed the multi-configuration support for BT offload, it 
also became apparent that we don't fully control the sample rate changes 
between FE and BE, we only control the start and ends. I fully agree 
that the division between front- and back-ends is becoming limiting and 
DPCM is not only complicated but difficult to stretch further.
