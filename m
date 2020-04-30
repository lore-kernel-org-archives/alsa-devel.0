Return-Path: <SRS0=nm6W=6O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73638C83001
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 04:38:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37DF21D7E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2020 04:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jTbQQeYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37DF21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 395DC1669;
	Thu, 30 Apr 2020 06:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 395DC1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588221502;
	bh=XSXNcCr0terLDfi5inwDmW5oYC/XTGW3L/60DeL5lcI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jTbQQeYQ9eKfIEV+Jwm8t1or1XN6JnvVoFjWU0MS9ZrztRc/3jjk4pbjpAoiU6U4s
	 HWJDWeBUfDjD4Z0czy3MRlMXaxR/iPd/SxW8lC2wryB1zx0aV5fydJ6IG1SpzdRpht
	 l4a4lgUimLebO3r0iLfRD2ZDtsLP/Ern/Df9g2h8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C2DCF80123;
	Thu, 30 Apr 2020 06:37:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1761F801DB; Thu, 30 Apr 2020 06:37:29 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70910F800E5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2020 06:37:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70910F800E5
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E51716A03AB502A31410;
 Thu, 30 Apr 2020 12:37:16 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 30 Apr 2020 12:37:08 +0800
Subject: Re: [PATCH] sound:hdmi:fix without unlocked before return
To: Takashi Iwai <tiwai@suse.de>
References: <1587907042-694161-1-git-send-email-wubo40@huawei.com>
 <s5hees6lpja.wl-tiwai@suse.de>
From: Wu Bo <wubo40@huawei.com>
Message-ID: <42f1f263-6f96-e1f2-6ecc-5a16ca6c828b@huawei.com>
Date: Thu, 30 Apr 2020 12:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <s5hees6lpja.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Cc: pierre-louis.bossart@linux.intel.com, nmahale@nvidia.com,
 kai.vehmanen@linux.intel.com, aplattner@nvidia.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, linfeilong@huawei.com,
 libin.yang@linux.intel.com, alsa-devel@alsa-project.org,
 liuzhiqiang26@huawei.com
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

On 2020/4/29 15:27, Takashi Iwai wrote:
> On Sun, 26 Apr 2020 15:17:22 +0200,
> Wu Bo wrote:
>>
>> Fix the following coccicheck warning:
>> sound/pci/hda/patch_hdmi.c:1852:2-8: preceding lock on line 1846
>>
>> After add sanity check to pass klockwork check,
>> The spdif_mutex should be unlock before return true
>> in check_non_pcm_per_cvt().
>>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
> 
> Applied now with the correction of subject and Fixes tag as well as
> Cc-to-stable tag.
> 
> 
> thanks,
> 
> Takashi
> 
> .
> 

Thank you, I am sorry to forget to modify the V2 Patch version in time.

thanks,
Wu Bo




