Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403A4C33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:51:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0E32072B
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UJ0xU7bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0E32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 105101827;
	Tue, 14 Jan 2020 18:50:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 105101827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579024262;
	bh=RTp24YIhevbFYN7ogsrIxfqtyusAfgLH5Lvy9AaB6xo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJ0xU7bmDE05wRgJvIbJej8Zb8wm+vMaT5K6zzaBN4m/frjR2M+sqKknGDBYICO7l
	 uh+mst5UdgS7P80SsMPVVgOeUdRGk93d2+gwau6q0yMJBBrjPYei00zDxKe2uS+kNP
	 dkYxsTMGKkfyrsmS4Vi0jAySpBNXbIbcaLu8JwIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BCBAF8023E;
	Tue, 14 Jan 2020 18:48:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07128F8023E; Tue, 14 Jan 2020 18:48:30 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F39AF8014E
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 18:48:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F39AF8014E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 09:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; d="scan'208";a="225285567"
Received: from snathamg-mobl.amr.corp.intel.com (HELO [10.252.136.159])
 ([10.252.136.159])
 by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 09:48:24 -0800
To: Vinod Koul <vkoul@kernel.org>
References: <20200113225637.17313-1-pierre-louis.bossart@linux.intel.com>
 <20200114063738.GG2818@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0f53a197-bd2d-a181-b39c-5ebe99458eac@linux.intel.com>
Date: Tue, 14 Jan 2020 10:10:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114063738.GG2818@vkoul-mobl>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: bus: fix device number leak on
 errors
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



On 1/14/20 12:37 AM, Vinod Koul wrote:
> On 13-01-20, 16:56, Pierre-Louis Bossart wrote:
>> If the programming of the dev_number fails due to an IO error, a new
>> device_number will be assigned, resulting in a leak.
>>
>> Make sure we only assign a device_number once per Slave device.
> 
> Although I am not sure if this would be a leak, we assign a new num and
> old number should have gotten recycled as they would be unattached
> status.

When you program the device number and it fails, there is still a 
Device0 reporting as attached, so you will loop and try to assign a new 
device number. In this case there is never a transition to UNATTACHED, 
the Slave remains ATTACHED as Device0 until the enumeration succeed with 
a successful non-zero device number.

This only happened to us w/ early prototypes where the PCB routing was 
questionable and the speed too high, but still it's useful to keep this 
device number constant

> Anyway this is good improvement as it helps to debug having same
> dev_num, so Applied, thanks

Thanks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
