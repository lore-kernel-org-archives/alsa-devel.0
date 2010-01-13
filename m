From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Wed, 13 Jan 2010 08:20:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001130803290.4324@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
	<4f3252891001102011l603d30cdlbe2a14163bbc7405@mail.gmail.com>
	<alpine.LNX.2.00.1001110814310.4210@eeebox2.perex-int.cz>
	<4f3252891001122258j5c3bd7c5u7184cad199f5cf40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E2A11038C3
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 08:20:37 +0100 (CET)
In-Reply-To: <4f3252891001122258j5c3bd7c5u7184cad199f5cf40@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Jan 2010, Raymond Yau wrote:

> 2010/1/11 Jaroslav Kysela <perex@perex.cz>
>
>> On Mon, 11 Jan 2010, Raymond Yau wrote:
>>
>>  2010/1/7 Jaroslav Kysela <perex@perex.cz>
>>>
>>>  On Wed, 6 Jan 2010, pl bossart wrote:
>>>>
>>>>
>>>>
>>>> The improved and more clean fix in now in my tree:
>>>>
>>>>
>>>>
>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6
>>>>
>>>> Note that you should apply these 4 patches (in reverse order):
>>>>
>>>> 4: ALSA: pcm_lib - optimize wake_up() calls for PCM I/O
>>>> 3: ALSA: pcm_lib - cleanup & merge hw_ptr update functions
>>>> 2: ALSA: pcm_lib - add possibility to log last 10 DMA ring buffer
>>>> positions
>>>> 1: ALSA: pcm_lib.c - convert second xrun_debug() parameter to use defines
>>>>
>>>> Patch #3 should definitely fix problems with large avail or delay values
>>>> reported in PA. I finally figured the culprit (and decide to cleanup all
>>>> relevant code rather do just another workaround). In other words, new
>>>> hw_ptr pointer should never be less than previous one now.
>>>>
>>>>                                               Jaroslav
>>>>
>>>> -
>>>>
>>>>
>>> using alsa-driver-1.0.22.1.1.g231e3.14.g812cb and Fedora 12 inside Virtual
>>> Box
>>>
>>> aplay -D plughw:0,0 /usr/share/sounds/alsa/*.wav
>>>
>>> "Front Left" sound as "Front Front Left" when playing "Front_left.wav"
>>>
>>> only when echo 4 > /proc/asound/card0/pcm0p/xrun_debug
>>>
>>
>> Thanks for testing.
>>
>> It means that with other values is no sound generated?
>>
>> Could you use value 29 for xrun_debug and report all sound related messages
>> from dmesg output after playback of "Front_left.wav"?
>>
>>                                        Jaroslav
>>
>> -----
>
>
>
> do you mean 27 instead of 29 since the echo only occur when the value
> contain XRUN_DEBUG_JIFFIESCHECK  bit  ?
>
> aplay -Dplughw:0,0 and mplayer -ao alsa:device=hw=0,0 work normal
>
> except when the value of xrun_debug contain XRUN_DEBUG_JIFFIESCHECK  bit  (
> same result for the three  virtual box audio backend oss, pulseaudio and
> alsa )

Ok, I understand now. It would be better to use value 101 then - to see 
last 10 ring buffer positions when jiffies correction occurs. Also, 
get latest snapshot - there is a fix for jiffies check. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
