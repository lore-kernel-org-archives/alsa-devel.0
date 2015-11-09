From: Caleb Crome <caleb@crome.org>
Subject: Re: Alsa Crackling Noise
Date: Mon, 9 Nov 2015 07:29:28 -0800
Message-ID: <CAG5mAdxXe9FbMv4FDYkFHWSVv5ABA1=S_fqEQhFGn_tuKuycpQ@mail.gmail.com>
References: <CAGX90YUOKi4rSJvbTUGCzTow6tgtoBkkRhYuzdYqnnzLcComtg@mail.gmail.com>
 <CAG5mAdz-xNGHi_TU4Y+pRT2tiZ9TEbxqZA8PcGtGi52VgKGOUw@mail.gmail.com>
 <CAGX90YX+PtNYrcBkcn_f+_cdOPT8raQc1Xe6HMSfK=H5G6FPOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 1956A2605DC
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 16:29:47 +0100 (CET)
Received: by wmnn186 with SMTP id n186so110169032wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2015 07:29:47 -0800 (PST)
In-Reply-To: <CAGX90YX+PtNYrcBkcn_f+_cdOPT8raQc1Xe6HMSfK=H5G6FPOQ@mail.gmail.com>
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

On Fri, Nov 6, 2015 at 9:27 AM, Dinesh Ravindran <rite2dinesh@gmail.com> wrote:
> The USB soundcard natively supports the sampling rate of 8kHz. We tried with
> all three options of the kernel preemption model, and it doesn't make any
> difference. The CPU utilization is almost zero, and interestingly when the
> CPU consumption is high the audio sounds better(we notice when we copy a
> file via ssh, cpu consumption goes upto 33%).
>
> The default premption model is set to none, however we tried with both
> voluntary and Low-Latency Desktop, it doesn't make any difference.
>
> One thing we noticed was that even though from our application(or aplay) we
> set the access to SND_PCM_ACCESS_RW_INTERLEAVED,
> /proc/asound/card0/pcm0p/sub0/hw_params shows it as MMAP_INTERLEAVED, we're
> not sure why it is so and what the impact could be.
>
> Does it has to do with the low level USB transfer, where it it waiting for
> more data to transfer it in one shot,  because, at higher sampling rate we
> have more data to transfer. But it still doesn't explain why printing some
> debug statements or having a larger alsa buffer works.
>
>

That is certainly strange.  Sorry I don't know how to help.  Perhaps
somebody else can shed some light.

-Caleb



>
>
> best regards
> Dinesh
>
> On Fri, Nov 6, 2015 at 5:37 PM, Caleb Crome <caleb@crome.org> wrote:
>>
>> On Fri, Nov 6, 2015 at 1:59 AM, Dinesh Ravindran <rite2dinesh@gmail.com>
>> wrote:
>> > We have been facing a weird issue with Alsa recently. Sometimes the
>> > audio
>> > plays out with out any noise and sometimes it has lot of cracking noise,
>> > really a lot. The weird situation is when another application is
>> > printing
>> > out some debug statements to a console it sounds good. The behavior is
>> > same
>> > with a custom developed alsa application and also with aplay. Any
>> > thoughts?
>> > If we have a really big buffer size of around 2sec it works somehow, but
>> > we
>> > really want to analyze why alsa exhibits this strange behavior. Is it
>> > the
>> > alsa itself or is it just a symptom of a bigger issue at system level?
>> >
>> > All the test we are carrying out it at 8KHz, at higher sampling
>> > rate(48k)
>> > we do not see this behaviour.
>> >
>> >
>> > These are the scenarios in which it sounds good:
>> > 1. If any application is printing to the console while audio is being
>> > played out or even just holding the return button on the console helps.
>> > 2. If we enable xrun debug with echo 29 >
>> > /proc/asound/card0/pcm0p/xrun_debug it sounds good.
>> > 3. If we have really big buffer size around 2 seconds.
>> > 4. Or sometimes on fresh start of the machine until it enters xrun state
>> > once.
>> >
>> >
>> >
>> > We have the following setup:
>> >
>> > Processor: ARM926EJ-S
>>
>> What's your CPU utilization when playing 8kHz?  It's interesting that
>> 48kHz has no problem, but 8kHz does.  My first guess would be that
>> alsa is forced to resample in software, causing the cpu load to go up.
>>    Do you know what rates your actual codec can run at?
>>
>> Others on this list are infinitely more likely to know the true answer :-)
>>
>> Another question: what's the preemption model in your kernel config?
>> under kernel features->Preemption model?  You can also check your
>> .config for CONFIG_PREEMPT=y
>>
>> -Caleb
>>
>> > Kernel: 3.14.53
>> > Alsa-lib: 1.0.29
>> > Alsa-Util: 1.0.29
>> > Audio Chip: CONEXANT USB AUDIO
>> >
>> >> aplay -Dplughw:0,0 8kz_8000.wav  #to play file
>> >
>> >
>> > cat /proc/asound/card0/stream0
>> > ----------------------------------------
>> >
>> > Playback:
>> >   Status: Stop
>> >   Interface 2
>> >     Altset 1
>> >     Format: S16_LE
>> >     Channels: 2
>> >     Endpoint: 1 OUT (ADAPTIVE)
>> >     Rates: 8000, 16000, 24000, 32000, 44100, 48000
>> >
>> > Hw params:
>> > --------------
>> >
>> > access: MMAP_INTERLEAVED
>> > format: S16_LE
>> > subformat: STD
>> > channels: 2
>> > rate: 8000 (8000/1)
>> > period_size: 1000
>> > buffer_size: 4000
>> >
>> > sw params:
>> > -------------
>> >
>> > tstamp_mode: NONE
>> > period_step: 1
>> > avail_min: 1000
>> > start_threshold: 4000
>> > stop_threshold: 4000
>> > silence_threshold: 0
>> > silence_size: 0
>> > boundary: 2097152000
>> >
>> > status:
>> > --------
>> >
>> > state: RUNNING
>> > owner_pid   : 1852
>> > trigger_time: 3667.436640852
>> > tstamp      : 3756.680343977
>> > delay       : 3296
>> > avail       : 720
>> > avail_max   : 1000
>> > -----
>> > hw_ptr      : 712720
>> > appl_ptr    : 716000
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
