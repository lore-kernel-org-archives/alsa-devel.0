Return-Path: <SRS0=nSv5=DG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F9C4727C
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:28:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E297208B8
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OKSCY8H3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="3UGEO42K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E297208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D58417F5;
	Tue, 29 Sep 2020 19:27:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D58417F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601400514;
	bh=P842+RFPgFF5nmFPEndiFv5PJHNTd+muisa9d1t0CR4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OKSCY8H3o1mTT53M0K6giALKtrAg1MOWrbGWlFh4qZuewaMV1QrcxTJ997kF12SD2
	 +n+0zcnRMAo6SOQ31k0ie6+urdcU0n5hHQpU1HV35qLLRFW3ADyBdG33LwrAIeQutI
	 1yeq2hcCk2RDISQpGEkl+PJXg+FNnahiG9vGjNUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3DFEF801DB;
	Tue, 29 Sep 2020 19:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4617F80115; Tue, 29 Sep 2020 19:27:41 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C251F80115
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 19:27:32 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4AA73A003F;
 Tue, 29 Sep 2020 19:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4AA73A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1601400450; bh=SjT0V3GugGLJqqCHVfA+48hIcrhHcCEIySxxTL6tLno=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=3UGEO42K9c8RRpPG3N6+bXbeiHjglWcImrT05928Sd5e2wwR7jZTzCuzJAy2fiYNJ
 LfgdqXUKVECmwpEXvA+lL2MopAPS24nyHfgyZim/a4Yop+pPc002seQM2HllaPsBtd
 scA+9yRIyVRg2dg4XlR/oI6iYArhVPf1mOwujdNQ=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 29 Sep 2020 19:27:17 +0200 (CEST)
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
To: Takashi Iwai <tiwai@suse.de>, Gyeongtaek Lee <gt82.lee@samsung.com>
References: <CGME20200928105009epcas2p4a65d50d9d09800281395a490d1844ef3@epcas2p4.samsung.com>
 <000c01d69585$228db6b0$67a92410$@samsung.com>
 <7ba714ce-8b33-1b64-7503-6b155bf43909@perex.cz>
 <eaa35431-01f4-f858-0673-cc3b4ddf1c5a@linux.intel.com>
 <000f01d69603$10573fb0$3105bf10$@samsung.com> <s5ho8lpkqdv.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <e0c15222-6604-6c59-0d29-575337f7b58b@perex.cz>
Date: Tue, 29 Sep 2020 19:27:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <s5ho8lpkqdv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, lgirdwood@gmail.com,
 kimty@samsung.com, tiwai@suse.com,
 'Pierre-Louis Bossart' <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, hmseo@samsung.com, tkjung@samsung.com,
 pilsun.jang@samsung.com, s47.kang@samsung.com
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

Dne 29. 09. 20 v 9:12 Takashi Iwai napsal(a):
> On Tue, 29 Sep 2020 03:51:35 +0200,
> Gyeongtaek Lee wrote:
>>
>> On 9/28/20 11:35 PM, Pierre-Louis Bossart wrote:
>>> On 9/28/20 6:13 AM, Jaroslav Kysela wrote:
>>>> Dne 28. 09. 20 v 12:50 Gyeongtaek Lee napsal(a):
>>>>> With a stream with low bitrate, user can't pause or resume the stream
>>>>> near the end of the stream because current ALSA doesn't allow it.
>>>>> If the stream has very low bitrate enough to store whole stream into
>>>>> the buffer, user can't do anything except stop the stream and then
>>>>> restart it from the first.
>>>>> If pause and resume is allowed during draining, user experience can be
>>>>> enhanced.
>>>>
>>>> It seems that we need a new state to handle the pause + drain condition for
>>>> this case.
>>>>
>>>> With this proposed change, the pause state in drain is invisible.
>>>
>>> Indeed it's be much nicer to have a new state, e..g 
>>> SNDRV_PCM_STATE_DRAINING_PAUSED.
>> Ok. I will add the new state.
>>>
>>> One concern is that states are defined in uapi/sound/asoc.h, so wouldn't 
>>> this have impacts on userspace as well? We'd change the value of 
>>> SNDRV_PCM_STATE_LAST.
>>>
>> I also agree that adding new state and increase LAST value in the header of uapi
>> could be dangerous. So, I added it to comress_offload.h for now.
>> It could be merged into snd_pcm_state_t in someday with big changes.
>> Could you review the fixed patch below?

I don't see a big problem to improve the API, but don't forget to increase the
SNDRV_COMPRESS_VERSION, so the user space apps can check for this new behaviour.

> Hrm, this resulted in rather more complex changes than the original
> patch.  It shows that introducing yet another state is no good idea
> for this particular case.

I don't think so. The states should be isolated and it's clearly a new state
and the resulted code at least gives a commented idea, what's going on. It
seems that the compress driver state is not exported to the user space at the
moment, so I would consider this extension as harmless. We can add this state
to asound.h so the user space can be updated. We may use this state for the
standard PCM devices one day, too. It makes sense to reserve it sooner than later.

BTW: Offtopic - Why compress code returns EPERM if the state is not correct?
It's not about the permissions. The EBADFD is much better code in this case.

						Jaroslav

> 
> Since the possible application's behavior after this pause is as same
> as the normal pause (i.e. either resuming pause or dropping), I find
> it OK to take the original approach.
> 
> 
> thanks,
> 
> Takashi
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
