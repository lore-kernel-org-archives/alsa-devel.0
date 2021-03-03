Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA75C433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 12:18:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5182864EBA
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 12:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182864EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A076C18D0;
	Wed,  3 Mar 2021 13:17:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A076C18D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614773909;
	bh=XhVfvTrU7egsvlogvQysseHi/Q+8JPIXn3xyMwczhkY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKvUALZ/QNsIFl2Y/mJHCWSBlKPgJMBNPL1drYC6rTs2Q/uNRQz5a0E45x2sU1BaU
	 /ruABRarTs0prI5kFwWlJBTX03jBIFRIKFeJgzNZBCyhUTDUaaoyELW8Nuef3AF+Xx
	 w+CJSWt3lx3AOioRFV+6ZgNfqg7NJ6xZ4PJBgHUs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A7F8F80257;
	Wed,  3 Mar 2021 13:17:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18BF0F8025E; Wed,  3 Mar 2021 13:17:38 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 539ADF8012D
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 13:17:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 539ADF8012D
Received: from [123.112.67.34] (helo=[192.168.0.106])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1lHQRZ-0003B7-VD; Wed, 03 Mar 2021 12:17:34 +0000
Subject: Re: [PATCH] ALSA: hda - bind headset buttons to the headphone jack
To: Takashi Iwai <tiwai@suse.de>
References: <20210303012346.3290-1-hui.wang@canonical.com>
 <s5hwnuod3pw.wl-tiwai@suse.de>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <9d590dae-785b-7ae3-a4a8-bf310fa25adf@canonical.com>
Date: Wed, 3 Mar 2021 20:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <s5hwnuod3pw.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
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


On 3/3/21 4:46 PM, Takashi Iwai wrote:
> On Wed, 03 Mar 2021 02:23:46 +0100,
> Hui Wang wrote:
>> With the HDA driver, if the headset buttons are supported, an audio
[snip]
>> +
>>   	jack->jack->button_state = report;
>>   }
> I think this part should be rather in hda_jack.c, e.g. create a function
> snd_hda_jack_set_button_state() and handle the redirection there.
> It's not good to change the content in jack->jack externally.

OK, got it. will change it.

Thanks.

>
> thanks,
>
> Takashi
