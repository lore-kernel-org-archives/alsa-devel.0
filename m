Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E1ED7BBA
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2026 10:45:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5000960209;
	Tue, 14 Apr 2026 12:44:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5000960209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776163502;
	bh=MXOxvUuL4jFE6NUJNlnJnpEV0LNo/7Ya+DRf7Uib6uA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a1O46lQD8m7bfENlih6NTiQeOmC7KUdwqCmVvZjcTQ/2BM/WZbJ8iiiKci6qLKVbA
	 pL1Qb+8vEINGZWmRdIwcldSwvqcpgeYCoMEZjvkGFQL8kegZOViS3TqzDSpd6+7pB1
	 D09QwXnEOG8UkCMGI4VtyI4wG2UuRHwrSmy0DzAI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3D26F805F1; Tue, 14 Apr 2026 12:44:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 418CBF805EE;
	Tue, 14 Apr 2026 12:44:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6302EF80510; Tue, 14 Apr 2026 12:44:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A16F0F8003C
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2026 12:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A16F0F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=K4Joo1Ei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776163457; x=1807699457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXOxvUuL4jFE6NUJNlnJnpEV0LNo/7Ya+DRf7Uib6uA=;
  b=K4Joo1EikzYtQWjDNL62WRbAsOINnYeTomHSV+ueyUoV2cHmOAc0ERSe
   sogQhiyjTbu72kakM2WWenrj6uHnRBQwNwv3nZ7/KqRJdByfMm/geCel4
   FTROp/7ULczio9xFHc8rLbRbxkK86LlvoZY4nuK+eVBcXHBTVZrVIqG9b
   jpBMIzJV2XFms5P9BWlB1dexfcfzV0QOgWyU4+Wivef6KR0T1/tIfrmHb
   zvXhC60gEiPtITm8n6dhfHi9loCW8yhjr7uVR2LtNu6jTVos3j62IrH4K
   g6wEwJ0jFE3RMH6x59HsuZyTO/KXocJL8UKCuIF9s8Z4fE9uBgCOTf0nN
   A==;
X-CSE-ConnectionGUID: jn7InAEaTTihiUkOR+H92Q==
X-CSE-MsgGUID: luNwwfE9TzuIK2/2aKgAzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="102572856"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000";
   d="scan'208";a="102572856"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 03:44:11 -0700
X-CSE-ConnectionGUID: ErDDo80IRHeU5G8ctGTckg==
X-CSE-MsgGUID: MQqlDED7Rouha3WZTmVl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000";
   d="scan'208";a="230285140"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.121])
 ([10.245.245.121])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 03:44:09 -0700
Message-ID: <542a9743-2a47-477a-b457-ae32c3f8dc49@linux.intel.com>
Date: Tue, 14 Apr 2026 13:44:34 +0300
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
 <b97ae6b9-ef72-4dbf-bf29-9092ec3919d8@linux.intel.com>
 <82d870b3-4ec1-440a-ae8b-87edbf665b99@perex.cz>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <82d870b3-4ec1-440a-ae8b-87edbf665b99@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UT2D3NFV3WNSIQJQHULV4XOV54TGNVXM
X-Message-ID-Hash: UT2D3NFV3WNSIQJQHULV4XOV54TGNVXM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UT2D3NFV3WNSIQJQHULV4XOV54TGNVXM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 07/04/2026 16:50, Jaroslav Kysela wrote:
>>> The minimal requirement for the playback data at start would be:
>>>
>>>      'init_chunk + (2 * step_chunk)'
>>>
>>> Note that init_chunk may be zero (legacy PCI HW).
>>
>> and step_chunk as well.
>
> step_chunk should start from one sample. But there are chunks (bursts)
> even for PCI devices, although very small.

What I meant is that drivers might report 0 for both when they don't
have this quirk in operation - and existing drivers.

>>> In my proposal, step_chunk == period_size and init_chunk will be
>>> provided using additional value in hw_params (as count of initial
>>> periods).
>>
>> I don't think this would work without breaking user space. Locking the
>> period size to be the size of a step_chunk?
>> In SOF the default PCM device have 1ms step_chunk and it can have
>> maximum of 256 periods (HDA BDLE constraint).
>
> The drivers can use period size in multiples of base transfer (step)
chunk.

They could if we lock the chunk_step as static, but if it is adapting to
the period size then we cannot.
the hardware have practical limit of 100ms maximum FIFO size.
"low latency' user will request 5ms period size and get 5ms FIFO size
period size 50ms will result 50ms FIFO size
period size 100ms will result 100ms FIFO size
period size 150ms will result 100ms FIFO size (practical limit of HW)
period size 300ms will result 100ms FIFO size (practical limit of HW)

User space asks for a period size and the driver reports back the chunk
init and size that the period size will translate to.

>> You cannot set a constraint after the hw_params has been set, that is
>> reverse of how things work, no?
>
> I expect to design new constraint describing the "base step chunk" and
> "initial chunk" in samples. Thus the refine mechanism will allow to
> settle period size based on this.

Some hardware have fixed setup, they can tell what the chunk init/size
is, it is constant, some (what I try to do for SOF) can adapt the chunk
configuration based on how userspace asks for the period_size.

On the other hand: there might be a use case when application wants
certain chunk size - jumpiness - while using 'detached' period size,
like 40ms chunks and 100ms periods (or 120ms if we want chunk multiple).
This is another type of config, but I would leave it for later and have
either the fixed chunk hardware and the adaptive supported.

>> Also the original issue that initiated the thread was that we had a
>> fixed 96ms hw transfer with 100ms FIFO coming as a fixed preset.
>> This caught application wanting to have 10/20/30/40/50ms of period size
>> on guard...
>
> 100ms init = 25 periods / 96ms step = 24 periods with period size 4ms.
> This means that we need
>
> 1) add step fill (in periods) like for init fill returned from driver
to app

but this will break existing applications, they don't know that they
need to provide 24 periods data.

> 2) or the driver (if possible) should prefer that init chunk is in
> multiple of step chunk - it's hw related restriction or just buffer size
> judgement from the developer POV for SOF?

I think this can be doable for SOF, if the FIFO / init_chunk is 'small'
we can make it about double of the step_chunk.
However these are not written in stone, the step_chunk for example might
fluctuate depending on system latencies for DSP wakeup.

>> The issue is different from hardware/kernel and user space pow.
>> - hardware
>> [A] it has no buffering or really minimal (few frames to keep the bus
>> fed)
>> [B] have fixed size FIFO with fixed sized bursting equal to the FIFO
>> size - relatively large FIFO
>> [C] have fixed size FIFO with different initial and runtime bursts
>> [D] have configurable FIFO and the the relation between initial and
>> runtime burst can fall into [B] or [C] depending on FIFO size, the FIFO
>> is scaling with the period size (to some limit in most cases)
>>
>> - applications
>> [1] uses ALSA period as processing unit
>> [2] uses NO_PERIOD_WAKEUP and ignores period size as processing unit.
>
> I'm also trying to resolve the deep buffer issue. And we should not use
> NO_PERIOD_WAKEUP as hint that applications don't do better transfer
> granularity IMHO.

I agree, on the other hand the NO_PERIOD_WAKEUP is added precisely for
this purpose, to detach applications from ALSA period based scheduling.

> The interface should be universal. This flag is just
> to not inform user space that the period was processed. Dot.

Sure, applications can leave out this flag and still just NOP on period
elapsed.

>> I think the two new parameter for init_chunk and step_chunk within
>> hw_params returned from driver to user space  should cover this well.
>
> My idea was just to reuse the current mechanism to settle transfer
> chunks, so applications can give advice, how the PCM buffer will be used
> (based on the period size and the granularity flag). See my proposal.

Some hardware cannot negotiate the size of FIFO, thus the init and step
chunk, some might be able to do so.
These ask for different solution.
If it is fixed then what drivers are already doing is fine, they set
constraint on period size to force applications, but applications still
have no way of knowing that the DMA is jumpy. This only works with no
frills applications, sound servers are not in this category.

> How you would like to handle this in an universal way?

I think both could be handled by driver provided init_chunk and
step_chunk value:
1. in open the fixed FIFO hardware sets constraint for period size, the
dynamic one can set for the minimum size as well.
2. application asks for buffer configuration, refining narrows it down
and settles.
3. driver fills in the init and step chunk info - fixed uses the fixed
numbers, dynamic uses the calculated one based on period size or
something else.
4a. application checks the init and step chunk and decides on strategy
4b. legacy applications will work as they work atm

Then we can figure out if there is a need for detaching the chunk
configuration from period size with a new value where applications can
ask for specific chunk setup with unmatched period size (small chunks
with bigger period sizes, big chunks with smaller period sizes).

It would be great to hear from PW guys on this as they would be the
primary users at first...

-- 
Péter

