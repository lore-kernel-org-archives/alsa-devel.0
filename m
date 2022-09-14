Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE64CC6FA8A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Sep 2022 14:31:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4196B18DE;
	Wed, 14 Sep 2022 16:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4196B18DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663165896;
	bh=4QPfKCAQE7uQBIad8NxCzKt2MF6ByYArmqP3xPcF1lY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qP71qsOyQlNqxP3F7WhLWZnTLaWng7pNMRTZ56/ymzvRYUf0AAkEFSX0eD8W7DFM4
	 UhcIPivZH3NCezs1dox16k2bSYJk8d5BPDTrgl9dei3XpjvO5lwDqGguYXSftJPzPB
	 lXz0wlKWtywhE9fXNbL8axfxr2hPyCq+i5QV6eE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3FF1F8014B;
	Wed, 14 Sep 2022 16:30:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62BFBF8014E; Wed, 14 Sep 2022 16:30:43 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B013F800FE
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 16:30:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B013F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="P8DNNhIf"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDgIMw006022;
 Wed, 14 Sep 2022 09:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=+uvX3O/5+Bc1TjUh5LCmQLOyTTOb43kiT73lo8oCevU=;
 b=P8DNNhIfHhctFqBWEhN3b1+azzXVU/ZMu7cszWsKUVbMAgeWNLqD3YuxQAsKmtBiTmD4
 3cVipWj6IpKA8bz06ota/k42e+tcgc/hHwjUoE+vmUmF931F5/y3ESUvvSZPJEKKirk0
 zBF/wk42+ylipHwQr98uv5gd9fpmZm2v7KqdPC0Hl/eeN5hB8ruOIsQLEExPuIya515K
 icJrhYtIuUeiPI3sdw/p7rPNG3WovtJKSbckVO0zIxnGAV7XBh3CuqMM/24URDboi4kC
 rtHwqm4U/zdeT9uH9FOtay/9k9b5YafRkpXV/JlbeawIlnU4+jQy4YrgKbh3A5ZOYx2c YA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h4ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Sep 2022 09:30:34 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 09:30:32 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via
 Frontend Transport; Wed, 14 Sep 2022 09:30:32 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9795468;
 Wed, 14 Sep 2022 14:30:32 +0000 (UTC)
Message-ID: <5ab8f14d-8fa0-ea37-a664-88a0cff9b92f@opensource.cirrus.com>
Date: Wed, 14 Sep 2022 15:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/5] soundwire: cadence: Fix lost ATTACHED interrupts
 when enumerating
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
 <sanyog.r.kale@intel.com>
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
 <20220914120949.747951-5-rf@opensource.cirrus.com>
 <1b506127-f992-b554-e984-589dc46aa110@linux.intel.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <1b506127-f992-b554-e984-589dc46aa110@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bSpGVebz6QD1fUzgwdCR2e0xCkd219Ev
X-Proofpoint-ORIG-GUID: bSpGVebz6QD1fUzgwdCR2e0xCkd219Ev
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On 14/09/2022 14:48, Pierre-Louis Bossart wrote:
> 
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 245191d22ccd..2f131604d884 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>>   	u32 device0_status;
>>   	int retry_count = 0;
>>   
>> +	/*
>> +	 * Clear main interrupt first so we don't lose any assertions
>> +	 * the happen during this function.
> 
> typo: that happen?
> 

I hate typos.
