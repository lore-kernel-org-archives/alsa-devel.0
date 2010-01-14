From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Thu, 14 Jan 2010 11:37:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001141133500.4324@eeebox2.perex-int.cz>
References: <30985164.282301263465059783.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B739610386C
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 11:37:10 +0100 (CET)
In-Reply-To: <30985164.282301263465059783.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Jan 2010, ANISH KUMAR wrote:

>> mmap is supported by the Samsung drivers.
>
> Thanks for this information which i overlooked.
>> This looks like the dmix data rates are getting out of sync with what
>> the hardware is doing.  Enabling CONFIG_SND_PCM_XRUN_DEBUG will produce
>> more diagnostic information from the driver side
> I got the problem and after doing the changes DMIX plugin is working 
> very fine. As you know XRUN was happening and this happening in 
> snd_pcm_update_hw_ptr_post function. This happened because 
> stop_threshold is increased suddenly(Is it done by dmix? If yes then why 
> ?) ?????? In normal condtions this would have been fine but in my code i 
> was multiplying it by some amount causing it to wrap 
> around(stop_threshold=0 );Causing XRUN.So i just removed this 
> multiplying factor.

For dmix, the stop_threshold should be equal to boundary value, thus XRUN 
check should never be true. If you got xrun with dmix, something is wrong.

> One more Rate conversion query: ./alsa_aplay -v 
> -D"plug:'dmix:RATE=44100'" bond.wav Playing WAVE 'bond.wav' : Unsigned 8 
> bit, Rate 11025 Hz, Mono Plug PCM: Rate conversion PCM (44100, 
> sformat=U8) As you can see bond.wav is sampled at 11025k but when i am 
> playing with Plug PCM there is some noise in the song why????Is rate 
> conversion algoritm not able to resample it properly?

The default linear resampler is not very good quality. You may use some 
sox resamplers from the alsa-plugins package, but they're more CPU 
intensive. Check google.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
