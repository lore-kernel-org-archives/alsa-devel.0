From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 1/2] ASoC: SOF: introduce
 no_stream_position so host_period_bytes preserves its data
Date: Tue, 30 Jul 2019 18:03:47 -0500
Message-ID: <c15cf1db-3858-8694-bcb4-3665c2f0c6b2@linux.intel.com>
References: <9d92551a-fa10-4ecd-47f1-5b3b67824a12@linux.intel.com>
 <0b20cfe6-064b-a4ce-ce9d-2634f3f23d7c@linux.intel.com>
 <5fda90f9-c387-440a-9ea8-648b22dda9b0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB0A0F80482
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2019 01:03:49 +0200 (CEST)
In-Reply-To: <5fda90f9-c387-440a-9ea8-648b22dda9b0@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rajwa, Marcin" <marcin.rajwa@linux.intel.com>, marcin.rajwa@intel.com, Keyon Jie <yang.jie@linux.intel.com>, ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> Change the use of host_period_bytes. So far this field was used
>>> as an bool value indicating whether FW should send stream position
>>> update. With this patch we use host_period_bytes to provide firmware
>>> information about the frequency of host interrupts aimed to read
>>> its input buffer. This is accoring to ALSA definition of 'FramePeriod'.
>>
>> according to the
>>
>>> Knowing this firmware can safely copy large/irregular chunks of data
>>
>> why irregular? ALSA periods are pretty regular and predictable.
> 
> I did not say ALSA periods are irregular I said that sometimes (like in 
> case of draining) firmware needs to copy irregular amount of that.
> 
> What I mean by "irregular" is not equal to ALSA period or multiple of 
> periods.

Marcin, in the v2 review this is what we discussed. The formatting may 
be off so please refer to the emails directly should this be difficult 
to read:

"
 >>>
 >>> Before I provide more feedback, can you clarify if the 
'host_period_bytes' is the same value as the ALSA period size (in 
bytes)? And what would be the value when the no_irq mode is used?
 >>
 >> Yes, this is the same value. It is obtained by 
*params_period_bytes**()* in kernel.
 >
 > ok good. I was afraid this would be a different concept.
 >
 > So what you are saying is that the draining happens by bursts whose 
size is tied to the period defined by the host, yes?
Yes. We try to fill host buffer as much as we can to gain fast draining 
but in the same time we give host time to read it.
"

I cannot reconcile the two threads, is the draining tied to the ALSA 
period size or not?

Care to clarify?

> 
>>
>>> (like data comming from i.e draining task) without the risk of buffer
>>
>> coming
>>
>> Please proof-read your commit messages (and use an editor which 
>> spell-checks for you), typos and misleading information don't exactly 
>> boost trust in the suggested patch, regardless of its merits.
> 
> 
> Sorry for typos. Should I correct them and resend again or correct here 
> as we discuss?


better send a v5 when we've clarified what the 'irregular' wording 
refers to.
