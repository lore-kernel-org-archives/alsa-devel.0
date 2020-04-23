Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7AC54FCB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24A32074F
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UyQdrs7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24A32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 318D5168F;
	Thu, 23 Apr 2020 14:21:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 318D5168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587644545;
	bh=RMF1XpQ3Xpc8EkGE9mWgGIu/O1jf+gFUjfjaNXQy/tE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UyQdrs7d5xtDbXlRJyfi2yTQuQvu2tuQFfdjP73JOjuaZxqRbzhAgXjeDKgtgR4OS
	 XtrTB0E4AEJP0Nx8IHGZqrJZsYXe2fnCWKOHO6muzzxFaKBXl0XR0IoKlF0dRlz0Sh
	 AI81h/ecKmcVoTf0T4vq+4c9/MYvsrMT+hLvWfeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A894AF8014A;
	Thu, 23 Apr 2020 14:21:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C593F801EC; Thu, 23 Apr 2020 14:21:33 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E8BAF800F2
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 14:21:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E8BAF800F2
IronPort-SDR: fi9mrEVhoXdclQLwuBCtMhY9G//RB/hjna5xT4ZHfq/HxmYkOXrnAA/OC0DJ4Rl39k5roHba5e
 nuzIYhfkqN6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 05:21:18 -0700
IronPort-SDR: VfR3+0izsBevAFSVUk0M5ywliTwGQdAdtZfhTF1rys9TiTik4jg2vZKwmCKqLkag3rCbL3FxHI
 eXRt2sK1dTmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="456891434"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.5.100])
 ([10.213.5.100])
 by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2020 05:21:16 -0700
Subject: Re: [PATCH] ALSA: hda: Refactor Intel NHLT init
To: Takashi Iwai <tiwai@suse.de>
References: <20200423112136.25207-1-cezary.rojewski@intel.com>
 <s5hd07ywikl.wl-tiwai@suse.de>
 <b37cb05b-f4c2-e747-c3f0-1582ed3afadd@intel.com>
 <s5h7dy6wg89.wl-tiwai@suse.de>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <57dca563-b79c-3721-0057-22057db0e5a9@intel.com>
Date: Thu, 23 Apr 2020 14:21:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <s5h7dy6wg89.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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

On 2020-04-23 14:15, Takashi Iwai wrote:
> On Thu, 23 Apr 2020 13:40:10 +0200,
> Cezary Rojewski wrote:
>>
>> On 2020-04-23 13:24, Takashi Iwai wrote:
>>> On Thu, 23 Apr 2020 13:21:36 +0200,
>>> Cezary Rojewski wrote:
>>>>
>>>> NHLT fetch based on _DSM prevents ACPI table override mechanism from
>>>> being utilized. Make use of acpi_get_table to enable it and get rid of
>>>> redundant code.
>>>>
>>>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>>>
>>> This looks like a nice cleanup and I'll happily apply if anyone can
>>> test with the actual hardware -- currently mine has no DSP, so unable
>>> to check.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>> NHLT override method has been added for internal use half a year ago
>> and is for some time the default method within our CI. This is tested
>> on a wide spread of hardware, that is any Intel AVS archtecture,
>> including production laptops.
> 
> This could be mentioned in the changelog, otherwise we have no idea
> about the test coverage.
> 

My apologizes Takashi, indeed I should have mentioned that :(

I've forgotten about one more positive news:
https://bugs.acpica.org/show_bug.cgi?id=1525

Robert is working on official NHLT support for iASL. Currently, only 
header gets decompilled while the rest is dumped as binary array.

Do you want me to resubmit the patch with this entire info appended to 
the commit message?

Czarek
