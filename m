From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: semantics of SNDRV_PCM_INFO_BATCH (was: Re: safe
	support for rewind in ALSA
Date: Tue, 9 Mar 2010 10:46:54 +0800
Message-ID: <4f3252891003081846t255a8cb5qeee0bee836e5256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0D05E24150
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 03:46:55 +0100 (CET)
Received: by pvg16 with SMTP id 16so1846137pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Mar 2010 18:46:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Hi,

>> On Sun, 21 Feb 2010, Lennart Poettering wrote:

>>>> But you can query the SNDRV_PCM_INFO_BATCH flag (it's set by e.g. the USB
>>>> driver) and adjust your hrtimer-based application's logic based on that
[...]
>>>>> This mean that the wake up time cannot be calculated using as number of
>>>>> sample/rate since the fuction is not linear especially when using max buffer
>>>>> size , min period --> max period size is much greater than the watermark
>>>>
>>>> Yep, that's what SNDRV_PCM_INFO_BATCH flag warns you about.
>>>
>>> Hmm, could you elaborate a little about SNDRV_PCM_INFO_BATCH? What
>>> exactly does that mean in general and especially for the timer based
>>> audio scheduling?
>>>
>>> I am currently not making use of this, but should I?

>>I'm also looking at this topic from an application developer perspective,
>>so I can only provide you my interpretation of reading current ALSA code,
>>but here goes.

>>I'll also add Eliot (who asked about the same thing, in
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025262.html <http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025262.html>
>> ) to the cc, and also Takashi, who git-annotate reveals has made most
>> recent PCM_INFO_BATCH related changes to linux/sound/core/pcm_lib.c. ;)

>> Anyway, SNDRV_PCM_INFO_BATCH is set by following drivers:
>>   - isa/msnd
>>   - pcii/bt87x
>>   - pci/korg1212
>>   - pcmcia/pdaudiocf
>>   - soc/au1x
>>   - soc/fsl (mpc52xx/8610)
>>   - sparc/dbri
>>   - usbaudio

>> Common to all these drivers is that audio samples are moved to/from the
>> ALSA ringbuffer, in bursts, to an intermediary block of memory, and from
>> there to/from the codec. And most importantly, pointer callback is based
>> on last ack'ed burst. IOW, hw_ptr jumps in bursts with these drivers and
>> granularity of hw_ptr is more coarse (affecting snd_pcm_avail(),
>> snd_pcm_delay() and so forth).

>> Now the existing documentation for the flag (and user-space
>> snd_pcm_hw_params_is_batch() API) is rather brief as you've noted, and
>> AFAIK very few apps use these, so I'm not sure, how much we as app
>> developers should rely on these semantics (and to the fact that future
>> drivers will use the BATCH flag in a similar way).

>> But anyways, the fact remains that snd_pcm_hw_params_is_batch() exists,
>> and based on a review of current (2.6.33-rc) drivers, majority/all of the
>> drivers use the flag in the same way.

>> So for apps like PA, snd_pcm_hw_params_is_batch() is a hint that app
>> should not rewind closer to hw_ptr than period-size. It also hints that
>> hw_ptr granularity is more coarse, which might be useful in setting sane
>> defaults for buffer watermarks and such.


if you look at PA src/modules/alsa/alsa-sink.c ,

PA try to use pa_smoother_translate() to solve the derviation of audio
clock and system clock.
this function assume two clocks montonic increase , I wonder that
routine can really work if the value returned by pointer call back is
a stepping function for usb driver

i.e. PA expect the hw_ptr increase at a steady rate but usb can only
return the number of urb sent


            if (u->use_tsched) {
                pa_usec_t cusec;

                if (u->since_start <= u->hwbuf_size) {

                    /* USB devices on ALSA seem to hit a buffer
                     * underrun during the first iterations much
                     * quicker then we calculate here, probably due to
                     * the transport latency. To accommodate for that
                     * we artificially decrease the sleep time until
                     * we have filled the buffer at least once
                     * completely.*/

                    if (pa_log_ratelimit())
                        pa_log_debug("Cutting sleep time for the
initial iterations by half.");
                    sleep_usec /= 2;
                }

                /* OK, the playback buffer is now full, let's
                 * calculate when to wake up next */
/*                 pa_log_debug("Waking up in %0.2fms (sound card
clock).", (double) sleep_usec / PA_USEC_PER_MSEC); */

                /* Convert from the sound card time domain to the
                 * system time domain */
                cusec = pa_smoother_translate(u->smoother,
pa_rtclock_now(), sleep_usec);
