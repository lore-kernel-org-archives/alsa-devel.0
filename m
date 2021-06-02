Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10740C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:20:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7860B613BA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7860B613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FE6A16DF;
	Wed,  2 Jun 2021 16:19:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FE6A16DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622643629;
	bh=Et8+3SmkB9mo2muFLruoiM69XWsfzWMOXz5Tg+eHKmk=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qA3QpCw825psUYrfyJj8kSVQGKP89fRHspZHEFTQzBlY3cO0X1fyjIVoNVmKGsuJ6
	 r5MCPLKJ6nGqI/ahhuz9ae15IuEjGg6usMAgVL2RC7Ft0wAFWwjTHr7Cr28OOTKMme
	 x5nyyt7IpuFv2DEL21mjfMIWV2+IkGzSZW1YFCNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A70EF802A9;
	Wed,  2 Jun 2021 16:19:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDBB6F80424; Wed,  2 Jun 2021 16:19:37 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A74A2F80103
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 16:19:24 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C304AA0042;
 Wed,  2 Jun 2021 16:19:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C304AA0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1622643562; bh=t6iwHzWxaZURGvRkNNG6PD03fsxL4O2Nu2eQKG2T8Tc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=n1Cn3L0XrZwFTsCJyIEPXafWyWLVRQuFfem59YOdeD51dXu8Z0CY8Vqbuuwvd3YT8
 pN7SQdm0Mof50fxryJwyRS2xPn0/gxhxCokpw/Q+NQXr1mz7krNXX94cBV6+wAOA3j
 2HUO/1g1Wqvem/g9DlafVtAYnHMvqJ1kkzp2kJHk=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  2 Jun 2021 16:19:13 +0200 (CEST)
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
To: Dongliang Mu <mudongliangabcd@gmail.com>, allen.lkml@gmail.com,
 alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>, tiwai@suse.com
References: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <5c3fbdf8-bfa3-a50e-edb9-81fbce84d9cb@perex.cz>
Date: Wed, 2 Jun 2021 16:19:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAD-N9QUDYbzkZXnDzf2P4b4Qk_kBQ_9ZVL3B4jhe9Xf2rgtpGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 02. 06. 21 15:18, Dongliang Mu wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit: 5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
>> git tree: upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+d102fa...@syzkaller.appspotmail.com
>>
>> ================================================================================
>> UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
>> shift exponent 105 is too large for 32-bit type 'int'
>> CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>> __dump_stack lib/dump_stack.c:79 [inline]
>> dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>> ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>> __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
>> snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
>>
>> snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525
> 
> The root cause of this bug is in the snd_timer_notify1 [1]. At the end
> of this function, it calls "ts->ccallback(ts, event + 100, &tstamp,
> resolution)".
> 
> Here the variable event is 5. It adds 100 and is passed as 2nd
> argument of snd_timer_user_ccallback.
> 
>>From the variable naming, the 2nd argument should an event, and in the
> range of event enumeration. In fact, 105 (event + 100) is out of this
> range. I don't quite understand the meaning of adding 100. Any thought
> here?

It seems that the original intent was to move the event to the M... events:

     SNDRV_TIMER_EVENT_MSTART = SNDRV_TIMER_EVENT_START + 10,

So the added value should be 10 which should not break the shift range (8
/resume/ + 10 = 18).

					Jaroslav

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/timer.c?id=5ff2756afde08b266fbb673849899fec694f39f1#n497
> 
> --
> My best regards to you.
> 
>      No System Is Safe!
>      Dongliang Mu
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
