Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353DEC43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:11:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60FD207EA
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WBE6wWuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60FD207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4175847;
	Thu, 10 Sep 2020 08:10:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4175847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599718288;
	bh=teOcE870TEDhGYL4dKl7ayfpQ4oyGiHH5r1H602fobQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBE6wWuUrffhY4JqaoyqysGArj/TQ6Nkk0FUQyc82m3t3nzAHi5DGMJmKDWemJMxp
	 6bv6ViNAptvvGonLQ2bpgmfETDdqMax2E7K44UK1VMODaPkmdrXHiqXzeRSvIwEse2
	 J3J5eDBI0V4aWh32z+6yjag5cve0pRB1v2yT85mM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D2D1F801F2;
	Thu, 10 Sep 2020 08:10:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0263F80264; Thu, 10 Sep 2020 08:10:36 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6B9BF8010E
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 08:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6B9BF8010E
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7035FF0881900A77EB36;
 Thu, 10 Sep 2020 14:10:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 10 Sep 2020 14:10:17 +0800
Subject: Re: [PATCH -next] soundwire: intel: Remove ununsed function
To: Vinod Koul <vkoul@kernel.org>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>
References: <20200909131531.31380-1-yuehaibing@huawei.com>
 <14a09132-d0ed-7129-73df-cbeb3154429b@linux.intel.com>
 <20200910055215.GP77521@vkoul-mobl>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <d93c14e6-c05f-8ccb-e122-1b2ea013be90@huawei.com>
Date: Thu, 10 Sep 2020 14:10:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200910055215.GP77521@vkoul-mobl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On 2020/9/10 13:52, Vinod Koul wrote:
> On 09-09-20, 08:46, Pierre-Louis Bossart wrote:
>>
>>
>> On 9/9/20 8:15 AM, YueHaibing wrote:
>>> If CONFIG_PM is not set, build warns:
>>>
>>> drivers/soundwire/intel.c:488:12: warning: 'intel_link_power_down' defined but not used [-Wunused-function]
>>>
>>> Move this to #ifdef block.
>>
>> Yes, thanks for the report, it's a valid issue, but maybe the fix is to add
>> __maybe_unused more consistently and remove the CONFIG_PM dependency.
>>
>> Vinod, what would you prefer?
> 
> __maybe_unused is the recommendation, it should be updated to use that

Ok， will respin.

> 
> Thanks
> 

