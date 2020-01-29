Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E8C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:42:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3F2206D4
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 19:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EbzaEAeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88F46166D;
	Wed, 29 Jan 2020 20:41:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88F46166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580326966;
	bh=Kx9xufDXvHHboNMCUhH/9OLpSeiynBpBfl0kb1znG9A=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EbzaEAeAcElqahs/yMmwV2SJdxCV0yglG5UnjuUmdy/K3B/dSP6EQOR3t3XoE3mAY
	 ZWrF8K5YNYeqeHZqIePQTCPY8tQT6onCBg9GqXZmvHC3jUrR0gMMKhoFSPzmTvy7YU
	 /cVo5xQrm6/Wc1MeXVJDjRsQ9i5LGfVFEiZsR29Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAD1BF80218;
	Wed, 29 Jan 2020 20:41:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98AAAF8021E; Wed, 29 Jan 2020 20:41:53 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27073F80082
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 20:41:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27073F80082
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 11:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; d="scan'208";a="222556721"
Received: from rnoffsin-mobl.amr.corp.intel.com (HELO [10.252.139.181])
 ([10.252.139.181])
 by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 11:41:34 -0800
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <CAFQqKeUnT=QHkBWp3ZDeuBtYCS=f7FLa0+eS9sRo8reK0N6YWg@mail.gmail.com>
 <20200129185947.GA478824@kroah.com>
 <CAFQqKeXOGOHpqWCmUskw4r5z1kKQG-_1zuKpaXb6gBozWWG+0g@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <95481116-cb3e-8025-87b8-554b1a8bc37e@linux.intel.com>
Date: Wed, 29 Jan 2020 13:41:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFQqKeXOGOHpqWCmUskw4r5z1kKQG-_1zuKpaXb6gBozWWG+0g@mail.gmail.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [alsa-devel] Question about the correct license to use with
 debugfs in SOF
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


>>> Currently, it is dual licensed with GPLv2.0 and BSD. But Pierre brought
>> up
>>> a concern about this conflicting with all the exports in the file being
>>> GPLv2.0. Should this be fixed to change the license to GPLv2.0 only?
>>> Appreciate your help in this regard.
>>
>> Why ask a developer a legal question, don't you all have a whole huge
>> legal department who knows all of this type of thing really really well?
>>
>> Would you ask a programmer a medical question?
>>
>> That being said, think about trying to justify the existance of a BSD
>> licensed file trying to access gpl-only symbols, why in the world would
>> this even be a question?  Why have it dual licensed at all when I was
>> told that Intel was NOT going to do this anymore for any kernel code?
>>
> Thanks for your patience and clarification.
> We discovered the discrepancy while vetting the licenses in the files
> again. Something we should be a bit more careful about moving forward.
> Sorry for the trouble!

Indeed it's not our intention to use dual-licensing for debugfs at all.

Please treat this thread as a desire to be transparent with maintainers 
about a miss rather than an evil scheme to work around GPL.

Ranjani and I discovered the issue only a couple of hours ago while 
moving code around. I don't have any explanation for this other than a 
review oversight where we saw the EXPORT_SYMBOL_GPL and not the SPDX 
line. It's a mistake, not a feature.

I just checked the history and all the changes were made by Intel, 
except for your change "ASoC: SOF: no need to check return value of 
debugfs_create functions", and 2 minor other fixes for memory leaks.

We'll immediately change the license to GPLv2 only, move the code in a 
dedicated module that's GPLv2 only, and scan the rest of the 
Intel-contributed parts to make sure we don't have this mistake in other 
places.

Thanks
-Pierre


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
