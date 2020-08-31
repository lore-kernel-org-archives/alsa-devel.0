Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A0C433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:01:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DA0207EA
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E3+ztdVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DA0207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 888D81783;
	Mon, 31 Aug 2020 17:01:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 888D81783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598886113;
	bh=t9fT3ezxFXio2s9cN8+54mllu3tdDiGxd9T2r4fVu+c=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3+ztdVfplE48yxnQDtrGjwxYR1PZ3a6AwSaCWa5+SNaqQ2BMAhIHQCqMJeePrFdw
	 pfHn8PMVK1QMDwcKbAwcicv7oafgQhv24tteEqz67y9IOPTb/Lc0oT7mV4STK7vJ//
	 04nzEyxEw1GUzimVnN1XA3ux/dwAt6JWq5VjhJDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA789F80058;
	Mon, 31 Aug 2020 17:01:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43072F80212; Mon, 31 Aug 2020 17:01:01 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8259F80058
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 17:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8259F80058
IronPort-SDR: JbOlB/1dZB7E6ZFK08nGz3Ngle5GwTa4oBwTV8gEqryXz2v/co3GbUbd+SAmLf3N98m7KW7yNX
 QZqDVKLrCPNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="156988445"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="156988445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 08:00:40 -0700
IronPort-SDR: Xf7Ruy1n/EQULzZcCmT3Hl1q4KHnSvkPJCFtwKTWmWxlyRTYQjoXLlYiAnnA4rmE49scqihQhN
 Cuft9anWGnYg==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; d="scan'208";a="501370097"
Received: from jaeikcho-mobl.amr.corp.intel.com (HELO [10.213.165.6])
 ([10.213.165.6])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 08:00:39 -0700
Subject: Re: [PATCH 1/9] soundwire: define and use addr bit masks
To: Vinod Koul <vkoul@kernel.org>
References: <20200828072101.3781956-1-vkoul@kernel.org>
 <20200828072101.3781956-2-vkoul@kernel.org>
 <9ae0f448-afb8-bcd6-b494-a7014ed88c11@linux.intel.com>
 <20200829105443.GA2639@vkoul-mobl>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6edad0b5-c76b-a602-4ee4-18a3ec88a857@linux.intel.com>
Date: Mon, 31 Aug 2020 10:00:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829105443.GA2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
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




>> Patch 9 also introduces conflicts with the multi-link code (fix in patch2),
>> so would you mind if we go first with the multi-link code, or defer patch9
>> for now?
> 
> We can fix the series required while applying..

It's not an issue with git, it's rather that this series is quite 
invasive and if you add it first it becomes quite hard to bisect/debug. 
In terms of risk management, it's safer to isolate contributions by 
groups and not mix them.

