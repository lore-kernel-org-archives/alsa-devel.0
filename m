From: Caleb Crome <caleb@crome.org>
Subject: Re: Alsa Crackling Noise
Date: Fri, 6 Nov 2015 08:37:25 -0800
Message-ID: <CAG5mAdz-xNGHi_TU4Y+pRT2tiZ9TEbxqZA8PcGtGi52VgKGOUw@mail.gmail.com>
References: <CAGX90YUOKi4rSJvbTUGCzTow6tgtoBkkRhYuzdYqnnzLcComtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id D8ED92604E2
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 17:37:45 +0100 (CET)
Received: by wimw2 with SMTP id w2so33833592wim.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Nov 2015 08:37:45 -0800 (PST)
In-Reply-To: <CAGX90YUOKi4rSJvbTUGCzTow6tgtoBkkRhYuzdYqnnzLcComtg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dinesh Ravindran <rite2dinesh@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 6, 2015 at 1:59 AM, Dinesh Ravindran <rite2dinesh@gmail.com> wrote:
> We have been facing a weird issue with Alsa recently. Sometimes the audio
> plays out with out any noise and sometimes it has lot of cracking noise,
> really a lot. The weird situation is when another application is printing
> out some debug statements to a console it sounds good. The behavior is same
> with a custom developed alsa application and also with aplay. Any thoughts?
> If we have a really big buffer size of around 2sec it works somehow, but we
> really want to analyze why alsa exhibits this strange behavior. Is it the
> alsa itself or is it just a symptom of a bigger issue at system level?
>
> All the test we are carrying out it at 8KHz, at higher sampling rate(48k)
> we do not see this behaviour.
>
>
> These are the scenarios in which it sounds good:
> 1. If any application is printing to the console while audio is being
> played out or even just holding the return button on the console helps.
> 2. If we enable xrun debug with echo 29 >
> /proc/asound/card0/pcm0p/xrun_debug it sounds good.
> 3. If we have really big buffer size around 2 seconds.
> 4. Or sometimes on fresh start of the machine until it enters xrun state
> once.
>
>
>
> We have the following setup:
>
> Processor: ARM926EJ-S

What's your CPU utilization when playing 8kHz?  It's interesting that
48kHz has no problem, but 8kHz does.  My first guess would be that
alsa is forced to resample in software, causing the cpu load to go up.
   Do you know what rates your actual codec can run at?

Others on this list are infinitely more likely to know the true answer :-)

Another question: what's the preemption model in your kernel config?
under kernel features->Preemption model?  You can also check your
.config for CONFIG_PREEMPT=y

-Caleb

> Kernel: 3.14.53
> Alsa-lib: 1.0.29
> Alsa-Util: 1.0.29
> Audio Chip: CONEXANT USB AUDIO
>
>> aplay -Dplughw:0,0 8kz_8000.wav  #to play file
>
>
> cat /proc/asound/card0/stream0
> ----------------------------------------
>
> Playback:
>   Status: Stop
>   Interface 2
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 1 OUT (ADAPTIVE)
>     Rates: 8000, 16000, 24000, 32000, 44100, 48000
>
> Hw params:
> --------------
>
> access: MMAP_INTERLEAVED
> format: S16_LE
> subformat: STD
> channels: 2
> rate: 8000 (8000/1)
> period_size: 1000
> buffer_size: 4000
>
> sw params:
> -------------
>
> tstamp_mode: NONE
> period_step: 1
> avail_min: 1000
> start_threshold: 4000
> stop_threshold: 4000
> silence_threshold: 0
> silence_size: 0
> boundary: 2097152000
>
> status:
> --------
>
> state: RUNNING
> owner_pid   : 1852
> trigger_time: 3667.436640852
> tstamp      : 3756.680343977
> delay       : 3296
> avail       : 720
> avail_max   : 1000
> -----
> hw_ptr      : 712720
> appl_ptr    : 716000
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
