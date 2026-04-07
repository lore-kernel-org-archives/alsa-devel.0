Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A4BFEEF2A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:59:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6418601F9;
	Tue,  7 Apr 2026 13:59:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6418601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775563192;
	bh=3tXsjiklJaUOBHFWWiZTXANwM26vlwTBQyEWm4ZgkP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PksgywRnEC0Bjk037Ts1LPukSpzmKGnZk8T5rdvdbVkFf4F2rQ9nFhXt6/NVeM3GE
	 70WAEzce+nlK+byGc5e2itoEcCvSmdBOKpXymPztZILGBtjFKyxseMg9vCB5G8EkLE
	 P3jWz7XfYE8CknOa5mRwkdFysO8/fmecTVExDNfU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74B20F805E8; Tue,  7 Apr 2026 13:59:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11529F805F1;
	Tue,  7 Apr 2026 13:59:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4AF81F80548; Tue,  7 Apr 2026 13:59:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85B7CF8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 13:59:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85B7CF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BIfgsTcF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775563146; x=1807099146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3tXsjiklJaUOBHFWWiZTXANwM26vlwTBQyEWm4ZgkP0=;
  b=BIfgsTcFyRczBQ3ATjE/I+itcoReVkxkWxyNNxWk/LVIajIEKj4YwmgT
   MOvL8fq4qTK1nQOZtCMdhQffbejRlyJ1AJtmE97mkxCdEuMLOAuRCYRlU
   YtDGJig6jr/39ELGvh9lUQeSCSovBCwkRZt38/06bq8FRSEx0KQO3AgOU
   CMh5d28CVh6capQ+oDes1CBz8gICFTx0qSYa/IofGkpBzyAM3kyJtfBAv
   3cd73D2/oSEWUhYQwh3lOeyKywFzHssRLwJXJNz99P9EtywWY4ch+BisT
   zrxSP62os3/44BOvk1JJ3B1CsZ+YlccRKTS+3gbNI38IdJ5f1MiUZIkNJ
   A==;
X-CSE-ConnectionGUID: v1iIvz85TRe0de5+8xopng==
X-CSE-MsgGUID: 1UzjGSalRxiUHoh0kn6K9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99150618"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000";
   d="scan'208";a="99150618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 04:58:59 -0700
X-CSE-ConnectionGUID: OGrHscG7QoOQBR1Rq0BFDA==
X-CSE-MsgGUID: ThUZXkxgSC+vaY7WBVIxmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000";
   d="scan'208";a="227151915"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.104])
 ([10.245.244.104])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 04:58:58 -0700
Message-ID: <b97ae6b9-ef72-4dbf-bf29-9092ec3919d8@linux.intel.com>
Date: Tue, 7 Apr 2026 14:59:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (re)use and (re)definition of snd_pcm_hw_params->fifo_size for
 'jumpy DMA'
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
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
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <978bdc67-b91e-437a-bb8a-b609a4fef6d1@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Y6BMJO2PKNLIO54SBKJND7PIXVFI4IC4
X-Message-ID-Hash: Y6BMJO2PKNLIO54SBKJND7PIXVFI4IC4
X-MailFrom: peter.ujfalusi@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y6BMJO2PKNLIO54SBKJND7PIXVFI4IC4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 02/04/2026 15:01, Jaroslav Kysela wrote:
>> But with a static-DB and locking t he period size to the DB size would
>> prevent bigger period size use and even with bigger period size, if
>> the DB size is 'small' then the power efficiency is out of the window.
>> But, if we increase the static-DB size then we limit the minimum
>> period size to scale down.
> 
> It's safe to allow bigger periods from the driver which are multiple of
> the DB size.

But that is the thing, this is not always true for every configuration.
4ms DB with 1ms runtime steps for example.

> But apps should be aware about the information which area (e.g. period)
> is current so they should avoid to work in this area, if system task
> scheduling is probably going to interrupt this realtime data feed.
> 
> Basically, originally we took the periods as the base transfer block in
> API design. The period size and the filled count of periods (playback)
> gave the latency (of course without additional FIFO in hw path - just
> for the CPU <-> HW path).

But then came the NO_PERIOD_WAKEUP (if I recall Android and Pipewire
were the ones to push for this and use it).
This concept kind of superseded the period size as scheduling unit
paradigm, but still it was expecting the DMA to move in continuous and
small steps - preferably in max frame sizes.

>>> We may have those configurations (* = future when driver tells the
>>> initial count of queued periods):
>>>
>>
>>>   period | period count | init_periods  | minimal data latency |
>>> --------+--------------+---------------+----------------------+---------
>>>   4ms    | 4            | unsettled (1) | 4ms                  |
>>> realtime
>>> *4ms    | 200          | 25            | 100ms                | semi-
>>> realtime
>>>   1000ms | 2            | 1             | 1000ms               | pwr
>>> efficient
>>
>> SOF specific, but we limit the period size to be min 8ms to unbrake
>> pipewire to avoid xzrun on start and xrun handling and to hint
>> application what is safe.
> 
> And it's the whole problem. You are trying to solve a problem caused
> with the situation that applications do not know about those constraints.

What we do is not unique among the systems that do have jumpy-DMA, they
all constrain the min period size.
The drivers forbid user space to use something which will fail on start.

The difference here is that we want to have a solution which could cover
all devices and systems.
Afaik all 'solutions' atm are product specific or the device is special
cased. We could do this with PW for SOF and call it a day ;)
That does not  scale...

The Nokia n9 had a PCM device with a codec which could suck up 128ms of
audio and play it from it's own memory (tlv320dac33), it has kcontrol
for user space to set the FIFO thresholds and modes and a modified
pulseaudio to understand this.

> But current PW behaviour is based on "assumption" that the data are
> processed in small chunks from the PCM buffer. And this assumption is
> not true for SOF while it worked perfectly for legacy HDA and all simple
> PCI (even ISA :-)) sound hardware. Also the initial transfer at the
> stream start is different. And I think that USB / FireWire serial buses
> are in similar situation. I saw workaround (special settings) in PW for
> those cases, too.

Yes, USB/FW audio sets the SNDRV_PCM_INFO_BLOCK_TRANSFER and PW looks at
the devices and if it see that BLOCK_TRANSFER is set and  the device is
USB/FW then it sort of ignores it, uses custom headroom (I think doubles
the period size for it) and ignores the interrupts.

We could stamp SOF as BLOCK_TRANSFER device (which it is not) and extend
the special casing from USB/FW to include SOF, could work. But then you
will add a new QC device or AMD device or.

>>> The timer based queuing should just help to feed data more frequently,
>>> but it does not mean that applications should not set the period size
>>> based on the requirements. Ideally, everything should be coordinated -
>>> period sizes with proper sample feed timing from the application side.
>>
>> Right, but, but, in normal PCM of SOF, the ShallowBuffer is 4ms, we
>> cannot set constraint for the period size to be min and max 4ms, that
>> would xrun right away.
> 
> The xrun happens just because application do not push data to the next
> period in time, right?

This is what we have seen, yes, PW provides minimal - even less than
period size - amount of data and then things fail.
Interestingly PA on the same hardware appears to work fine. I guess it
is not that aggressive?

>> And this would just bring in the issue of the static DB that we have,
>> if it is big, then applications would break if they want smaller periods.
> 
> We need definitely a handshake (app<->kernel) for this, but the question
> is, if just going back to honor the period sizes properly from the user
> space applications is a right way to go or not. IMHO it may be just a
> clarification for the current mechanism.
> 
> In any case we need those extensions:
> 
> Kernel -> user space:
> 
> - give the initial transfer chunk size to user space
> - give the next (step) transfer chunk size to user space
> 
> The minimal requirement for the playback data at start would be:
> 
>     'init_chunk + (2 * step_chunk)'
> 
> Note that init_chunk may be zero (legacy PCI HW).

and step_chunk as well.

> In my proposal, step_chunk == period_size and init_chunk will be
> provided using additional value in hw_params (as count of initial periods).

I don't think this would work without breaking user space. Locking the
period size to be the size of a step_chunk?
In SOF the default PCM device have 1ms step_chunk and it can have
maximum of 256 periods (HDA BDLE constraint).

> User space -> kernel:
> 
> - notification that the code honors period sizes + initial periods and
> uses period size to ask kernel for requested latency (keeping the
> current behavior for older binaries; and to allow drivers to do optimal
> setup)
> - request for low hw_ptr granularity (to use e.g. deep buffers) -
> basically okay, we don't care, the "BATCH" transfer mode with whole
> periods is okay
> 
> Example (with the "honor period size" handshake activated):
> 
> 20ms latency goal, 4ms hw transfers, 12ms initial hw buffer
> 
> -> set period size to 10ms or less
>      # 2 periods must be filled to avoid an initial xrun
> -> set buffer size to 30ms or more
> <- get 8 periods x 4ms
> <- 3 initial periods (3*4ms = 12ms)
> 
> suggested initial fill = 12ms + 2 * 4ms ; 20ms total
> 
> The driver (constraints setup) should take account the initial periods
> in this case.

You cannot set a constraint after the hw_params has been set, that is
reverse of how things work, no?

Also the original issue that initiated the thread was that we had a
fixed 96ms hw transfer with 100ms FIFO coming as a fixed preset.
This caught application wanting to have 10/20/30/40/50ms of period size
on guard...

The issue is different from hardware/kernel and user space pow.
- hardware
[A] it has no buffering or really minimal (few frames to keep the bus fed)
[B] have fixed size FIFO with fixed sized bursting equal to the FIFO
size - relatively large FIFO
[C] have fixed size FIFO with different initial and runtime bursts
[D] have configurable FIFO and the the relation between initial and
runtime burst can fall into [B] or [C] depending on FIFO size, the FIFO
is scaling with the period size (to some limit in most cases)

- applications
[1] uses ALSA period as processing unit
[2] uses NO_PERIOD_WAKEUP and ignores period size as processing unit.

I have access to setups which falls into [C] currently, these are SOF
based systems and would like to support [D].

[B] and [C] must place constraint on minimum period size (and they do)
to forbid smaller period sizes then the FIFO to avoid xrun on start.
Both [1] and [2] type of application works fine: [1] always proved at
least 2x period data (which is bigger than the min_size), [2] is tricky,
but they also need to do the same (PW now does).
Applications are free to request as big period as they want, the min
size (which is a constraint based on the fixed FIFO size) will guide them.

Switching the driver to [D] is no issue for applications of type [1],
they provide 2x periods and they don't really if the DMA will jump.
The problem is with [2] type, they only know the minimum period size
which has nothing to how the hw_ptr will behave with bigger period sizes.
At the moment we are not exposing the PCM device which would do this, we
need something which scales for as much devices and configs as possible.

I think the two new parameter for init_chunk and step_chunk within
hw_params returned from driver to user space  should cover this well.

- driver sets min_period_size/time constraint as the lowest FIFO size
(already done)
- user space configures whatever period/buffer size it wants.
- driver sets the init/step chunks to the configuration that it ended up
with the setup, or continue to not set it.
- user space checks if the chunk config is 0 -> use period size min as a
guidance, if they are not 0, use the information to set up the safety
headroom.

>> BTW, should we still keep the dynamic DeepBuffer as a way from the
>> kernel to do things automatically? It will allow unaware ALSA
>> applications to gain this for free, but it needs information to be
>> given to clever ones (like PW) on how to deal with the jumps.
> 
> It's difficult to suggest something for this problem when the specific
> application does not give any hint to the kernel space about future API
> calls and expected use (if they will do rewind for example in future).
> We need properly document everything related to the transfers and let
> applications to choose between "expect data change soon" and "buffering"
> behaviour IMHO.
> 
> And definitely, we should not do optimizations related to single app -
> choose specific period size just because pipewire does not work
> correctly (speaking about the clarified API) - in the drivers.

Certainly!
We could have gone to the “We’ll handle it in a clever way.” path for
SOF, but that would be counter productive for everyone, including us ;)

-- 
Péter

