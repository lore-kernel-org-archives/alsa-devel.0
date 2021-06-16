Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE2C48BE6
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 07:03:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931A061246
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 07:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931A061246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75BF51676;
	Wed, 16 Jun 2021 09:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75BF51676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623827014;
	bh=QdYW/SlVnXBDJ0H4L+LE5HQKqOZ9ujdjs7140DqXkoY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZd0/FKLoTnwq4DOnwgBEWftIhnz8OBQeBbI0k4RkssmNzFZGEp7u3/eEcE6j4Auy
	 XPoO+j3kopMo7bpoXvrlR5TwMPsf3T9Ou90mH6LX6Ebb2C0MVXG7nOX2p/UYi6WmZP
	 tdNOJ4PexohkN7Rf+spZJFkl2VZT57kUKstUFfzw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A0ABF802E8;
	Wed, 16 Jun 2021 09:02:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51131F8028B; Wed, 16 Jun 2021 09:02:42 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0CF1F8028B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 09:02:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0CF1F8028B
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4bdk0Fcgz6wG7;
 Wed, 16 Jun 2021 14:59:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:02:31 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:02:31 +0800
Subject: Re: [PATCH -next] ALSA: fm801: Fix missing pci_release_regions() on
 error in snd_fm801_create()
To: Takashi Iwai <tiwai@suse.de>
References: <20210616025507.2120103-1-yangyingliang@huawei.com>
 <s5hfsxi1ewc.wl-tiwai@suse.de>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <80aeb5eb-f06e-4069-171c-ed8a84a15a69@huawei.com>
Date: Wed, 16 Jun 2021 15:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5hfsxi1ewc.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, broonie@kernel.org,
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


On 2021/6/16 14:50, Takashi Iwai wrote:
> On Wed, 16 Jun 2021 04:55:07 +0200,
> Yang Yingliang wrote:
>> Fix the missing pci_release_regions() before return
>> from snd_fm801_create() in the error handling case.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> pci_regions() is manated in pcim_release(), hence you don't need to
> call it explicitly.
OK.

Thanks,
Yang
>
>
> thanks,
>
> Takashi
> .
