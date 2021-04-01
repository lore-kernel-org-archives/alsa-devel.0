Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F993C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:05:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE70861373
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE70861373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59A2C16B3;
	Thu,  1 Apr 2021 18:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59A2C16B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617293136;
	bh=n/ZTw3r8lcj8v+s6jd2H77pV5wwh7Ptl4fH/3kKnttA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRbhyfnuzcGKTIthv+YZm/uupR7rssrVaUKumbbSNpbW4ixEH9bB0Lufj7gBohevB
	 xkDpHEMjlhxlWOhxN+7Qi9/hMG5WAQSig5IJHb3gCix6o/sPzBhWJQDLsQEua+Fjot
	 P8VnpiEu1Y6ULn8yP4qFjFC7iafR/O82HOY2bR6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6F62F8026F;
	Thu,  1 Apr 2021 18:03:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDF61F802E3; Thu,  1 Apr 2021 18:03:55 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B87B3F80240
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 18:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B87B3F80240
IronPort-SDR: xSMWgCU8WJECSziuPszJTXdQo/k9VZWbrbCKL+ic84bCI/GRt1SlGRtmJYUVQjuGButODjnzc2
 wd7nNeb3MBJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171692989"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="171692989"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 09:03:23 -0700
IronPort-SDR: 4QbDotXZHHyUF/mrZZU6rz0IbZ67UA7GraB1G+XBmuOpxgxG6yCnqIzxdEruyJ/dy5KQHEcu7x
 1keblEV6B3zA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="439265765"
Received: from mooreale-mobl.amr.corp.intel.com (HELO [10.255.229.43])
 ([10.255.229.43])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 09:03:22 -0700
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
Date: Thu, 1 Apr 2021 09:36:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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



On 4/1/21 4:00 AM, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.

Out of curiosity, do you actually need to do a check in the read case as 
well?

The commit message talks about writes getting dropped, is the opposite 
also a problem?

