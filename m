From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: AC97 slot information
Date: Mon, 30 Nov 2009 12:03:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911301141430.14639@eeebox2.perex-int.cz>
References: <20091129165058.GA15959@n2100.arm.linux.org.uk>
	<s5hpr709vog.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DF23024471
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 12:03:52 +0100 (CET)
In-Reply-To: <s5hpr709vog.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Nov 2009, Takashi Iwai wrote:

> At Sun, 29 Nov 2009 16:50:58 +0000,
> Russell King - ARM Linux wrote:
>>
>> When opening an AC'97 codec under ALSA using snd_ac97_pcm_open(),
>> specifying the number of channels desired (2, 4 or 6) is there a
>> way to read back which slots will be in use?
>
> Hm, a quick look through the code, there seems no such way right now.
> Actually, slots subsets are determined in snd_ac97_pcm_assign(), and
> the open function just accepts the reduced slots in there.
>
>> Currently, in the AACI driver, I use a lookup table to convert from
>> channels to a slot mask - if this information is already available
>> from ALSA, I'd much rather use it rather than inventing keeping my
>> own solution.
>>
>> Also, should the 'slots' value passed to snd_ac97_pcm_open() be
>> those in pcm->r[].slots or should it be selected from the number
>> of channels?
>
> pcm->r[].slots, I suppose.  Well, but snd_ac97_pcm_open() behaves a
> bit differently from what I thought.  It doesn't check cfg value
> (usually the number of channels (2, 4 or 6) is passed) to reduce the
> assigned slots, so it'll try always the full slots.  Then reducing
> the slots bits in the caller look mandatory right now...
>
> Jaroslav, is it the intended behavior, or just a missing piece?

The slot management is left to the lowlevel driver - see ac97_pcm_defs in 
intel8x0.c driver for example (all slots are configured in the 
snd_ac97_pcm_open() call - even if less channels are requested). The cfg 
value is not used for channel count handling (because we really do not 
know the ac97 slot -> real channel position mapping in the universal ac97 
routines - it depends how the ac97 controller is set). Actually, I don't 
have any idea to simplify this mapping and if it's worth to add handling 
of this mapping to the AC97 driver tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
