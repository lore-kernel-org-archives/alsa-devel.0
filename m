Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71509FEEF38
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 13:51:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E14C601F0;
	Tue,  7 Apr 2026 15:51:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E14C601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775569890;
	bh=w5jJg6+Bu4PtV+S0pAU0YS0gz3efTssLRx8JTIPMApw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HuBxuiWDBLCWYjKCeyOP/NiktPLgkjR7nmCF/a6X7nZ0RvGTnGtdjaO0ZeHN4BP1Y
	 ulytbMW3jsmfHqatff6V/B6SndB267MH5vo82QJ7u3T+Uxwzqk/m3RbMbvU+E3V0Hy
	 +U9hXOO6UFlxb09POpeCa/R2rwxl1KipVzaw5gwU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49DA8F80154; Tue,  7 Apr 2026 15:50:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA47AF80154;
	Tue,  7 Apr 2026 15:50:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1AECF80548; Tue,  7 Apr 2026 15:50:46 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 895A4F80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 15:50:40 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 198B13A227;
	Tue,  7 Apr 2026 15:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 198B13A227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1775569840; bh=ukzcyocYr5kR8pDPyQCBzQOvkXVuPaTenMZdDkzDyJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0SSIaZmQOtmrLjnsqnxQQk2d4RsFA10w+u8PoDV2p9wrm7DOzgI8SWmBfRWY6TLs
	 wyHeXP/O1ZEAO/RCoLZZyW1B/oFE+02G/cAwTSl41cYxG+JfB3k/K6S99u4kRMx8ZR
	 n1uXm+lc/CTx5keMxMHNGe/02DY6TgAkCnlchHcc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue,  7 Apr 2026 15:50:27 +0200 (CEST)
Message-ID: <82d870b3-4ec1-440a-ae8b-87edbf665b99@perex.cz>
Date: Tue, 7 Apr 2026 15:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arun@asymptotic.io,
 wim.taymans@gmail.com
References: <a03350b3-5828-4ffe-ade7-b94bb6ec7d64@linux.intel.com>
 <87se9htms4.wl-tiwai@suse.de>
 <67b9f48b-1cc7-4dac-8f6a-c0cba6a84b36@linux.intel.com>
 <87ikadtgpe.wl-tiwai@suse.de>
 <dadef18b-1c2e-4c0d-8ae8-2e4b8ad75d04@linux.intel.com>
 <878qb8tsib.wl-tiwai@suse.de> <88979231-caef-4eaa-b89d-22e6973c92f9@perex.cz>
 <cfb84df3-c2bf-4173-bc45-7df29b6a94a3@linux.intel.com>
 <a1b6b2ed-2e26-48ff-afab-60f90ecc4360@perex.cz>
 <4c73e4cb-298a-411a-97ed-f0eff1b06ac9@linux.intel.com>
 <978bdc67-b91e-437a-bb8a-b609a4fef6d1@perex.cz>
 <b97ae6b9-ef72-4dbf-bf29-9092ec3919d8@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <b97ae6b9-ef72-4dbf-bf29-9092ec3919d8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MINVPR4NWEEQ4AJJDAPW2RYZBH43YBLP
X-Message-ID-Hash: MINVPR4NWEEQ4AJJDAPW2RYZBH43YBLP
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MINVPR4NWEEQ4AJJDAPW2RYZBH43YBLP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 4/7/26 13:59, Péter Ujfalusi wrote:

>> We need definitely a handshake (app<->kernel) for this, but the question
>> is, if just going back to honor the period sizes properly from the user
>> space applications is a right way to go or not. IMHO it may be just a
>> clarification for the current mechanism.
>>
>> In any case we need those extensions:
>>
>> Kernel -> user space:
>>
>> - give the initial transfer chunk size to user space
>> - give the next (step) transfer chunk size to user space
>>
>> The minimal requirement for the playback data at start would be:
>>
>>      'init_chunk + (2 * step_chunk)'
>>
>> Note that init_chunk may be zero (legacy PCI HW).
> 
> and step_chunk as well.

step_chunk should start from one sample. But there are chunks (bursts) even 
for PCI devices, although very small.

>> In my proposal, step_chunk == period_size and init_chunk will be
>> provided using additional value in hw_params (as count of initial periods).
> 
> I don't think this would work without breaking user space. Locking the
> period size to be the size of a step_chunk?
> In SOF the default PCM device have 1ms step_chunk and it can have
> maximum of 256 periods (HDA BDLE constraint).

The drivers can use period size in multiples of base transfer (step) chunk.

>> User space -> kernel:
>>
>> - notification that the code honors period sizes + initial periods and
>> uses period size to ask kernel for requested latency (keeping the
>> current behavior for older binaries; and to allow drivers to do optimal
>> setup)
>> - request for low hw_ptr granularity (to use e.g. deep buffers) -
>> basically okay, we don't care, the "BATCH" transfer mode with whole
>> periods is okay
>>
>> Example (with the "honor period size" handshake activated):
>>
>> 20ms latency goal, 4ms hw transfers, 12ms initial hw buffer
>>
>> -> set period size to 10ms or less
>>       # 2 periods must be filled to avoid an initial xrun
>> -> set buffer size to 30ms or more
>> <- get 8 periods x 4ms
>> <- 3 initial periods (3*4ms = 12ms)
>>
>> suggested initial fill = 12ms + 2 * 4ms ; 20ms total
>>
>> The driver (constraints setup) should take account the initial periods
>> in this case.
> 
> You cannot set a constraint after the hw_params has been set, that is
> reverse of how things work, no?

I expect to design new constraint describing the "base step chunk" and 
"initial chunk" in samples. Thus the refine mechanism will allow to settle 
period size based on this.

> Also the original issue that initiated the thread was that we had a
> fixed 96ms hw transfer with 100ms FIFO coming as a fixed preset.
> This caught application wanting to have 10/20/30/40/50ms of period size
> on guard...

100ms init = 25 periods / 96ms step = 24 periods with period size 4ms. This 
means that we need

1) add step fill (in periods) like for init fill returned from driver to app
2) or the driver (if possible) should prefer that init chunk is in multiple of 
step chunk - it's hw related restriction or just buffer size judgement from 
the developer POV for SOF?

> The issue is different from hardware/kernel and user space pow.
> - hardware
> [A] it has no buffering or really minimal (few frames to keep the bus fed)
> [B] have fixed size FIFO with fixed sized bursting equal to the FIFO
> size - relatively large FIFO
> [C] have fixed size FIFO with different initial and runtime bursts
> [D] have configurable FIFO and the the relation between initial and
> runtime burst can fall into [B] or [C] depending on FIFO size, the FIFO
> is scaling with the period size (to some limit in most cases)
> 
> - applications
> [1] uses ALSA period as processing unit
> [2] uses NO_PERIOD_WAKEUP and ignores period size as processing unit.

I'm also trying to resolve the deep buffer issue. And we should not use 
NO_PERIOD_WAKEUP as hint that applications don't do better transfer 
granularity IMHO. The interface should be universal. This flag is just to not 
inform user space that the period was processed. Dot.

> I think the two new parameter for init_chunk and step_chunk within
> hw_params returned from driver to user space  should cover this well.

My idea was just to reuse the current mechanism to settle transfer chunks, so 
applications can give advice, how the PCM buffer will be used (based on the 
period size and the granularity flag). See my proposal. How you would like to 
handle this in an universal way?

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
