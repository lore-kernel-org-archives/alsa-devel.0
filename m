Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B568BC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 15:07:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BBC60F11
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 15:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0BBC60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ED5B167D;
	Thu, 19 Aug 2021 17:07:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ED5B167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629385672;
	bh=H7t/AGHEZad16IX+EUvcIoHHT8lDGp9OXXYWEgg+rdk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3YoMJkxn7U0SqYICSCgjEc9SdT5T/Du94lDs/xonNuyC7VgLdfJgywwF5yfaJ5T7
	 0t2gAW9VHwT113iY9z6jhR+Lq5MYtRoUv9r2cPpp9mTZ4ZpOWaBPHeZ5zgAk0SpSIp
	 rGm8pXT4k1zuqQ+NdvCClb2DykqKG/rnfxDyP0eQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A862AF801EC;
	Thu, 19 Aug 2021 17:07:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BD6EF8026D; Thu, 19 Aug 2021 17:07:00 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98537F800CC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 17:06:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98537F800CC
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="302160646"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; d="scan'208";a="302160646"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2021 08:06:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; d="scan'208";a="522471382"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.19.151])
 ([10.213.19.151])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2021 08:06:50 -0700
Subject: Re: [PATCH v2] ASoC: Intel: Fix platform ID matching for
 kbl_da7219_max98373
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Lukasz Majczak <lma@semihalf.com>
References: <20210819082414.39497-1-lma@semihalf.com>
 <87736cce-a96f-064e-6d60-71645ba46f13@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <aeb40985-140f-b013-f368-778ad33fc7d0@intel.com>
Date: Thu, 19 Aug 2021 17:06:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87736cce-a96f-064e-6d60-71645ba46f13@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org,
 upstream@semihalf.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On 2021-08-19 4:30 PM, Pierre-Louis Bossart wrote:
> On 8/19/21 3:24 AM, Lukasz Majczak wrote:
>> Sparse warnings triggered truncating the IDs of some platform device
>> tables. Unfortunately kbl_da7219_max98373 was also truncated.
>> This patch is reverting the original ID.
>> Tested on Atlas chromebook.
> 
> Instead of reverting, how about changing the remaining occurrences of
> the old name in the machine driver?
> 
> sound/soc/intel/boards/kbl_da7219_max98927.c:   if (!strcmp(pdev->name,
> "kbl_da7219_max98373") ||
> sound/soc/intel/boards/kbl_da7219_max98927.c:           .name =
> "kbl_da7219_max98373",

Mentioned by 'Fixes' tag patch clearly introduced regression. If we are 
to update any name-fields, it's better to have a fresh start and update 
all the boards in one-go than doing so separately.

Apart from that, Maxim codecs go by the name of 'max' in 
sound/soc/codecs/. It's more intuitive to have equivalent shortcut used 
in board's name.


Regards,
Czarek
