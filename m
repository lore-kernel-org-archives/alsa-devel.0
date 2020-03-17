Return-Path: <SRS0=KQif=5C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB2C10F29
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:26:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E262720714
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NRfG2iC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E262720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5744E17F9;
	Tue, 17 Mar 2020 15:25:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5744E17F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584455198;
	bh=LQ03HQGlVfKaxW/TWW5yUhbYIxxdLHFItUig4q7ZuX0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRfG2iC38c/AdOYrbY2S9ntsIJ4Qy2/6BMFdorg/RtTcygWSEM90LR0C2pBjq8hz+
	 TbkPXp3RU5tYChvLwWubGwUOA8KbyQZKVmx8PIbQTtO/gTRrjuTbgFllLCxHLtEwQ2
	 lCFMcf2FARXUqqsTOKn891LUagcdCkPf/p7HvNwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F4DEF800C0;
	Tue, 17 Mar 2020 15:25:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0728EF800CD; Tue, 17 Mar 2020 15:24:53 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD6FAF800CD
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2020 15:24:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD6FAF800CD
IronPort-SDR: 9ZPUPXPnIIRRyE590qPpedBbSfo+BcNLfcnznxx0x3tiVMaciA9H94O+DVoANbWnG1aLZ4mIEl
 BjeU8gXYazHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 07:24:47 -0700
IronPort-SDR: z6tRhruIKRbKwnps9QQqh/kGaQsiaTyf8oiJ8dlyOzVcUcsrY4SHRb4A2gd41wBHxfUDFy0ulP
 6FsHsJT5mGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; d="scan'208";a="247835629"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148])
 ([10.255.35.148])
 by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 07:24:44 -0700
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
 <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
 <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6dde3b32-a29a-3ac9-d95d-283f5b05e64a@linux.intel.com>
Date: Tue, 17 Mar 2020 08:19:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



On 3/17/20 8:04 AM, Srinivas Kandagatla wrote:
> 
> 
> On 17/03/2020 12:22, Pierre-Louis Bossart wrote:
>>
>> The change below would be an error case for Intel, so it's probably 
>> better if we go with your suggestion. You have a very specific state 
>> handling due to your power amps and it's probably better to keep it 
>> platform-specific.
> 
> Just trying to understand, why would it be error for Intel case?
> 
> IMO, If stream state is SDW_STREAM_ENABLED that also implicit that its 
> prepared too. Similar thing with SDW_STREAM_DEPREPARED.
> Isn't it?

the stream state is a scalar value, not a mask. The state machine only 
allows transition from CONFIGURED TO PREPARED or from DEPREPARED TO 
PREPARED, or DISABLED to PREPARED.
There is no allowed transition from ENABLED TO PREPARED, you have to go 
through the DISABLED state and make sure a bank switch occurred, and 
re-do a bank switch to prepare again.
