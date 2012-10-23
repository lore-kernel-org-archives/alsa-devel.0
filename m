From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Passing audio info from HDMI EDID beside speaker
 allocation
Date: Tue, 23 Oct 2012 17:56:33 -0500
Message-ID: <508720A1.80208@linux.intel.com>
References: <506E832C.50702@codeaurora.org> <s5hzk3xjryl.wl%tiwai@suse.de>
 <508589A2.4080309@codeaurora.org> <s5hmwzdids6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BEFBD262626
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2012 00:56:47 +0200 (CEST)
In-Reply-To: <s5hmwzdids6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: arun.raghavan@collabora.co.uk, Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>>> In the case of HD-audio, it's passed via the normal IEC958 status bits
>>> controls separately.  ELD itself is exposed as a byte array in a
>>> control element, but it's read-only.
>>
>> Thanks for the reply. Couple more questions
>>
>> 1. Is kcontrol "ELD" being read directly by application or there is
>> ALSA library API to parse the information.
>
> Nothing so far.  It's just a raw data.
>
>> 2. Also, I see you submit this patch [PATCH 3/3] ELD proc interface for
>> HDMI sinks in 2008. I presume it's just for information purpose. You
>> still expect application to query for HDMI sink capability through
>> "ELD" kcontrol. Am I correct?
>
> It's not prohibited for apps to parse the proc interface but it's not
> guaranteed to be stable :)  So yes, parsing ELD manually would be a
> safer way.

I wrote some code to parse the ELD kcontrol to enable passthrough if AC3 
is supported by the receiver, I believe it's been integrated by Arun in 
a branch of PulseAudio. It's probably 1 year old now..
