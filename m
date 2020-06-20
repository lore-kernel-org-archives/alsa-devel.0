Return-Path: <SRS0=HPKo=AB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B5C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:19:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB6A23433
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Jun 2020 04:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YFSBI6iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6A23433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A2C4168B;
	Sat, 20 Jun 2020 06:18:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A2C4168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592626762;
	bh=0QVrN6hvzDxOuooR0O8jeLHOxGUxDWKPb+c4mVcD1R4=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFSBI6iR+DDUhMcJsWqI814GgPhFhwbpvM5o8RFl1cRs71vAcs2PvZGkDKUwRlBQA
	 w7mnV7J12ALq3S/jPZtWP8PwPy1Ot9hs383eTq0+lkCYiFLTKl1aVaiOPOHAyHX2VZ
	 T5UA35erQwnDcPr86iqVM3d/EwqkVC+EQidW/a2A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C008F80162;
	Sat, 20 Jun 2020 06:18:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7000AF80171; Sat, 20 Jun 2020 06:18:29 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE8BEF8015F
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2020 06:18:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE8BEF8015F
Received: from [123.112.103.108] (helo=[192.168.2.109])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1jmUxO-0000wv-8s; Sat, 20 Jun 2020 04:18:18 +0000
Subject: Re: How to populate required string as audio endpoint name in gnome
 audio devices tab
To: Jaroslav Kysela <perex@perex.cz>,
 "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <7c9bdd7c-efe9-c37c-3fa6-a6f611c43fc3@amd.com>
 <ec8c1c5a-a169-8d9c-c897-2bd9ed6593d3@perex.cz>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <d8224137-d778-32dc-7723-416d9d09822e@canonical.com>
Date: Sat, 20 Jun 2020 12:18:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ec8c1c5a-a169-8d9c-c897-2bd9ed6593d3@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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


On 2020/6/17 下午7:21, Jaroslav Kysela wrote:
> Dne 17. 06. 20 v 7:47 Mukunda,Vijendar napsal(a):
>> Renoir platform has onboard dmic + south bridge HD Audio endpoint 
>> support.
>> For onboard Dmic, Audio endpoint name is populated as "Analog Input"
>> in Audio input devices.
>> How can we populate name as "Internal Mic" or "Dmic" in audio input
>> devices tab  in sound settings?
>>
>> Alsa info link: https://pastebin.ubuntu.com/p/4kprhDZYbg/
>> Pluse audio info output: https://pastebin.ubuntu.com/p/sdx9Xs234C/
>
> It's question for pulseaudio. For the legacy ALSA code in PA, you need 
> to create profile, mixer path and udev rules. The probe mechanism used 
> in PA looks for the volume controls and path switches (kcontrol) API 
> to determine the device name. If not found, the generic name is used.
>
> It's better to finish the UCM support for this hardware:
>
> https://github.com/alsa-project/alsa-ucm-conf/issues/30

I just added a comment on the issues/30.

So far the biggest issue is how to make the ucm only apply to machines 
with renoir audio and let those ucm not affect other machines.

Thanks,

Hui.

>
>                     Jaroslav
>
>>
>> Thanks,
>> Vijendar
>>
>
>
