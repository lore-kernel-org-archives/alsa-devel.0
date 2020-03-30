Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA0C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:11:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DDB206F5
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qVTw6pGj";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="QqknZPDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DDB206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D57E315F2;
	Mon, 30 Mar 2020 17:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D57E315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585581061;
	bh=FfRfXzWYzMKwJR6XTEY/rt9DsO1w3UGh6QW57dwcMPo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVTw6pGjI103x0mqtDiiMjDlZbJtnFupLgR++AlaLjGbTeQQEf0/GvzGW1xnbJEm/
	 1cYryIaUCuB58mUTmnWI7L5cJjmmXXpenkub0s867HNwxKbAjkj2nKIU/eWlEUg9du
	 QJ8p/gZiZbXnER78rS71N2co7gS24OV/qtJy/aag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56F43F80145;
	Mon, 30 Mar 2020 17:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82271F80148; Mon, 30 Mar 2020 17:10:10 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B66BF8010C
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 17:10:03 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9B641A003F;
 Mon, 30 Mar 2020 17:10:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9B641A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1585581002; bh=lDQaoTw36TuU0wkJwUqy/F3pRUoc9FKsb/eAuSgylmE=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=QqknZPDG0BUgOQaH826PdKedkSOHqA9oQP2mHg8nD3opA3AFN0W05qApadBBauneJ
 FI2pXA/tgn2ERA46i+wy4FuWJYTaVf5Nc2UxaQBQuLcYLuo3oHkak3AFJ/SZy2em/d
 /I/xssM1yVBlA9tbUDkOCU0tj41xPT7/yFn+7H6g=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 30 Mar 2020 17:09:59 +0200 (CEST)
Subject: Re: Functionality of pcm_notify in snd-aloop?
To: Pavel Hofman <pavel.hofman@ivitera.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <b4af9071-f8d7-5b47-4d7a-c5743bd67394@ivitera.com>
 <61d837f1-de1a-7aa6-ca8f-d0cfaa36ea69@perex.cz>
 <28a05a44-55bf-1831-aa3c-875e0499caea@ivitera.com>
 <28063dd1-71ab-a313-04b8-f4d97312b1b5@ivitera.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a325c165-5ced-618b-0b71-c0c4381473a1@perex.cz>
Date: Mon, 30 Mar 2020 17:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <28063dd1-71ab-a313-04b8-f4d97312b1b5@ivitera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>
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

Dne 30. 03. 20 v 16:43 Pavel Hofman napsal(a):
> 
> Dne 26. 03. 20 v 18:59 Pavel Hofman napsal(a):
>> Dne 26. 03. 20 v 18:44 Jaroslav Kysela napsal(a):
>>> Dne 26. 03. 20 v 18:19 Pavel Hofman napsal(a):
>>>> Hi,
>>>>
>>>> Please how is the module params pcm_notify supposed to be used, to do
>>>> what the documentation says: Break capture when PCM format/rate/channels
>>>> changes?
>>>>
>>>> Breaking capture side operation when the playback side changes the
>>>> params is very useful, but I cannot find a way to use this param
>>>> properly. When the capture side is open, the playback side cannot use a
>>>> different parameter than the one currently used by the capture side (the
>>>> configuration space is limited)
>>>
>>> Really? Then it's a bug introduced by the last changes.
>>>
>>> If you look to sources:
>>>
>>>        if (get_notify(dpcm))
>>>                  runtime->hw = loopback_pcm_hardware;
>>>          else
>>>                  runtime->hw = cable->hw;
>>>
>>> And:
>>>
>>>        if (!(cable->valid & ~(1 << substream->stream)) ||
>>>              (get_setup(dpcm)->notify &&
>>>               substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
>>>                  params_change(substream);
>>>
>>> So the functionality should be there.
>>
>> I am using older kernels (4.15 and 3.16), but this is an old functionality.
>>
>> modprobe snd-aloop pcm_substreams=1 pcm_notify=1,1
>>
> 
> Please is there any way to solve this issue? Thanks a lot for your patience.

I can reproduce this. It appears that the driver should be fixed, but I don't 
have a solution at the moment.

It seems that 898dfe4687f460ba337a01c11549f87269a13fa2 from Takashi broke this 
functionality (tied the cable parameters more strictly, so the playback cannot 
set freely own parameters for the pcm_notify=1 case). We need to find another 
way to detach capture stream in this case.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
