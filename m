From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: [PATCH] add number of periods constraint to
	snd-aoa [try 3]
Date: Fri, 23 Nov 2007 22:55:15 +0200
Message-ID: <47473E33.1040805@cs.helsinki.fi>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>	
	<1195822183.4149.118.camel@johannes.berg>
	<s5h63ztt6uu.wl%tiwai@suse.de>
	<1195849391.4149.154.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh05.mail.saunalahti.fi (emh05.mail.saunalahti.fi
	[62.142.5.111]) by alsa0.perex.cz (Postfix) with ESMTP id 11C26246E5
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 21:55:19 +0100 (CET)
In-Reply-To: <1195849391.4149.154.camel@johannes.berg>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Johannes Berg kirjoitti:
> On Fri, 2007-11-23 at 14:43 +0100, Takashi Iwai wrote:
>> At Fri, 23 Nov 2007 13:49:42 +0100,
>> Johannes Berg wrote:
>>>> +	if (err < 0) {
>>>> +		result = err;
>>>> +		goto out_unlock;
>>>> +	}
>>>>  	list_for_each_entry(cii, &sdev->codec_list, list) {
>>>>  		if (cii->codec->open) {
>>>>  			err = cii->codec->open(cii, pi->substream);
>>>
>>> So what I'm not sure on... Why do we see the same behaviour with other
>>> drivers? Same bug?
>> Which driver?  It should be fixed as well, then.
> 
> snd-usb-audio I think. Was there any further debugging between you two
> that I missed? with the dummy driver?

I sent everything to everyone :) I tried the dummy driver, and it did 
produce all kinds of funny results, but nothing unexpected, being that 
its timing source is quite inaccurate.

-- hl
