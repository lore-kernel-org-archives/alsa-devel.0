Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DACC54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:16:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67DD20575
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MNe5OwsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67DD20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C1151688;
	Mon, 27 Apr 2020 13:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C1151688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587986205;
	bh=dDwbsp6BvlrOvRlHxxGQvoS3XYCKKUWzJbEaR2yjDVY=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNe5OwsF5LYy/78J7Ht3ilnw9InQgOKAJAafpo2q6c9nlLIjcG3bRHlUA+hUK2ye8
	 77H9bpWT3mqTqQj4PoQ7Y9e/7Ss9GbhKf4C2Ch0tclRqeuwYhZluylXFtiY4OY5Q87
	 AvPISSSIaf6znT53aREVTKxMQFEL3dFymIr0lxZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62ED8F8023E;
	Mon, 27 Apr 2020 13:15:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E88ADF80245; Mon, 27 Apr 2020 13:15:07 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A645F8022B
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 13:15:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A645F8022B
IronPort-SDR: StmrW5RcaPL9KQM9ToIu8t9tWEPyc3FxphRkvBqQMuIZkfUjHD1NJrB+BzFpidKCXcIoZIcWDX
 Hk6BhTfCGxkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 04:15:00 -0700
IronPort-SDR: haRhNDm6JBrfLvptd7XU3J6R22wAs4I3mDzr4BNt38AFOwqzBOYtT93I6CsbuZvURNungHKov8
 IbsLRWEHEcfA==
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
 d="scan'208,217";a="247384575"
Received: from mgorski-mobl.ger.corp.intel.com (HELO [10.135.60.246])
 ([10.135.60.246])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 04:14:59 -0700
Subject: Re: [PATCH v4 2/3] ASoC: Intel: Multiple I/O PCM format support for
 pipe
To: alsa-devel@alsa-project.org
References: <20200424132002.3850-1-mateusz.gorski@linux.intel.com>
 <20200424132002.3850-3-mateusz.gorski@linux.intel.com>
 <57f7b40e-a075-ce2f-917b-cf6f2a198f33@linux.intel.com>
From: "Gorski, Mateusz" <mateusz.gorski@linux.intel.com>
Message-ID: <237a621b-4326-328f-ed68-05a66cc77cd6@linux.intel.com>
Date: Mon, 27 Apr 2020 13:14:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <57f7b40e-a075-ce2f-917b-cf6f2a198f33@linux.intel.com>
Content-Language: pl
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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


>> +    list_for_each_entry(ppl, &skl->ppl_list, node) {
>> +        if (ppl->pipe->ppl_id == *pipe_id) {
>> +            pipe = ppl->pipe;
>> +            break;
>> +            }
>> +        }
>
> is there an alignment issue here or just a diff illusion?


There was, changed in v5.


>
> You also have a number of other alignment/style issues reported by 
> checkpatch.pl
>
I have only validated with standard chechpatch.pl settings, scanned with 
*--strict *and addressed all warnings in patchset v5.

Thanks,
Mateusz

