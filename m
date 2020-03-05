Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4F9C3F2D1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:48:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795A9208C3
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aLh7Fo3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795A9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA241679;
	Thu,  5 Mar 2020 14:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA241679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583416131;
	bh=ufzefTTBHwNSG1G2m2g0a9dOag7OVo6tyzu5YzgugfU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLh7Fo3hKTsKSYf4fapiJvEMjVGe0BvEIx0Il7XX7eZybOVjsAfzyKtNOAhqAu8dl
	 iGYPNoKgGbh1erc1ecqc2oqPgIvKRdhK8lWqC++c11n0sm7Z79vndpP4ErLSemT1SQ
	 BoiKwXQ3e3S2hivgEQObpzVH+BIgYTrK8L10hOE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF42AF80126;
	Thu,  5 Mar 2020 14:47:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4FD26F80266; Thu,  5 Mar 2020 14:47:56 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31C08F800D8
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 14:47:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31C08F800D8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 05:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="229692442"
Received: from virbhadx-mobl1.amr.corp.intel.com (HELO [10.254.184.168])
 ([10.254.184.168])
 by orsmga007.jf.intel.com with ESMTP; 05 Mar 2020 05:47:48 -0800
Subject: Re: [RFC PATCH 2/3] ASoC: Intel: bdw-rt5677: fix module load/unload
 issues
To: Mark Brown <broonie@kernel.org>
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-3-pierre-louis.bossart@linux.intel.com>
 <20200305133638.GE4046@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13857c7b-f7d2-9be2-c1e1-a577a774773e@linux.intel.com>
Date: Thu, 5 Mar 2020 07:47:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305133638.GE4046@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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



On 3/5/20 7:36 AM, Mark Brown wrote:
> On Thu, Mar 05, 2020 at 07:06:15AM -0600, Pierre-Louis Bossart wrote:
>> The use of devm_gpiod_get() in a dailink .init() callback generates issues
>> when unloading modules. The dependencies between modules are not well
>> handled and the snd_soc_rt5677 module cannot be removed:
> 
> In what way are the dependencies not well managed and why aren't we
> requesting the GPIO on device model probe anyway?

there are a couple of machine drivers where the gpios are requested from 
the machine driver. I have no idea what it is done this way, maybe the 
codec exposes a gpiochip that's used later? I was hoping that Andy can 
help, I don't fully get the acpi mapping and all.

see the code here for reference:

https://elixir.bootlin.com/linux/v5.6-rc4/source/sound/soc/intel/boards/bdw-rt5677.c#L250

The issue happens when running our test scripts, which do a set a rmmod 
in a specific order: rmmod of the machine driver, then doing an rmmod of 
the codec driver. Somehow the second fails with the 'module in use error'.

It's probably because the devm_ release does not happen when the card is 
unregistered and the machine driver resources released since we use the 
component device. There might very well be a bug somewhere in the devm_ 
handling, I just don't have a clue how to debug this - and the .exit() 
makes sense regardless in other cases unrelated to GPIOs.

