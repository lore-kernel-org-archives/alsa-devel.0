Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061FCC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 13:43:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D03B22D57
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D03B22D57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9D061EF3;
	Fri, 22 Jan 2021 14:42:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9D061EF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611323007;
	bh=9hYF6dxTusHfKK2vWWh6bslJqauNeT872D2zh+XrtsY=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTuunFfRQaTFqiLsgnj1Z2yYtLUdVpczkQMcsjXnIivgQV7ks5SBGxRej9ZjJPdyk
	 NfwbqRVzW5F+Ce6KnXoxeH+mRPrtDIb4elN/tu3JoftFAvlh0jB0/4EHKeVsVB9ZZP
	 zpkTMzoHbY4gK6lzPQK0TdzFCKG6NsuU+XMcVDLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73970F8016E;
	Fri, 22 Jan 2021 14:42:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95EB4F8019B; Fri, 22 Jan 2021 14:42:35 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A29CF8015B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 14:42:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A29CF8015B
Received: from [123.112.70.0] (helo=[192.168.0.106])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1l2who-0001F6-FR; Fri, 22 Jan 2021 13:42:28 +0000
Subject: Re: [RFC][PATCH v5 1/2] alsa: jack: implement software jack injection
 via debugfs
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
 tiwai@suse.de, kai.vehmanen@linux.intel.com
References: <20210122082144.16186-1-hui.wang@canonical.com>
 <20210122082144.16186-2-hui.wang@canonical.com>
 <c639b7df-d785-892b-1654-af5c8829ed52@perex.cz>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <69c0ba78-91f2-efbb-2158-5b66e060dfed@canonical.com>
Date: Fri, 22 Jan 2021 21:41:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c639b7df-d785-892b-1654-af5c8829ed52@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

On 1/22/21 4:40 PM, Jaroslav Kysela wrote:
> Dne 22. 01. 21 v 9:21 Hui Wang napsal(a):
>
>> +	len = scnprintf(buf, 256, "0x%04x", mask_bits);
> Use sizeof(buf) on all appropriate places. Also never use user space 'count'
> variable for the stack buffer size.
>
> 				Jaroslav

Oh, right, will use sizeof(buf).  Will not use 'count' for stack buffer 
size.

Thanks,

Hui.

>
