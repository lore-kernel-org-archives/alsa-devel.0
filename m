Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E492C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:44:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CD1206F0
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pyr7X6VS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 330A51657;
	Thu, 30 Jan 2020 00:43:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 330A51657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580341461;
	bh=1AZLP9aKm/4VjiGGnhXcqrrKxazfqnt27gR+1gTWOJQ=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pyr7X6VSLN3peqhL9nuVBYzfkZZ4YQkKCKiDYQiSxItoYfkhuIUqpy1JMv6iNbb0B
	 qOph9yhWak8R1r+2NZTScfVuf6GhaMHFWVQ/zMLPjfNyy+i5Nfdzexx0DWcr7CHIup
	 6pd+iewnJOV6o/xFN+8jrIBxfufY+n9By7/HTBsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98BB4F80122;
	Thu, 30 Jan 2020 00:43:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D09CF8021E; Thu, 30 Jan 2020 00:43:28 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04427F80122
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 00:43:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04427F80122
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,379,1574150400"; d="scan'208";a="252831298"
Received: from kjhudson-mobl1.amr.corp.intel.com (HELO [10.254.70.93])
 ([10.254.70.93])
 by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2020 15:43:20 -0800
To: sylvain.bertrand@gmail.com, alsa-devel@alsa-project.org
References: <20200129232340.GA23769@freedom>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fffaf462-fd7a-6d09-e808-21d94f883365@linux.intel.com>
Date: Wed, 29 Jan 2020 17:43:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129232340.GA23769@freedom>
Content-Language: en-US
Subject: Re: [alsa-devel] no period wakeup support
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



> Nowadays, is this reasonable to consider disabling the period wakeup as default
> instead of expecting period wakeup by default?

I'd say yes - it's been nearly 10 years since this capability was added, 
and it's quite common across HDaudio, Chrome, Android plaforms.

But considering this as a default doesn't mean it's available in 100% of 
the cases, you still you need to check that

a) the driver is capable of disabling the period wakeup
b) the driver is capable of providing a precise position outside of 
period elapsed events (usually marked with the INFO_BATCH capability).

alsa-lib gives you the means to query both cases.

Note that you also have the case where you cannot disable interrupts but 
can still use timer-based solutions (e.g. for USB audio).

Hope this helps
-Pierre

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
