Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB76C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 12:03:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6198B206D4
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 12:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="afxxhEnP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="H1CM5bvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6198B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B736E1658;
	Fri, 15 May 2020 14:02:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B736E1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589544189;
	bh=Y7uB1bIleNW6mFx/+hFe9NbEEizMHc/2/XgSGrEcb88=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afxxhEnP4mygahqXQk37zrKZkc98oXVO0iMHh2uM9bvRxaws6RTvVmeQerXBfnENn
	 vgPPN8ch4hrMS9Nwk7OlZ2UrrI8p7c6QBmCbWwAMvGMyyo4Lim47eXm8W9VpqgvwaT
	 bXXY7SQXm+0wtrkTpQ0rNytGR+Hqpm/igOjnQOyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CFD7F800E3;
	Fri, 15 May 2020 14:02:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6593F80247; Fri, 15 May 2020 14:02:16 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BFBFF80101
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 14:02:09 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 17599A004B;
 Fri, 15 May 2020 14:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 17599A004B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1589544129; bh=BSPQw7ZsQTM9qcuNnNNGa3TUk61bcBxmr+5Zb7SXb3k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H1CM5bvnktpNfAz3IAga9bNh/b2OcwZBtSlsVek+Ha8mJPsdnpDNGE801xj1Pdu+g
 IIFKpDBjbeD8swsnCxKfR7+K++XN9kzm18xEUl/OtM9U4rM03tPINQBhjvFPCNHzwO
 17LkqcYiTTVRKQWLO+74MYTVT/6QMdTSUP5JXt0U=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 15 May 2020 14:01:57 +0200 (CEST)
Subject: Re: [PATCH] ALSA: pcm: fix incorrect hw_base increase
To: Takashi Iwai <tiwai@suse.de>
References: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
 <20200515070446.GA1226131@kroah.com>
 <BN6PR1101MB21327687327440F1DB7CB75F97BD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <ce215f76-89c3-3543-c6ed-bc9b81af50a0@perex.cz>
 <s5hk11dmqhn.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <6f98358d-99f1-3b54-ae1a-5e938d383c32@perex.cz>
Date: Fri, 15 May 2020 14:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5hk11dmqhn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 paulhsia <paulhsia@chromium.org>, "Lu, Brent" <brent.lu@intel.com>
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

Dne 15. 05. 20 v 12:39 Takashi Iwai napsal(a):
> On Fri, 15 May 2020 11:30:54 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 15. 05. 20 v 11:04 Lu, Brent napsal(a):
>>>>
>>>> Is this a bugfix needed for older kernels as well?  When did this issue show
>>>> up?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> It happens when DMA stop moving data from host to DSP/DAI for a long time
>>> (> half of buffer time). I know host driver should do something about it. But if
>>> not, the HWSYNC will keep increasing the hw_base and hw_ptr and confuses
>>> user space program.
>>
>> I'm afraid, but with this code, you turn off the hw_ptr jiffies
>> code. It would be better to fix the driver in this case (return the
>> updated / estimated DMA pointer, increase DMA buffer size etc.). This
>> "lag" is unacceptable.
> 
> The problem is obviously in the driver's side and it's best to be
> addressed there.  But, I think it's still worth to apply this change.
> 
> The hw_ptr jiffies check is performed basically in two places: one is
> snd_pcm_period_elapsed() call from ISR, and another is with the
> no_period_wakeup flag.  In both cases, it calculates the diff of
> jiffies from the previous update, and corrects the hw_ptr_base if that
> exceeds the threshold.
> 
> And the bug here is that the "previous" jiffies is kept as long as the
> hwptr itself is updated.  What we need is the correction of the base
> when it really has processed the period size; i.e. hwptr got the same
> value (with no_period_wakeup) and yet the jiffies diff is big.  For
> this check, it's correct to update hw_ptr_jiffies at each call no
> matter whether hwptr moved or not; we need to evaluate from the
> previous update, after all.
> 
> But I might overlook something.  Jaroslav, could you check it again?
> The jiffies check code is your black magic :)

I tried to imagine a negative impact for this hw_ptr_jiffies update when the 
DMA position is not updated from the driver and I haven't found any so far.

Let's apply this and we'll see in future :-)

And yes, the patch description should be improved (DMA ptr is not updated / 
streaming is inactive).

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> 
> thanks,
> 
> Takashi
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
