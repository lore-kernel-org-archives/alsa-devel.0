Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA091C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 13:01:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A969206D5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 13:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UL3Gj7hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A969206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A26EA1881;
	Fri, 22 May 2020 15:00:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A26EA1881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590152459;
	bh=Ng0r9kGKKGX7g1ff8TLTXN+dTQ1IvLdkOrS1Hw7VSUE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UL3Gj7hEcmIzTYhQRqFIckbbzegyaVJWmwofSun8uFf3436tiNOhULfZDqdEhzlPY
	 Ug7OPSomF6wpL899wBBE2pOdLMTPczM/b2yYgkXRsEm+U2T895MtPDIjpOh9z9sXJi
	 8ACPcC6eSN6uMct4a/Wqteu55sQb2tB7gh3TmISM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16AF5F801DA;
	Fri, 22 May 2020 15:00:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39231F801F9; Fri, 22 May 2020 15:00:07 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DE3BF80140
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 14:59:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DE3BF80140
Received: from [123.114.63.221] (helo=[192.168.2.109])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jc7HH-0005aH-IB; Fri, 22 May 2020 12:59:56 +0000
Subject: Re: [PATCH v2] ASoC: amd: put off registering mach platform_dev to
 avoid -517 err
To: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
 Mark Brown <broonie@kernel.org>
References: <20200522081738.11636-1-hui.wang@canonical.com>
 <20200522110811.GB5801@sirena.org.uk>
 <DM6PR12MB2633D541378EB715AC18531C97B40@DM6PR12MB2633.namprd12.prod.outlook.com>
 <20200522112228.GD5801@sirena.org.uk>
 <DM6PR12MB26337FD48A99D14814EB32F097B40@DM6PR12MB2633.namprd12.prod.outlook.com>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <2285006c-388c-810f-c1ac-ef76ab2319bb@canonical.com>
Date: Fri, 22 May 2020 20:59:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB26337FD48A99D14814EB32F097B40@DM6PR12MB2633.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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


On 2020/5/22 下午7:28, Mukunda, Vijendar wrote:
>
>> -----Original Message-----
>> From: Mark Brown <broonie@kernel.org>
>> Sent: Friday, May 22, 2020 4:52 PM
>> To: Mukunda, Vijendar <Vijendar.Mukunda@amd.com>
>> Cc: Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org
>> Subject: Re: [PATCH v2] ASoC: amd: put off registering mach platform_dev to
>> avoid -517 err
>>
>> On Fri, May 22, 2020 at 11:13:43AM +0000, Mukunda, Vijendar wrote:
>>
>>> Does sound card registration failure at boot time due to modules loading
>> order can be considered as bug ?
>>
>> No, this is totally normal.  If it failed to bind ever then that'd be a
>> problem but this is just deferring.
> In that case, we don't need this work around I guess.
> At maximum during boot time, we may see few sound card registration failure logs,
> Which is normal.
>
> With this change, our concept of ACP parent device which will create platform devices
> for DMA driver, Generic DMIC driver and Machine driver will be changed.
> We implemented same design for Raven I2S driver as well which got productized.
>
OK, got it.  It doesn't affect the sound function anyway.
