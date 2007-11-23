From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: [PATCH] add number of periods constraint to
	snd-aoa [try 3]
Date: Fri, 23 Nov 2007 15:30:40 +0200
Message-ID: <4746D600.1080800@cs.helsinki.fi>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
	<1195822183.4149.118.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
	[62.142.5.107]) by alsa0.perex.cz (Postfix) with ESMTP id D4CC924671
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 14:30:44 +0100 (CET)
In-Reply-To: <1195822183.4149.118.camel@johannes.berg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Johannes Berg kirjoitti:
> On Fri, 2007-11-23 at 14:25 +0200, Heikki O Lindholm wrote:
>> From: Heikki Lindholm <holindho@cs.helsinki.fi>
>>
>> The aoa driver is not specifying constraints on number of periods, and, it 
>> seems, it might end with a non-integer number, which it cannot deal with. 
>> Fix by adding a proper constraint.
>>
>> Signed-off-by: Heikki Lindholm  <holindho@cs.helsinki.fi>
>> ---
>> try 3: fixed coding style
>>
>> diff -r 1b54a8725ded aoa/soundbus/i2sbus/i2sbus-pcm.c
>> --- a/aoa/soundbus/i2sbus/i2sbus-pcm.c	Wed Nov 14 17:07:17 2007 +0100
>> +++ b/aoa/soundbus/i2sbus/i2sbus-pcm.c	Fri Nov 23 14:16:07 2007 +0200
>> @@ -194,6 +194,12 @@ static int i2sbus_pcm_open(struct i2sbus
>>  	hw->period_bytes_max = 16384;
>>  	hw->periods_min = 3;
>>  	hw->periods_max = MAX_DBDMA_COMMANDS;
>> +	err = snd_pcm_hw_constraint_integer(pi->substream->runtime,
>> +						SNDRV_PCM_HW_PARAM_PERIODS);
> 
> Personally, I prefer that indented to just after the opening
> parenthesis.
> 
> ;)
> 
>> +	if (err < 0) {
>> +		result = err;
>> +		goto out_unlock;
>> +	}
>>  	list_for_each_entry(cii, &sdev->codec_list, list) {
>>  		if (cii->codec->open) {
>>  			err = cii->codec->open(cii, pi->substream);
> 
> 
> So what I'm not sure on... Why do we see the same behaviour with other
> drivers? Same bug?

I'd guess so. As I said, I couldn't reproduce the bug on the x86 
machines I tried. Anyways, the constraint system of ALSA being quite 
complex and the fact that buffer size and period size/number of periods 
are separated in ALSA do seem a like an open invitation to bugs like this.

-- Heikki Lindholm
