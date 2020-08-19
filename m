Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A2C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:22:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA8C20897
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mroxzPJr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gB2Iq8Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA8C20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96F42185A;
	Wed, 19 Aug 2020 17:22:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96F42185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597850575;
	bh=itTcJESFKZsuq96JipoP5mkfxoqgYnRhb6OmzQlwLoA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mroxzPJrwPFklkPAnhoIvLoARTRLC8NlZ8f7rbsdWgYq4QOAJY0anI970+FUGAqDv
	 VeUZfefOlsU3GLt8gApD00BCxUdZ61Vsyt1Dk2oLV5MYjTONozGeB45E240tTElgkX
	 OOA5fy6lZ6cfACJQ6JzBqbH4gMmp413KSTn6LfnQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 334AFF80216;
	Wed, 19 Aug 2020 17:22:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 665B2F80218; Wed, 19 Aug 2020 17:22:03 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EABB2F800D3
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 17:21:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EABB2F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="gB2Iq8Og"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f3d437e0000>; Wed, 19 Aug 2020 08:21:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 19 Aug 2020 08:21:48 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 19 Aug 2020 08:21:48 -0700
Received: from [10.25.96.247] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 15:21:42 +0000
Subject: Re: [PATCH] ALSA: hda: avoid reset of sdo_limit
To: Takashi Iwai <tiwai@suse.de>
References: <1597848273-25813-1-git-send-email-spujar@nvidia.com>
 <s5hmu2qhele.wl-tiwai@suse.de>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <376cc1ba-d781-e319-e68d-99a8e8d8bbdf@nvidia.com>
Date: Wed, 19 Aug 2020 20:51:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5hmu2qhele.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1597850495; bh=nIVmZYWAVKJjAz2WTV5Pq/8CeO7HreVwdVvgXeBqcqQ=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=gB2Iq8OgTJba+HjCDFen9seVB6EsqqodAgImai9n1WYGZnkdNwRCo0Rf3AsaRpS61
 aaGKREz3fC9avdNZZ3HczjXxHdjBNDHKX1XbsE1DJl+FFspBGTLMJ9QIQ6BqGhHFiF
 Hi0Ir7lbXWo0ZBhOntTMy7B3afg89wg3nx601v4w005hPprSJwpLmP6G8zPPp/K7D+
 jwQ5iNmN1HPsmgVZCWiCtxAF65Uzk2OPfVQdLIze5ZEfBDSS1uxF5Y2lfNk6PNqdh+
 XMd0eLGin+1nCmksg0Mh8ZyiuYT1f4ZzvYAkqNpiqLDUW7F06ZSOFYV2jTfNwYwMIP
 3+SiXt5PWn4gg==
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, yang.jie@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, stable@vger.kernel.org, tiwai@suse.com
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


On 8/19/2020 8:23 PM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 19 Aug 2020 16:44:33 +0200,
> Sameer Pujar wrote:
>> By default 'sdo_limit' is initialized with a default value of '8'
>> as per spec. This is overridden in cases where a different value is
>> required. However this is getting reset when snd_hdac_bus_init_chip()
>> is called again, which happens during runtime PM cycle. Avoid reset
>> by not initializing to default value everytime.
>>
>> Fixes: 67ae482a59e9 ("ALSA: hda: add member to store ratio for stripe control")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> How about to move the default sdo_limit setup into snd_hdac_bus_init()
> instead?  That's the place to be called only once.

A better choice. Thanks for the suggestion. Will publish v2.

>
>
> thanks,
>
> Takashi
>
>
>> ---
>>   sound/hda/hdac_controller.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
>> index 011b17c..0e26e96 100644
>> --- a/sound/hda/hdac_controller.c
>> +++ b/sound/hda/hdac_controller.c
>> @@ -538,7 +538,8 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
>>         *   { ((num_channels * bits_per_sample * rate/48000) /
>>         *      number of SDOs) >= 8 }
>>         */
>> -     bus->sdo_limit = 8;
>> +     if (!bus->sdo_limit)
>> +             bus->sdo_limit = 8;
>>
>>        return true;
>>   }
>> --
>> 2.7.4
>>
